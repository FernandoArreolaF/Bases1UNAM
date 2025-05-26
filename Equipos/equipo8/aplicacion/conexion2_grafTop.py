import psycopg2 
import matplotlib.pyplot as plt

def graficarIngresosMensuales(nombreA, numeroA, cantArtTot):
 
    # — Colores para cada slice —
    colors = ["#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3", "#a6d854"]

    fig, ax = plt.subplots(figsize=(6, 6), subplot_kw=dict(aspect="equal"))

    # Suma del top5
    sumaTop = sum(numeroA)

    # Pie chart:
    wedges, texts, autotexts = ax.pie(
        numeroA,
        colors=colors,
        startangle=90,
        # pct es % sobre S5; para % sobre cantArtTot multiplicamos por S5/cantArtTot
        autopct=lambda pct: f"{pct * sumaTop / cantArtTot:.1f}%",
        pctdistance=0.7,           # distancia del % al centro
        textprops=dict(color="white", weight="bold")
    )

    # Leyenda a la derecha
    ax.legend(
        wedges, nombreA,
        title="Artículos",
        loc="center left",
        bbox_to_anchor=(1, 0, 0.3, 1)
    )

    # Título
    ax.set_title("Top 5 artículos vs. ventas totales", pad=20)

    plt.tight_layout()
    plt.show()

#########
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
    cursor.execute('SELECT * FROM topArticulos')
    rows=cursor.fetchall()
   
   #Obtencion de datos
    nombreArticulos= []
    numeroArt= []
    cantidadArticulosVendidosTotal = 0
    #Columna nombreArt
    for row in rows:
        columnaArt= row[0]
        if columnaArt is not None: 
            nombreArticulos.append((columnaArt)) 
        else:
            print('Valor null presente')
            pass
    
    #Columna numeroArtVend
    for row in rows:
        columnaNumeroArt= row[1]
        if columnaNumeroArt is not None: 
            numeroArt.append(int(columnaNumeroArt)) 
        else:
            print('Valor null presente')
            pass
        
    #Numero de articulos vendidos en total
    cursor.execute('SELECT SUM(cantidad_articulo_venta) FROM articulo_venta')
    resultado_suma = cursor.fetchone() # fetchone() porque SUM() devuelve una sola fila con un solo valor

    cantidadArticulosVendidosTotal = 0 # Valor por defecto si la tabla está vacía o todos son NULL

    if resultado_suma and resultado_suma[0] is not None:
        cantidadArticulosVendidosTotal = int(resultado_suma[0])
        
    print(f"La suma total de cantidad_articulo_venta (calculada por SQL) es: {cantidadArticulosVendidosTotal}")
            
except Exception as ex:
    print(ex)

finally: 
    connection.close()
    print("Conexion finalizada") 

graficarIngresosMensuales(nombreArticulos, numeroArt, cantidadArticulosVendidosTotal)
