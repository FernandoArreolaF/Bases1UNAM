from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from datetime import datetime, timedelta

#Configuración básica de reintentos en caso de que la base de datos esté apagada
default_args = {
    'owner': 'equipo_restaurante',
    'retries': 1,
    'retry_delay': timedelta(minutes=2),
}

# Definición del flujo de trabajo
with DAG(
    dag_id='ingesta_diaria_ordenes',
    default_args=default_args,
    start_date=datetime(2026, 5, 29), # Fecha de inicio
    schedule_interval='@daily',       # Se ejecutará una vez al día
    catchup=False,
    tags=['restaurante', 'extraccion_txt'],
) as dag:

    #Tarea única: Conectarse a Postgres y ejecutar tu PROCEDURE
    ejecutar_procedimiento = PostgresOperator(
        task_id='cargar_ordenes_desde_txt',
        postgres_conn_id='postgres_default',
        sql="CALL pr_cargar_ordenes_desde_txt('/home/sara_espinosa/airflow/datos_restaurante/ordenes.txt');"
    )