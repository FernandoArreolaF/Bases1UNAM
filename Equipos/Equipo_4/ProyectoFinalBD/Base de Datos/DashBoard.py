import psycopg2
from psycopg2 import sql

def get_monthly_income_by_branch(year):
    #Conexión a base de datos
    conn = psycopg2.connect(
        dbname="papubases",            #Poner nombre de la base
        user="postgres",               #Usuario del manejador
        password=" ",  #Contraseña
        host="localhost",
        port=" "
    )
    
    #Cursor, objeto que funciona como puntero entre python y postgres
    cursor = conn.cursor()
    
    try:
        #Declaración de consulta en lenguaje SQL para obtener la información de ventas en cierto año
        query = sql.SQL("""
            SELECT 
                s.v_clave_suc AS sucursal,
                EXTRACT(MONTH FROM v.d_fecha) AS mes,
                SUM(v.n_monto_total) AS ingresos
            FROM 
                venta v
            #Une los detalles de venta, empleado y sucursal para después sacar el año ingresado
            JOIN 
                venta_empleado ve ON v.v_folio = ve.v_venta_folio
            JOIN 
                empleado e ON ve.n_empleado_clave_emp = e.n_clave_emp
            JOIN 
                sucursal s ON e.v_sucursal_clave_suc = s.v_clave_suc
            WHERE 
                EXTRACT(YEAR FROM v.d_fecha) = %s
            GROUP BY 
                s.v_clave_suc, EXTRACT(MONTH FROM v.d_fecha)
            ORDER BY 
                s.v_clave_suc, mes;
        """)
        
        #Ejecución de la consulta con el cursor
        cursor.execute(query, (year,))
        results = cursor.fetchall()
        
        #Diccionario
        income_data = {}
        
        for sucursal, mes, ingresos in results:
            if sucursal not in income_data:
                income_data[sucursal] = {m: 0 for m in range(1, 13)}  #Inicializar todos los meses con 0
            income_data[sucursal][int(mes)] = float(ingresos)

        return income_data

    except Exception as e:
        print(f"Error al ejecutar la consulta: {e}")
        return {}
    
    #Sentencia que siempre se ejecuta, cierra la conexión con la base y el cursor después de extraer todo
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    year = int(input("Ingrese el año a consultar (solo hay info en 2023 y 2024): "))
    monthly_income = get_monthly_income_by_branch(year)
    
    #Impresión del diccionario
    print("\nIngresos mensuales por sucursal:")
    for sucursal, meses in monthly_income.items():
        print(f"\nSucursal: {sucursal}")
        for mes, ingreso in meses.items():
            print(f"Mes {mes}: ${ingreso:,.2f}")

    #Ya con todo con diccionarios, se graficará fácil con matplotlib