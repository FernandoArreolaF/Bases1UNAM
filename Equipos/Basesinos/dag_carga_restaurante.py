from datetime import datetime
from pathlib import Path
import os
import subprocess

from airflow.decorators import dag, task

BASE_DIR = Path("/home/javi/restaurante_airflow")
DATA_DIR = BASE_DIR / "data"
SQL_DIR = BASE_DIR / "sql"

EXPORT_SQL = SQL_DIR / "s-07-exportar.sql"
LOAD_SQL = SQL_DIR / "s-08-cargar.sql"

DB_ORIGEN = "restaurante_dia"
DB_DESTINO = "restaurante_final"

TABLAS = [
    "estado",
    "categoria",
    "empleado",
    "cliente",
    "producto",
    "administrativo",
    "cocinero",
    "dependiente",
    "mesero",
    "telefono_empleado",
    "orden",
    "orden_producto",
    "factura",
]


def construir_comando_psql(base_datos: str):
    return [
        "sudo",
        "-n",
        "-u",
        "postgres",
        "psql",
        "-d",
        base_datos,
        "-v",
        "ON_ERROR_STOP=1",
    ]


def ejecutar_comando(comando):
    resultado = subprocess.run(
        comando,
        text=True,
        capture_output=True,
        env=os.environ.copy(),
    )

    if resultado.returncode != 0:
        raise RuntimeError(
            "Error ejecutando comando:\n"
            f"COMANDO:\n{comando}\n\n"
            f"STDOUT:\n{resultado.stdout}\n\n"
            f"STDERR:\n{resultado.stderr}"
        )

    print(resultado.stdout)
    return resultado.stdout


def ejecutar_archivo_sql(base_datos: str, archivo_sql: Path):
    comando = construir_comando_psql(base_datos)
    comando.extend(["-f", str(archivo_sql)])
    return ejecutar_comando(comando)

@dag(
    dag_id="dag_carga_restaurante",
    start_date=datetime(2026, 1, 1),
    schedule=@daily,
    catchup=False,
    tags=["restaurante", "postgresql", "csv"],
)
def carga_restaurante():

    @task
    def preparar_directorios():
        DATA_DIR.mkdir(parents=True, exist_ok=True)
        SQL_DIR.mkdir(parents=True, exist_ok=True)

        if not EXPORT_SQL.exists():
            raise FileNotFoundError(f"No existe el archivo: {EXPORT_SQL}")

        if not LOAD_SQL.exists():
            raise FileNotFoundError(f"No existe el archivo: {LOAD_SQL}")

        print(f"Directorio de datos: {DATA_DIR}")
        print(f"Directorio SQL: {SQL_DIR}")
        print(f"Script de exportación: {EXPORT_SQL}")
        print(f"Script de carga: {LOAD_SQL}")
        print("Directorios preparados correctamente.")

    @task
    def exportar_csv_desde_restaurante_dia():
        print("Exportando datos desde restaurante_dia hacia archivos CSV...")
        ejecutar_archivo_sql(DB_ORIGEN, EXPORT_SQL)
        print("Exportación finalizada correctamente.")

    @task
    def verificar_csv_generados():
        faltantes = []

        for tabla in TABLAS:
            archivo = DATA_DIR / f"{tabla}.csv"

            if not archivo.exists():
                faltantes.append(str(archivo))

        if faltantes:
            raise FileNotFoundError(
                "Faltan los siguientes archivos CSV:\n" + "\n".join(faltantes)
            )

        print("Todos los archivos CSV fueron generados correctamente.")

    @task
    def cargar_csv_en_restaurante_final():
        print("Cargando archivos CSV en restaurante_final...")
        ejecutar_archivo_sql(DB_DESTINO, LOAD_SQL)
        print("Carga finalizada correctamente.")

    inicio = preparar_directorios()
    exportar = exportar_csv_desde_restaurante_dia()
    verificar = verificar_csv_generados()
    cargar = cargar_csv_en_restaurante_final()

    inicio >> exportar >> verificar >> cargar


dag_carga_restaurante = carga_restaurante()