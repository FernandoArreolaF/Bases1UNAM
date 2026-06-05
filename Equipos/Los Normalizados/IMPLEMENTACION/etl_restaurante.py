from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import csv
import psycopg2

# 1. Credenciales para AMBAS bases de datos
# Base Origen (Neon)
NEON_HOST = "ep-small-resonance-apwnxel5-pooler.c-7.us-east-1.aws.neon.tech"
NEON_DB = "neondb"
NEON_USER = "neondb_owner"
NEON_PASS = "npg_Eon2g0CbYQpX"

# Base Destino (Tu PostgreSQL 18 local)
RES_HOST = "localhost"
RES_DB = "reserva_restaurante"
RES_USER = "postgres"  # Ajusta si tu usuario es diferente
RES_PASS = "Rodrigo14" # La contraseña que usas para pgAdmin

def procesar_ventas():
    # Abrir AMBAS conexiones
    try:
        conn_neon = psycopg2.connect(host=NEON_HOST, database=NEON_DB, user=NEON_USER, password=NEON_PASS)
        conn_reserva = psycopg2.connect(host=RES_HOST, database=RES_DB, user=RES_USER, password=RES_PASS)
        
        cur_neon = conn_neon.cursor()
        cur_reserva = conn_reserva.cursor()
    except Exception as e:
        print("Error conectando a las bases de datos:", e)
        return
        
    archivo_csv = '/opt/airflow/dags/ventas_diarias.csv'
    
    with open(archivo_csv, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        
        for fila in reader:
            folio, num_mesero = fila['folio'], fila['num_mesero']
            id_cliente, id_producto = fila['id_cliente'], fila['id_producto']
            cantidad, porcentaje_pago, monto_pago = fila['cantidad'], fila['porcentaje_pago'], fila['monto_pago']
            
            try:
                # Iniciamos punto de guardado en la base de DESTINO (reserva_restaurante)
                cur_reserva.execute("SAVEPOINT renglon_actual;")
                
                # INSERTAR en la base de DESTINO
                cur_reserva.execute("""
                    INSERT INTO orden (folio, num_mesero) 
                    VALUES (%s, %s) ON CONFLICT (folio) DO NOTHING;
                """, (folio, num_mesero))
                
                cur_reserva.execute("""
                    INSERT INTO detalle_orden (folio, id_producto, cant_prod) 
                    VALUES (%s, %s, %s);
                """, (folio, id_producto, cantidad))
                
                cur_reserva.execute("""
                    INSERT INTO pago (folio, id_cliente, porcentaje_pago, monto_pago) 
                    VALUES (%s, %s, %s, %s) ON CONFLICT (folio, id_cliente) DO NOTHING;
                """, (folio, id_cliente, porcentaje_pago, monto_pago))
                
                cur_reserva.execute("RELEASE SAVEPOINT renglon_actual;")
                print(f"Éxito: Folio {folio} migrado a reserva_restaurante")
                
            except Exception as e:
                cur_reserva.execute("ROLLBACK TO SAVEPOINT renglon_actual;")
                print(f"ATRAPADO: Error en folio {folio}: {e}")
                
    # Confirmar cambios en el destino
    conn_reserva.commit()
    
    # Cerrar todo
    cur_neon.close(); conn_neon.close()
    cur_reserva.close(); conn_reserva.close()

# Configuración del DAG
with DAG('etl_corte_caja_restaurante', start_date=datetime(2023, 1, 1), schedule=None, catchup=False) as dag:
    tarea_procesar = PythonOperator(
        task_id='leer_e_insertar_ventas',
        python_callable=procesar_ventas
    )