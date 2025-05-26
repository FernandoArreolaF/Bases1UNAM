import psycopg2 
import matplotlib.pyplot as plt
def graficarIngresosMensuales(listM, listIng, numSuc):
    # Tema oscuro
    plt.style.use('dark_background')
    fig, ax = plt.subplots()
    
    bar_colors = ['tab:red', 'tab:blue', 'tab:red', 'tab:green', 'tab:red',
                'tab:blue', 'yellow', '#F5F5DC', '#00BFBF', '#FFFFFF',
                'tab:red', 'tab:green']

    ax.bar(listM, listIng, color=bar_colors)

    ax.set_ylabel('Ingresos (MXN)')
    ax.set_title(f'Ingresos mensuales de la sucursal {numSuc}')

    # Cuadrícula activada
    ax.grid(True, color='gray', linestyle='--', linewidth=0.5)

    # Mejoras de presentación
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()


try:
    connection=psycopg2.connect(
        host='34.51.13.255', 
        user='paul',
        database='postgres',
        password= 'contraseña_paul',
        port = '5432' 
    )

    print('Conexion exitosa') 
    cursor=connection.cursor()
    cursor.execute( "SELECT version()") 
    row= cursor.fetchone()
    print(row) 
    cursor.execute('SELECT * FROM ingresos_mensuales')
    rows=cursor.fetchall()
    ingresos=[]
   
   #Obtencion de datos
   
    #Sucursal
    numeroSuc = int(rows[0][0])
    print('Numero sucursal:', numeroSuc)
    
    #Columna ingresosMensuales
    for row in rows:
        columnaIngDec= row[3]
        if columnaIngDec is not None: 
            ingresos.append(float(columnaIngDec)) 
        else:
            print('Valor null presente')
            pass
    
    #Creacion lista de meses
    meses= ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo',
            'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre',
            'Noviembre', 'Diciembre']
    
    
    print(ingresos)
    
except Exception as ex:
    print(ex)

finally: 
    connection.close()
    print("Conexion finalizada") 
       
graficarIngresosMensuales(meses, ingresos, numeroSuc)



