import psycopg2
import PySimpleGUI as sg
import random
from datetime import date

#_________________________FUNCION sql_query__________________________________
def sql_query(connection,cursor,comando,tipo):
        # SQL query 
        query = comando
        # Execute a command: 
        cursor.execute(query)
        connection.commit()
        print("Comando corrió correctamente en PostgreSQL ")
        #Saving data
        if tipo=='select':
            datos=cursor.fetchall()
            return datos


#_________________________FUNCION filtrando_select__________________________________
#lista de productos sale de la base como una lista de tuplas entonces se debe pasar a lista de cadenas
def filtrando_select(lista_de_tuplas):
    lista_de_cadenas=[]
    for tupla in lista_de_tuplas:
        palabra="".join(tupla)
        lista_de_cadenas.append(palabra)
    return lista_de_cadenas



#_________________________FUNCION producto_descr_cant__________________________________   
#Valores correspondientes a la despripcion del producto o cantidades
#que salen al oprimir el checkbox e igresar el dato numerico
def producto_descr_cant(tipo):
    if tipo=='descripcion':#Se guardaran los valores booleanos que corresponden al producto seleccionado
        lista_bool_prod=[]
        for i in range(10,28,2):
            lista_bool_prod.append(values[i])
        return lista_bool_prod
    elif tipo=='cantidad':#Se guardaran los valores que indican la cantidad de producto vendido
        lista_cantidades=[]
        for i in range(11,28,2):
            if values[i]!='':
                lista_cantidades.append(values[i])
        return lista_cantidades



#_________________________FUNCION filtra_lista__________________________________
#Se filtra una lista dada otra lista de valores booleanos indicando que valores no se requieren
def filtra_lista(lista,bool_lista):
    filtered_list = [i for (i, v) in zip(lista, bool_lista) if v] 
    return filtered_list


#____________________Connect to an existing database____________________
#_____________________________________________________________
connection = psycopg2.connect(user="francineochoafernandez",
                                    password="tatin",
                                    host="127.0.0.1",
                                    port="5431",
                                    database="papeleria")
cursor = connection.cursor()
#_____________________________________________________________


#Lista para guardar los clientes que se han insertado
clientes_insertados=[]
#Lista para guardar las ventas que se han insertado
ventas_insertadas=[]
#Lista para guardar informacion de ventas que se han insertado
haber_insertados=[]
#Funcion con comando sql para obtener lista de productos, se filtra para que se muestre como lista de cadenas.
select_productos=filtrando_select(sql_query(connection,cursor,'SELECT descripcion FROM PRODUCTO;','select'))

ultima_venta=8
j=0#contador para ventas

#Fecha de hoy
today = date.today().strftime("%d-%m-%Y")

#Tema de la interfaz
sg.theme('SandyBeach')  

#Fuentes para la iterfaz
font1 = ("Helvetica", 24)
font = ("Helvetica", 18)
font2 = ("Helvetica", 15)
font3 = ("Helvetica", 40)
 
#Ventana para mostrar los clientes agregados
def ventana_cliente(lista_clientes):
    layout = [[sg.Text('Clientes agregados hasta ahora:',font=font1)],
                [sg.Text(' ',font=font1)],
                [sg.Text('CAMPOS: | id_cliente| rfc | nombre | appat | apmat | calle | numero | colonia | codigo_postal | estado |',font=font)],
                *[[sg.Text(f'{cliente}',font=font2)] for cliente in lista_clientes],
                [sg.Text(' ',font=font1)]
                ]
    return sg.Window('Second Window', layout, finalize=True)

#Ventana para mostrar información de la venta 
def ventana_venta(lista_venta,lista_haber):
    layout = [[sg.Text('Información de las ventas realizadas',font=font1)],
                [sg.Text(' ',font=font1)],
                [sg.Text('CAMPOS: | numero_venta | fecha_venta | cantidad_total_pagar | id_cliente |',font=font)],
                *[[sg.Text(f'{venta}',font=font2)] for venta in lista_venta],
                [sg.Text(' ',font=font1)],
                [sg.Text('CAMPOS: | id_articulo | numero_venta | cantidad_articulos | precio_por_articulo |',font=font)],
                *[[sg.Text(f'{haber}',font=font2)] for haber in lista_haber],
                [sg.Text(' ',font=font1)]
                ]
    return sg.Window('Third Window', layout, finalize=True)

# ----------- Create the 3 layouts this Window will display -----------
layout_home=[[sg.Text('INICIO',font=font3)],
            [sg.Text('En esta interfaz se podra insertar información sobre',font=font)],
            [sg.Text("clientes o sobre ventas en la base de datos 'papelería'",font=font)],
            [sg.Text('que se encuentra en el manejador postgreSQL junto con',font=font)],
            [sg.Text('todas las tablas ya creadas con datos insertados.',font=font)]
             
            ]

layout1 = [
    [sg.Text('Agrega la información de tu cliente:',font=font1)],
    [sg.Text('id_cliente', size =(12, 1),font=font2), sg.InputText(do_not_clear=False)],
    [sg.Text('rfc', size =(12, 1),font=font2), sg.InputText(do_not_clear=False)],
    [sg.Text('nombre', size =(12, 1),font=font2), sg.InputText(do_not_clear=False)],
    [sg.Text('Apellido Paterno', size =(12, 1),font=font2), sg.InputText(do_not_clear=False)],
    [sg.Text('Apellido Materno', size =(12, 1),font=font2), sg.InputText(do_not_clear=False)],
    [sg.Text('Calle', size =(12, 1),font=font2), sg.InputText(do_not_clear=False)],
    [sg.Text('Numero', size =(12, 1),font=font2), sg.InputText(do_not_clear=False)],
    [sg.Text('Colonia', size =(12, 1),font=font2), sg.InputText(do_not_clear=False)],
    [sg.Text('CP', size =(12, 1),font=font2), sg.InputText(do_not_clear=False)],
    [sg.Text('Estado', size =(12, 1),font=font2), sg.InputText(do_not_clear=False)],
    [sg.Submit('Agregar datos a la base',size =(20, 2),button_color='#35B06F'), sg.Button('Ver clientes agregados',size =(20, 2),button_color='#ED8FB8') ,sg.Cancel(size =(8, 2),button_color='#E28E8E')]
    ]

layout2 = [
        [sg.Text('Ingresa una Venta',font=font1)],
        [sg.Text('Selecciona artículos comprados y cantidad de cada uno:',font=font2)], 
        *[[sg.CB(f'{articulo}',default=False,size =(15, 1),font=font2),sg.Text('Cantidad:',font=font2),sg.InputText(do_not_clear=False,size =(5, 1))] for articulo in select_productos],
        [sg.Text('Ingresa tu id_cliente:', size =(16, 1),font=font2), sg.InputText(do_not_clear=False)],
        [sg.Submit('Agregar venta a la base',size =(20, 2),button_color='#35B06F'), sg.Button('Ver informacion de ventas',size =(20, 2),button_color='#ED8FB8'),sg.Cancel(size =(8, 2),button_color='#E28E8E')]
        ]
    


# ----------- Create actual layout using Columns and a row of Buttons
layout = [
            [sg.Column(layout_home, key='-COLhome-'),sg.Column(layout1, visible=False, key='-COL1-'), sg.Column(layout2, visible=False, key='-COL2-')],
            [sg.Button('home'), sg.Button('1',size =(1.5,1),button_color='#3399FF'), sg.Button('2',button_color='#3399FF')]
            ]

window = sg.Window('PAPELERIA', layout,size=(500, 500))


layout ='home'  # The currently visible layout
while True:
    event, values = window.read()
    print(event)

    if event in '12':
        window[f'-COL{layout}-'].update(visible=False)
        layout = event
        window[f'-COL{layout}-'].update(visible=True)
    elif event=='home':
        window[f'-COL{layout}-'].update(visible=False)
        layout = event
        window[f'-COL{layout}-'].update(visible=True)

    if event =='Agregar datos a la base':
        cadena_inserta_cliente="INSERT INTO CLIENTE VALUES("+"'"+values[0]+"','"+values[1]+"','"+values[2]+"','"+values[3]+"','"+values[4]+"','"+values[5]+"','"+values[6]+"','"+values[7]+"','"+values[8]+"','"+values[9]+"'"+");"
        clientes_insertados.append(cadena_inserta_cliente)
        sql_query(connection,cursor,cadena_inserta_cliente,'insert')
    elif event=='Ver clientes agregados':
        ventana_cliente(clientes_insertados)
        
    if event == 'Agregar venta a la base':
        j=j+1
        productos_venta=filtra_lista(select_productos,producto_descr_cant(tipo='descripcion'))
        cantidad_venta=list(map(int,producto_descr_cant(tipo='cantidad')))#volviendose lista de enteros

        #_________Completando datos para insercion de valores en tabla VENTA____________
        id_venta="VENT-"+str((ultima_venta+j)).zfill(3)
        id_cliente=values[28]
        #Parte del query de precios dados los productos seleccionados
        string_productos_venta=(str(productos_venta).replace("[","(")).replace("]",")")
        cadena_select_precios="SELECT precio FROM PRODUCTO WHERE descripcion in "+string_productos_venta+";"
        #El query de los precios: devuelve una lista de tuplas de decimales
        lista_precios=sql_query(connection,cursor,cadena_select_precios,'select')
        lista_precios_num=[]

        #Con este for se guarda el query de los precios como lista de enteros
        for i in range(0,len(lista_precios)):
            lista_precios_num.append(int(lista_precios[i][0]))

        #Calculanto total a pagar de la venta
        cantidad_total_pagar=0
        for cantidad, precio in zip(cantidad_venta,lista_precios_num):
            cantidad_total_pagar=(cantidad*precio)+cantidad_total_pagar
        #____________________________________________________________________________________

        #Insertando datos de la venta en tabla VENTA
        cadeda_iserta_venta="INSERT INTO VENTA VALUES ('"+id_venta+"','"+today+"',"+str(cantidad_total_pagar)+",'"+id_cliente+"');"
        ventas_insertadas.append(cadeda_iserta_venta)
        sql_query(connection,cursor,cadeda_iserta_venta,'insert')

         #_________Completando datos para insercion de valores en tabla HABER____________
        #El query de los id_articulo: devuelve una lista de tuplas de enteros
        cadena_select_idart="SELECT id_articulo FROM PRODUCTO WHERE descripcion in "+string_productos_venta+";"
        lista_id_art=sql_query(connection,cursor,cadena_select_idart,'select')
        lista_id_art_num=[]

        #Con este for se guarda el query de los id_articulo como lista de enteros
        for i in range(0,len(lista_id_art)):
            lista_id_art_num.append(str(lista_id_art[i][0]))
        #____________________________________________________________________________________

        #Insertando datos de la venta en tabla HABER
        for i in range(0,len(productos_venta)):
            cadena_inserta_haber= "INSERT INTO HABER VALUES("+lista_id_art_num[i]+",'"+id_venta+"',"+str(cantidad_venta[i])+","+str(lista_precios_num[i])+");"
            haber_insertados.append(cadena_inserta_haber)
            sql_query(connection,cursor,cadena_inserta_haber,'insert')

    elif event=='Ver informacion de ventas':
        ventana_venta(ventas_insertadas,haber_insertados)


        
        
        
        

window.close()


#__________________________Desconectando______________________
#_____________________________________________________________
if connection:
    cursor.close()
    connection.close()
    print("PostgreSQL connection is closed")
#_____________________________________________________________






