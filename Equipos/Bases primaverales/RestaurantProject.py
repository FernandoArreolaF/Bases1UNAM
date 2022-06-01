# -*- coding: utf-8 -*-
"""
Created on Thu May 26 00:09:33 2022

@author: gabym
"""

import PySimpleGUI as sg
import psycopg2
from datetime import date

#-----------------------------------------------------------------
#        Ejecución de consultas (Recuperación de datos)
#-----------------------------------------------------------------
def sql_query(connection,cursor,comando,tipo):
    # SQL query 
    query = comando
    # Execute a command: 
    cursor.execute(query)
    connection.commit()
    print("Comando corrió correctamente")
    #Saving data
    if tipo=='select':
        datos=cursor.fetchall()
        
    if tipo == '*':
        datos = cursor.fetchall()
            
    if tipo == 'nombre_completo':
        datos = cursor.fetchall()
            
    if tipo == 'prueba':
        datos = cursor.fetchall()
        
    if tipo == 'vista':
        datos = cursor.fetchall()

    return datos 

#----------------------------------------------------------------------
#        Inserción de clientes a la base de datos (query)
#----------------------------------------------------------------------
def insert_cliente_query(id_cliente,nombre,ap_p,ap_m,id_orden):
    insert_cliente = "INSERT INTO CLIENTE VALUES(%s,%s,%s,%s,%s);"
    data = [(id_cliente,nombre,ap_p,ap_m,id_orden)]
    cursor.executemany(insert_cliente, data)
    print('Comando de inserción EXITOSO')
    
    return ("Cliente y orden capturados en la base.")
               

#----------------------------------------------------------------------
#    Conversion de tupla a lista de elementos individuales sin ','
#----------------------------------------------------------------------
def filtrando_select(lista_de_tuplas):
    lista_de_cadenas = [] 
    for tupla in lista_de_tuplas:
        palabra="".join(tupla)
        lista_de_cadenas.append(palabra) 
    return lista_de_cadenas

#----------------------------------------------------------------------
#    filtrado de lista de valores booleanos (no requeridos)
#----------------------------------------------------------------------
def filtra_lista(lista,bool_lista):
    filtered_list = [i for (i, v) in zip(lista, bool_lista) if v] 
    return filtered_list

#----------------------------------------------------------------------
#    Boton checkbox y lectura numerica de cantidad
#----------------------------------------------------------------------
def producto_cant(tipo):
    #Se guardaran los valores booleanos que corresponden al producto seleccionado
    if tipo=='nombre_platilloybebida':
        lista_bool_prod=[]
        for i in range(10,10,2):
            print(values[i])
            lista_bool_prod.append(values[i])
        return lista_bool_prod
    #Se guardaran los valores que indican la cantidad de producto vendido
    elif tipo=='cantidad':
        lista_cantidades=[]
        for i in range(11,10,2):
            if values[i]!='':
                lista_cantidades.append(values[i])
                print(values[i])
        return lista_cantidades

#----------------------------------------------------------------------
#    Mostrar empleados capturados en la base
#----------------------------------------------------------------------
def ventana_empleado(lista_empleado):
    layout = [
        [sg.Text('Empleados registrados en la base:',font=('Courier 12'))],
        [sg.Text(' ',font=('Courier 12'))],
        [sg.Text('DATOS DE EMPLEADOS: ',font=('Courier 12'))],
        [sg.Text('| numero de empleado | nombre | rfc | fecha de nacimiento | edad | calle | numero | colonia | cp | estado | foto | sueldo |',font=('Courier 12'))],
        *[[sg.Text(f'{empleado}',font=('Courier 12'))] for empleado in lista_empleado],
        [sg.Text(' ',font=('Courier 12'))]
        ]

    return sg.Window('Empleados', layout,size=(1800,600), finalize=True)

#----------------------------------------------------------------------
#    Ejecución de vistas
#----------------------------------------------------------------------
def data_vist(view,mensaje):
    layout = [
        [sg.Text(mensaje,font=('Courier 12'))],
        *[[sg.Text(f'{data}',font=('Courier 12'))] for data in view],
        [sg.Text(' ',font=('Courier 12'))],
        [sg.Text(' ',font=('Courier 12'))]
        ]
    
    return sg.Window('Vista', layout,size=(1800,600), finalize=True)

#Tema de interfaz
sg.theme('DarkPurple1')

#Variables postgres
PSQL_HOST = "localhost"
PSQL_PORT = "5432"
PSQL_USER = "postgres"
PSQL_PASS = "Magaby99!"
PSL_BD = "restaurante"

#----------------------------------------------------------------------
#        Connection to database
#----------------------------------------------------------------------
try: 
    connection = psycopg2.connect(user=PSQL_USER,
                                  password=PSQL_PASS,
                                  host=PSQL_HOST,
                                  port=PSQL_PORT,
                                  database=PSL_BD)
    cursor = connection.cursor()
    print("Conexión a la base de datos restaurante EXITOSA")
except Exception as ex:
    print(ex)


#listas para guardar clientes y ordenes capturadas
clientes_insertados = []
ordenes_insertados = []

#Funcion con comando sql para obtener lista de productos a imprimir en el menu
select_platilloybebida = filtrando_select(sql_query(connection,cursor,'SELECT nombre_platilloybebida FROM platilloybebida;','select'))

contador_ordenes = 0#contador para registro ordenes
contador_clientes = 0 #contador para registro clientes 
j = 0 #Incremento para ordenes
k = 0 #Incremento para clientes

#----------------------------------------------------------------------
#               Create layouts this Window will display
#----------------------------------------------------------------------
layout_inicio = [
    [sg.Text('B I E N V E N I D O \n\n',size=(40, 1), font=('Any 15'))],
    [sg.Text('')],
    [sg.Text('')],
    [sg.Text('¿Qué desea hacer?', font=('Courier 12')),sg.Text(key = 'menu')],
    [sg.Text('')],
    [sg.Text('\t1. Ordenar', font=('Courier 12')),sg.Text(key = 'menu')],
    [sg.Text('\t2. Capturar cliente', font=('Courier 12')),sg.Text(key = 'menu')],
    [sg.Text('\t3. Ver empleados', font=('Courier 12')),sg.Text(key = 'menu')],
    [sg.Text('\t4. Generar factura', font=('Courier 12')),sg.Text(key = 'menu')],
    [sg.Text('\t5. Vistas', font=('Courier 12')),sg.Text(key = 'menu')]
    ]

layout1 = [
    [sg.Text('MENÚ',size=(75, 1),font=('Any 15'),)],
    #[sg.Text("Fecha orden: "),sg.CalendarButton('Calendario', close_when_date_chosen =True, target = 'Calendario')],
    [sg.Text('Seleccione sus platillos y la cantidad que desea:',font=('Courier 12'))], 
    *[[sg.CB(f'{producto}',default=False,size =(30, 1),font=('Courier 12')),sg.Text('Cantidad:',font=('Courier 12')),sg.InputText(do_not_clear=False,size =(5,1))] for producto in select_platilloybebida],
    [sg.Text('')],
    [sg.Submit('Tomar orden',size =(20, 2)),sg.Button('Vista productos',size =(20, 2)),sg.Cancel(size =(8, 2))]
    ]

layout2 = [
    [sg.Text('CAPTURA DATOS CLIENTE', font=('Any 15'))],
    [sg.Text('')],
   # [sg.Text("id_cliente: "), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.Input(key = '-id-')],
    [sg.Text('Nombre: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('Apellido Paterno: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('Apellido Materno: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('')],
    [sg.Submit('Capturar datos cliente')]
    ]

layout3 = [
    [sg.Text('DATOS EMPLEADO',font=('Any 15'))],
    [sg.Text('')],
    [sg.Text('Ver lista de todos los empleados registrados en la base de datos')],
    [sg.Text('')],
    [sg.Button('Ver empleados')]      
    ]

layout4 = [
    [sg.Text('GENERAR FACTURA', font=('Any 15'))],
    [sg.Text('')],
    [sg.Text('RFC: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('Razon social: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('Calle: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('Colonia: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('CP: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('Estado: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('Email: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('Fecha de nacimiento: '), sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('')],
    [sg.Text('Id_cliente: '),sg.Text(size=(40,1), font=('Courier 12'),key = '-OUTPUT-' )],[sg.InputText(do_not_clear=False)],
    [sg.Text('')],
    [sg.Submit('Generar factura')],
    ]

layout5 = [
    [sg.Text('VISTAS',font=('Any 15'))],
    [sg.Text('')],
    [sg.Text('\t1. Vista de producto más vendido', font=('Courier 12')),sg.Text(key = 'submenu'),sg.Button('- 1 -')],
    [sg.Text('\t2. Vista cliente', font=('Courier 12')),sg.Text(key = 'opcion1'),sg.Button('- 2 -')],
    [sg.Text('\t3. Vista producto', font=('Courier 12')),sg.Text(key = 'opcion2'),sg.Button('- 3 -')],
    [sg.Text('\t4. Vista factura', font=('Courier 12')),sg.Text(key = 'opcion3'),sg.Button('- 4 -')],
    [sg.Text('\t5. Vista productos NO disponibles', font=('Courier 12')),sg.Text(key = 'opcion4'),sg.Button('- 5 -')],
    [sg.Text('\t6. Vista orden', font=('Courier 12')),sg.Text(key = 'opcion4'),sg.Button('- 6 -')]
    ]


#----------------------------------------------------------------------
#      Create actual layout using Columns and a row of Buttons
#----------------------------------------------------------------------

layout = [
    [sg.Column(layout_inicio, key='-COL0-'),
    sg.Column(layout1, visible=False, key='-COL1-'), sg.Column(layout2, visible=False, key='-COL2-'), 
    sg.Column(layout3, visible=False, key='-COL3-'), 
    sg.Column(layout4, visible=False, key='-COL4-'),
    sg.Column(layout5, visible=False, key='-COL5-'),],
    [sg.Button('Principal'), sg.Button('1'), sg.Button('2'), sg.Button('3'), sg.Button('4'), sg.Button('5'), sg.Button('Exit')]
    ]

window = sg.Window('Interfaz Restaurante', layout, size=(1200,700))

layout = 1  # The currently visible layout

while True:
    event, values = window.read()
    print(event, values)
    if event in (None, 'Exit'):
        break
    if event == 'Principal':
        window[f'-COL{layout}-'].update(visible=False)
        layout = layout + 1 if layout < 4  else 1
        window[f'-COL{layout}-'].update(visible=True)
    elif event in '12345':
        window[f'-COL{layout}-'].update(visible=False)
        layout = int(event)
        window[f'-COL{layout}-'].update(visible=True)
        
    if event == 'Tomar orden':
        print("Entreo a evento")
        #Generar id orden con formato ORD-00#
        j = j + 1
        contador_ordenes = contador_ordenes+j
        id_orden='ORD-'+str(contador_ordenes).zfill(3);
        
        #Lista de productos seleccionados y cantidades seleccionadas por cliente
        orden_selecionada=filtra_lista(select_platilloybebida,producto_cant(tipo='nombre_platilloybebida'))
        cantidad_venta=list(map(int,producto_cant(tipo='cantidad')))#volviendose lista de enteros
        
        for i in cantidad_venta:
            print(cantidad_venta)
            
        for u in orden_selecionada:
            print(orden_selecionada)
       
        #Parte del query de precios dados los productos seleccionados
        string_orden_menu=(str(orden_selecionada).replace("[","(")).replace("]",")")#acomodando formato
        for i in string_orden_menu:
            print(string_orden_menu)
            
        cadena_select_precios="SELECT precio_platilloybebida FROM platilloybebida WHERE nombre_platilloybebida in "+string_orden_menu+";"
        #El query de los precios: devuelve una lista de tuplas de decimales
        lista_precios=sql_query(connection,cursor,cadena_select_precios,'select')
        lista_precios_num=[]

        #Con este for se guarda el query de los precios como lista de enteros
        for i in range(0,len(lista_precios)):
            lista_precios_num.append(int(lista_precios[i][0]))

        #Calculanto total a pagar de la venta
        precio_total_orden=0
        for cantidad, precio in zip(cantidad_venta,lista_precios_num):
            cantidad_total_pagar=(cantidad*precio)+precio_total_orden
        
        #Insertando datos en la tabla ORDEN
        #Fecha de hoy
        fec_orden = date.today().strftime("%Y-%m-%d")
        insert_orden = "INSERT INTO ORDEN VALUES(%s,%s,%s,%s);"
        num_empleado = 1
        data_orden = [(id_orden,fec_orden,precio_total_orden,num_empleado)]
        cursor.executemany(insert_orden, data_orden)
        
    if event == 'Capturar datos cliente': 
        #Generar id cliente
        k = k + 1
        contador_clientes = contador_clientes+k
        id_cliente = str(contador_clientes)
        mensaje = insert_cliente_query(id_cliente,values[0],values[1],values[2],id_orden)
        layout3 = [
            [sg.Text(' ',mensaje)],
            [sg.Text('Tu id_orden es: %s',id_orden)],[sg.Text('Tu id_cliente es: %s',id_cliente)]
            ]
        
    if event == 'Ver empleados':
        #select_empleado = filtrando_select(sql_query(connection,cursor,'SELECT * FROM empleado;','select'))
        select_empleado = sql_query(connection,cursor,'SELECT * FROM empleado;','*')
        ventana_empleado(select_empleado)
    
    if event == 'Vista productos':
        view_producto = sql_query(connection,cursor,'SELECT * FROM datos_producto;','vista')
        mensaje = 'VISTA PRODUCTO'
        data_vist(view_producto,mensaje)
        
        print(view_producto)
        for elemento in view_producto:
            print(elemento)
            
    if event == '- 1 -':
        view_produc_top = sql_query(connection,cursor,'SELECT * FROM mas_vendido;','vista')
        mensaje = 'VISTA PRODUCTO MAS VENDIDO'
        data_vist(view_produc_top,mensaje)
        
    if event == '- 2 -':
        view_client = sql_query(connection,cursor,'SELECT * FROM datos_cliente;','vista')
        mensaje = 'VISTA CLIENTE'
        data_vist(view_client,mensaje)
        
    if event == '- 3 -':
        view_product = sql_query(connection,cursor,'SELECT * FROM datos_producto;','vista')
        mensaje = 'VISTA PRODUCTO'
        data_vist(view_product,mensaje)
        
    if event == '- 4 -':
        view_factura = sql_query(connection,cursor,'SELECT * FROM facturaaa;','vista')
        mensaje = 'VISTA FACTURA'
        data_vist(view_factura,mensaje)
        
    if event == '- 5 -':
        view_product_not_available = filtrando_select(sql_query(connection,cursor,'SELECT * FROM no_disponible;','vista'))
        mensaje = 'VISTA PRODUCTOS NO DISPONIBLES'
        data_vist(view_product_not_available,mensaje)
        
    if event == '- 6 -':
        view_orden = sql_query(connection,cursor,'SELECT * FROM orden_view;','vista')
        mensaje = 'VISTA ORDEN'
        data_vist(view_orden,mensaje)
        
        
window.close()

#----------------------------------------------------------------------
#       Disconnection to database
#----------------------------------------------------------------------
try: 
    if connection:
        cursor.close()
        connection.close()
    print("Conexión a la base de datos restaurante FINALIZADA")
except Exception as ex:
    print(ex)
