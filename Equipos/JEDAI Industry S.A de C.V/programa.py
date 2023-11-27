import tkinter as tk
from tkcalendar import Calendar, DateEntry
from tkinter import filedialog
import psycopg2
from psycopg2 import sql
from PIL import Image, ImageTk
import io

# Crear conexión a la base de datos
conn = psycopg2.connect(
    dbname="restaurante",
    user="postgres",
    password="system",
    host="localhost"  # Cambia esto si tu servidor está en otro lugar
)
cur = conn.cursor()
productos_seleccionados = []
seleccion_numero_empleado = None 
entrada_mesa = None


def obtener_alimentos_disponibles():
    try:
        cur.execute("""
            SELECT id_platillo AS id_alimento, nombre, 'platillo' AS tipo, precio FROM platillo
            UNION ALL
            SELECT id_bebida AS id_alimento, nombre, 'bebida' AS tipo, precio FROM bebida
        """)
        alimentos_disponibles = cur.fetchall()
        return alimentos_disponibles
    except Exception as e:
        print(f"Error al obtener alimentos disponibles: {e}")
        return []

def obtener_numeros_mesero():
    try:
        cur.execute("SELECT Num_empleado FROM empleado WHERE Num_empleado = 1")
        numeros_mesero = [num_empleado[0] for num_empleado in cur.fetchall()]
        return numeros_mesero
    except Exception as e:
        print(f"Error al obtener los números de mesero: {e}")
        return []
def mostrar_orden(numero_folio):
    try:
        cur.execute("""
            SELECT numero_mesa, d.id_alimento, a.nombre, d.cantidad
            FROM detalle_orden d
            INNER JOIN alimentos a ON d.id_alimento = a.id_alimento
            WHERE d.folio_orden = %s
        """, (numero_folio,))
        orden = cur.fetchall()
        
        if orden:
            ventana_pedido = tk.Toplevel()
            ventana_pedido.title(f"Pedido - Folio {numero_folio}")
            
            # Mostrar el número de mesa
            label_mesa = tk.Label(ventana_pedido, text=f"Número de Mesa: {orden[0][0]}")
            label_mesa.pack()

            # Mostrar los productos y cantidades
            for item in orden:
                nombre_producto = item[2]
                cantidad = item[3]
                label_producto = tk.Label(ventana_pedido, text=f"{nombre_producto}: {cantidad}")
                label_producto.pack()
        else:
            print("No se encontró la orden con ese folio.")

    except Exception as e:
        print(f"Error al obtener la orden: {e}")
        
def ventana_mesero():
    alimentos_disponibles = obtener_alimentos_disponibles()
    numeros_empleado = obtener_numeros_mesero()

    ventana_mesero = tk.Tk()
    ventana_mesero.title("Ventana Mesero")

    seleccion_numero_empleado = tk.StringVar(ventana_mesero)
    seleccion_numero_empleado.set(numeros_empleado[0] if numeros_empleado else "Sin empleados")

    label_numero_empleado = tk.Label(ventana_mesero, text="Selecciona el número de empleado:")
    label_numero_empleado.pack()

    menu_numeros_empleado = tk.OptionMenu(ventana_mesero, seleccion_numero_empleado, *numeros_empleado)
    menu_numeros_empleado.pack(padx=20, pady=10)

    mesa_label = tk.Label(ventana_mesero, text="Número de Mesa:")
    mesa_label.pack()
    entrada_mesa = tk.Entry(ventana_mesero)
    entrada_mesa.pack()

    nombres_alimentos = [nombre for id_alimento, nombre, tipo, precio in alimentos_disponibles]

    seleccion_alimento = tk.StringVar(ventana_mesero)
    seleccion_alimento.set(nombres_alimentos[0])

    menu_alimentos = tk.OptionMenu(ventana_mesero, seleccion_alimento, *nombres_alimentos)
    menu_alimentos.pack(padx=20, pady=10)

    cantidad_label = tk.Label(ventana_mesero, text="Cantidad:")
    cantidad_label.pack()
    entrada_cantidad = tk.Entry(ventana_mesero)
    entrada_cantidad.pack()

    productos_seleccionados = []

    def agregar_producto():
        global entrada_mesa  # Declarar entrada_mesa como global dentro de la función
        global productos_seleccionados  # Declarar productos_seleccionados como global
        numero_mesa = entrada_mesa.get()
        id_alimento = alimentos_disponibles[nombres_alimentos.index(seleccion_alimento.get())][0]
        cantidad = int(entrada_cantidad.get())
        precio_total = cantidad * alimentos_disponibles[nombres_alimentos.index(seleccion_alimento.get())][3]
        tipo_alimento = alimentos_disponibles[nombres_alimentos.index(seleccion_alimento.get())][2]

        productos_seleccionados.append({
            'id': id_alimento,
            'cantidad': cantidad,
            'precio_total': precio_total,
            'tipo': tipo_alimento
        })
        entrada_cantidad.delete(0, tk.END)
    
    boton_agregar = tk.Button(ventana_mesero, text="Agregar Producto", command=agregar_producto)
    boton_agregar.pack(pady=10)

    boton_enviar_orden = tk.Button(ventana_mesero, text="Enviar Orden", command=insertar_orden)
    boton_enviar_orden.pack(pady=20)
    
    entrada_folio = tk.Entry(ventana_mesero)
    entrada_folio.pack()

    def mostrar_orden_seleccionado():
        folio = entrada_folio.get()
        if folio:
            mostrar_orden(int(folio))
        else:
            print("Ingrese un número de folio válido.")

    boton_mostrar_orden = tk.Button(ventana_mesero, text="Mostrar Pedido", command=mostrar_orden_seleccionado)
    boton_mostrar_orden.pack()

    ventana_mesero.mainloop()
    
def mostrar_orden(numero_folio):
    try:
        cur.execute("SELECT numero_mesa, fecha_hora FROM orden WHERE folio = %s", (numero_folio,))
        orden = cur.fetchall()
        
        if orden:
            ventana_pedido = tk.Toplevel()
            ventana_pedido.title(f"Pedido - Folio {numero_folio}")
            
            # Mostrar el número de mesa
            label_mesa = tk.Label(ventana_pedido, text=f"Número de Mesa: {orden[0][0]}")
            label_mesa.pack()

            # Mostrar los productos y cantidades
            for item in orden:
                nombre_producto = item[2]
                cantidad = item[3]
                label_producto = tk.Label(ventana_pedido, text=f"{nombre_producto}: {cantidad}")
                label_producto.pack()
        else:
            print("No se encontró la orden con ese folio.")

    except Exception as e:
        print(f"Error al obtener la orden: {e}")    
def obtener_productos_seleccionados():
    return productos_seleccionados

def insertar_orden():
    global seleccion_numero_empleado, entrada_mesa, productos_seleccionados, conn, cur
    numero_empleado = seleccion_numero_empleado.get() if seleccion_numero_empleado else None
    numero_mesa = entrada_mesa.get() if entrada_mesa else None
    productos_seleccionados = obtener_productos_seleccionados()

    try:
        if numero_mesa is not None:  # Asegúrate de que numero_mesa tenga un valor
            cur.execute("INSERT INTO orden (fecha_hora, total_pagar, rfc_mesero) VALUES (NOW(), 0, %s) RETURNING folio",
                        (numero_empleado,))
            folio_orden = cur.fetchone()[0]

            for producto in productos_seleccionados:
                if producto['tipo'] == 'platillo':
                    cur.execute("INSERT INTO detalle_orden (folio_orden, id_platillo, cantidad, precio_total, mesa) VALUES (%s, %s, %s, %s, %s)",
                                (folio_orden, producto['id'], producto['cantidad'], producto['precio_total'], numero_mesa))
                elif producto['tipo'] == 'bebida':
                    cur.execute("INSERT INTO detalle_orden (folio_orden, id_bebida, cantidad, precio_total, mesa) VALUES (%s, %s, %s, %s, %s)",
                                (folio_orden, producto['id'], producto['cantidad'], producto['precio_total'], numero_mesa))

            conn.commit()
            print("Datos insertados correctamente.")

            # Ventana de confirmación con el folio de la orden y los productos seleccionados
            ventana_confirmacion = tk.Toplevel()
            ventana_confirmacion.title("Orden Enviada")

            label_folio = tk.Label(ventana_confirmacion, text=f"Folio de la Orden: {folio_orden}")
            label_folio.pack()

            label_mesa = tk.Label(ventana_confirmacion, text=f"Número de Mesa: {numero_mesa}")
            label_mesa.pack()

            for producto in productos_seleccionados:
                nombre_producto = producto['nombre']  # Asume que 'nombre' contiene el nombre del producto
                cantidad = producto['cantidad']
                label_producto = tk.Label(ventana_confirmacion, text=f"{nombre_producto}: {cantidad}")
                label_producto.pack()

        else:
            print("Número de mesa inválido. No se pudo insertar la orden.")

    except Exception as e:
        conn.rollback()
        print(f"Error al insertar en la base de datos: {e}")
        
def mostrar_orden(folio):
    try:
        cur.execute("""
            SELECT o.folio, o.fecha_hora, 
            CASE WHEN detalle.id_platillo IS NOT NULL THEN 'platillo' ELSE 'bebida' END AS tipo,
            CASE WHEN detalle.id_platillo IS NOT NULL THEN platillo.nombre ELSE bebida.nombre END AS nombre_producto,
            detalle.cantidad, detalle.mesa
            FROM orden o
            LEFT JOIN detalle_orden detalle ON o.folio = detalle.folio_orden
            LEFT JOIN platillo ON detalle.id_platillo = platillo.id_platillo
            LEFT JOIN bebida ON detalle.id_bebida = bebida.id_bebida
            WHERE o.folio %s
        """, (folio,))
        detalles_orden = cur.fetchall()

        if detalles_orden:
            ventana_detalles_orden = tk.Toplevel()
            ventana_detalles_orden.title(f"Detalles de la Orden - Folio {folio}")

            for detalle in detalles_orden:
                label_folio = tk.Label(ventana_detalles_orden, text=f"Folio: {detalle[0]}")
                label_folio.pack()
                label_fecha = tk.Label(ventana_detalles_orden, text=f"Fecha y Hora: {detalle[1]}")
                label_fecha.pack()
                label_mesa = tk.Label(ventana_detalles_orden, text=f"Mesa: {detalle[5]}")
                label_mesa.pack()
                # Agrega otras etiquetas para mostrar detalles adicionales si es necesario

        else:
            print("No se encontraron detalles para el folio ingresado.")

    except Exception as e:
        print(f"Error al obtener la orden: {e}")       
# Crear ventana principal
root = tk.Tk()
root.title("Sistema de Restaurante")

# Menú lateral
menu_lateral = tk.Frame(root, bg="lightgrey", width=200)
menu_lateral.pack(side="left", fill="y")

btn_mesero = tk.Button(menu_lateral, text="Mesero", command=ventana_mesero)
btn_mesero.pack()

def ventana_administrativo():
    global numero_empleado

    nueva_ventana = tk.Toplevel(root)
    nueva_ventana.title("Ventana Administrativo")
    # Crear un Frame para contener la etiqueta, el Entry y el botón
    frame_contenedor = tk.Frame(nueva_ventana)
    frame_contenedor.pack(padx=10, pady=10)
    # Crear un Label para el texto "Numero de empleado que desea Buscar:"
    label_buscar = tk.Label(frame_contenedor, text="Numero de empleado que desea Buscar:")
    label_buscar.grid(row=0, column=0, sticky='e')
    # Crear un Entry para ingresar texto
    numero_empleado = tk.Entry(frame_contenedor)
    numero_empleado.grid(row=0, column=1, padx=(5, 0))  # Añadir un espacio a la izquierda del Entry
    # Crear un botón para buscar el texto
    btn_buscar = tk.Button(frame_contenedor, text="Buscar", command=buscar_Empleado)
    btn_buscar.grid(row=0, column=2, padx=(5, 0))  # Añadir un espacio a la izquierda del botón

    global insert1, insert2, insert3, insert4, insert5, insert6, insert7, insert8, insert9, insert10, insert11, insert12
    # Crear un Label
    label_espacio = tk.Label(frame_contenedor, text="")
    label_espacio.grid(row=1, column=1, padx=(5, 0))
    # Crear un Label
    label_insert1 = tk.Label(frame_contenedor, text="Numero de empleado:")
    label_insert1.grid(row=2, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert1 = tk.Entry(frame_contenedor)
    insert1.grid(row=2, column=1, padx=(5, 0))
    # Crear un Label
    label_insert2 = tk.Label(frame_contenedor, text="RFC:")
    label_insert2.grid(row=3, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert2 = tk.Entry(frame_contenedor)
    insert2.grid(row=3, column=1, padx=(5, 0))
    # Crear un Label
    label_insert3 = tk.Label(frame_contenedor, text="Estado(Activo/Inactivo):")
    label_insert3.grid(row=4, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert3 = tk.Entry(frame_contenedor)
    insert3.grid(row=4, column=1, padx=(5, 0))
    # Crear un Label
    label_insert4 = tk.Label(frame_contenedor, text="CP:")
    label_insert4.grid(row=5, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert4 = tk.Entry(frame_contenedor)
    insert4.grid(row=5, column=1, padx=(5, 0))
    # Crear un Label
    label_insert5 = tk.Label(frame_contenedor, text="Colonia:")
    label_insert5.grid(row=6, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert5 = tk.Entry(frame_contenedor)
    insert5.grid(row=6, column=1, padx=(5, 0))
    # Crear un Label
    label_insert6 = tk.Label(frame_contenedor, text="Calle:")
    label_insert6.grid(row=7, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert6 = tk.Entry(frame_contenedor)
    insert6.grid(row=7, column=1, padx=(5, 0))
    # Crear un Label
    label_insert7 = tk.Label(frame_contenedor, text="Número:")
    label_insert7.grid(row=8, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert7 = tk.Entry(frame_contenedor)
    insert7.grid(row=8, column=1, padx=(5, 0))
    # Crear un Label
    label_insert8 = tk.Label(frame_contenedor, text="Nombre:")
    label_insert8.grid(row=9, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert8 = tk.Entry(frame_contenedor)
    insert8.grid(row=9, column=1, padx=(5, 0))
    # Crear un Label
    label_insert9 = tk.Label(frame_contenedor, text="Ap_paterno")
    label_insert9.grid(row=10, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert9 = tk.Entry(frame_contenedor)
    insert9.grid(row=10, column=1, padx=(5, 0))
    # Crear un Label
    label_insert10 = tk.Label(frame_contenedor, text="Ap_materno:")
    label_insert10.grid(row=11, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert10 = tk.Entry(frame_contenedor)
    insert10.grid(row=11, column=1, padx=(5, 0))
    # Crear un Label
    label_insert11 = tk.Label(frame_contenedor, text="Fecha_nac:")
    label_insert11.grid(row=12, column=0, sticky='w')
    # Crear un Entry para ingresar fecha
    insert11 = DateEntry(frame_contenedor, width=12, background='darkblue', foreground='white', borderwidth=2)
    insert11.grid(row=12, column=1, padx=(5, 0))
    # Crear un Label
    label_insert12 = tk.Label(frame_contenedor, text="Edad:")
    label_insert12.grid(row=13, column=0, sticky='w')
    # Crear un Entry para ingresar texto
    insert12 = tk.Entry(frame_contenedor)
    insert12.grid(row=13, column=1, padx=(5, 0))
    # Crear un Label
    label_insert13 = tk.Label(frame_contenedor, text="Foto:")
    label_insert13.grid(row=14, column=0, sticky='w')
    # Agregar un botón para seleccionar archivo
    btn_seleccionar_archivo = tk.Button(frame_contenedor, text="Seleccionar Foto", command=seleccionar_archivo)
    btn_seleccionar_archivo.grid(row=14, column=0, pady=(10, 0), columnspan=2)
    # Crear un botón para buscar el texto
    btn_buscar = tk.Button(frame_contenedor, text="Agregar Empleado", command=agregar)
    btn_buscar.grid(row=15, column=2, sticky='e')


def seleccionar_archivo():
    global image_data
    filename = filedialog.askopenfilename(title="Seleccionar archivo de foto", filetypes=[("Archivos de imagen", "*.png;*.jpg;*.jpeg")])
    if filename:
        with open(filename, "rb") as file:
            image_data = file.read()


def buscar_Empleado():
    numero_empleado_int = int(numero_empleado.get())

    try:
        # Establecer la conexión a la base de datos
        conn = psycopg2.connect(dbname="Proy", user="postgres", password="system", host="localhost", port=5432)

        # Crear un cursor para ejecutar consultas SQL
        cursor = conn.cursor()

        # Consulta SQL para buscar al empleado por número
        sql = f"SELECT * FROM EMPLEADO WHERE Num_empleado = {numero_empleado_int}"

        # Ejecutar la consulta
        cursor.execute(sql)

        # Obtener los resultados
        result = cursor.fetchall()

        # Mostrar la información en una nueva ventana
        mostrar_informacion(result)

    except Exception as e:
        print(f"Error al buscar el empleado: {e}")

    finally:
        # Cerrar el cursor y la conexión
        cursor.close()
        conn.close()

def agregar():
    i1 = int(insert1.get())
    i2 = insert2.get()
    i3 = insert3.get()
    i4 = int(insert4.get())
    i5 = insert5.get()
    i6 = insert6.get()
    i7 = int(insert7.get())
    i8 = insert8.get()
    i9 = insert9.get()
    i10 = insert10.get()
    i12 = int(insert12.get())
    i11 = insert11.get_date()

    try:
        # Establecer la conexión a la base de datos
        conn = psycopg2.connect(dbname="Proy", user="postgres", password="Renata510", host="localhost", port=5432)

        # Crear un cursor para ejecutar consultas SQL
        cursor = conn.cursor()

        # Consulta SQL para insertar
        insert_query = sql.SQL("INSERT INTO EMPLEADO (Num_empleado, RFC, estado, CP, colonia, calle, número, nombre, apellido_paterno, apellido_materno, fecha_nacimiento, Edad, Foto) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING Num_empleado;")
        cursor.execute(insert_query, (i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, image_data))

        # Obtener el Num_empleado devuelto
        num_empleado = cursor.fetchone()[0]
        print(f"Se ha insertado el empleado con Num_empleado: {num_empleado}")

        # Confirmar la transacción
        conn.commit()

    except Exception as e:
        print(f"Error al guardar el empleado: {e}")
        print(f"{i1}, {i2}, {i3}, {i4}, {i5}, {i6}, {i7}, {i8}, {i9}, {i10}, {i11}, {i12}")

    finally:
        # Cerrar el cursor
        cursor.close()

        # Cerrar la conexión solo si la inserción fue exitosa
        if conn:
            conn.close()


def mostrar_informacion(result):
    nueva_ventana = tk.Toplevel(root)
    nueva_ventana.title("Información del Empleado")

    if result:
        for row in result:
            # Crear etiquetas y mostrar la información
            tk.Label(nueva_ventana, text=f"Número de empleado: {row[0]}").pack()
            tk.Label(nueva_ventana, text=f"RFC: {row[1]}").pack()
            tk.Label(nueva_ventana, text=f"Estado: {row[2]}").pack()
            tk.Label(nueva_ventana, text=f"CP: {row[3]}").pack()
            tk.Label(nueva_ventana, text=f"Colonia: {row[4]}").pack()
            tk.Label(nueva_ventana, text=f"Calle: {row[5]}").pack()
            tk.Label(nueva_ventana, text=f"Número: {row[6]}").pack()
            tk.Label(nueva_ventana, text=f"Nombre: {row[7]}").pack()
            tk.Label(nueva_ventana, text=f"Apellido Paterno: {row[8]}").pack()
            tk.Label(nueva_ventana, text=f"Apellido Materno: {row[9]}").pack()
            tk.Label(nueva_ventana, text=f"Fecha de Nacimiento: {row[10]}").pack()
            tk.Label(nueva_ventana, text=f"Edad: {row[11]}").pack()

            # Convertir el dato bytea de la columna 12 a una imagen
            imagen_bytea = row[12]
            imagen = Image.open(io.BytesIO(imagen_bytea))
            imagen = imagen.resize((300, 300))  # Ajusta el tamaño de la imagen según sea necesario

            # Convertir la imagen a un formato que Tkinter pueda mostrar
            imagen_tk = ImageTk.PhotoImage(imagen)

            # Mostrar la imagen en un widget Label
            tk.Label(nueva_ventana, image=imagen_tk).pack()

            # Debes mantener una referencia a la imagen de Tkinter para que no sea eliminada por el recolector de basura
            tk.Label.image_tk = imagen_tk

    else:
        tk.Label(nueva_ventana, text="No se encontraron empleados con ese número.").pack()



btn_administrativo = tk.Button(menu_lateral, text="Administrativo", command=ventana_administrativo)
btn_administrativo.pack()

def ventana_factura():
    pass  # Lógica para la ventana de factura

btn_factura = tk.Button(menu_lateral, text="Factura", command=ventana_factura)
btn_factura.pack()

root.mainloop()