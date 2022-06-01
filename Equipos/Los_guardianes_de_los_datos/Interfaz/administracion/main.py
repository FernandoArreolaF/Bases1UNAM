#Librerias para la interfaz gráfica
from tkinter import *
from tkinter import ttk

#Libería para el uso de imagenes
from PIL import Image, ImageTk

#Libreria que permite obtener la imagen desde una URL
from urllib.request import urlopen

#Librería que permite la conexión con PostgreSQL
import psycopg2


NOMBRE_BD = "restaurante" # <----- Modificar valor si lo requiere
PASSWORD_POSTGRES = "postgres" # <----- Modificar valor si lo requiere

#Configuración de ventana principal
Ventana =Tk()
Ventana.title("Interfaz destinada a la administración")
Ventana.geometry('700x650')
#Bloquea la expansión de la interfaz 
Ventana.resizable(0,0)
backFrame=Frame(master=Ventana,width=700,height=650)

#Configuración de las pestañas
tabControl=ttk.Notebook(width=700,height=650)
s=ttk.Style()
s.configure('TFrame',background="#245485")



#Creacion de las pestañas
tab1=ttk.Frame(tabControl,style="TFrame")
tab2=ttk.Frame(tabControl,style="TFrame")
tab3=ttk.Frame(tabControl,style="TFrame")
tab4=ttk.Frame(tabControl,style="TFrame")
tabControl.add(tab1,text="Información del empleado")
tabControl.add(tab2,text="Ordenes por día")
tabControl.add(tab3,text="Ventas de fecha específica")
tabControl.add(tab4,text="Ventas entre dos fechas")
tabControl.pack(expand=1,fill="both")


#--------------------------------Código de la primer pestaña--------------------------------
etiqueta=Label(tab1,text="Información de los empleados del restaurante")
etiqueta.place(relx=0.017,rely=0.08,relwidth=1)
etiqueta.config(bg="#245485",fg="white",font=("Arial",12,"bold"))

#Ingreso de cadena y búsqueda
etiqueta2= Label(tab1, text="Ingresa el número de empleado")
etiqueta2.place(relx=0.337,rely=0.43)
etiqueta2.config(bg="#245485",fg="white",font=("Arial",12,"bold"))
entrada_uno = Entry(tab1)
entrada_uno.place(relx=0.376,rely=0.48)
entrada_uno.config(font=(11))
boton=Button(tab1,text="Buscar",command=lambda:buscar())
boton.place(relx=0.4734,rely=0.54)
boton.config(bg="white")

#Visualización de la consulta de PostgreSQL
listbox = Listbox(tab1)
listbox.place(relx=0.127,rely=0.6,relwidth=0.75,relheight=0.25)
barra = Scrollbar(tab1,command=listbox.yview)
barra.place(relx=0.86,rely=0.6,relheight=0.25)
listbox.config(yscrollcommand=barra.set,border=0,font=("Arial",12,"bold"))


#Función que permite realizar la consulta y visualizarla dentro de la interfaz
def buscar():
    variable=str(entrada_uno.get())
    #Se realiza la conexión con postgreSQL
    con = psycopg2.connect(
            database=NOMBRE_BD, 
            user="postgres", 
            password=PASSWORD_POSTGRES, 
            host="localhost"
        )
    try:
        if variable !='':       
            cur=con.cursor()
            cur.execute("SELECT * FROM empleado WHERE numero_empleado="+variable+';')
            rows = cur.fetchall()
            if(len(rows)!=0):
                listbox.delete(0, 'end')
                for row in rows:
                    listbox.insert(0,"Numero de empleado: " + str(row[0]))
                    cambiar_img(str(row[1]))
                    listbox.insert(1,"RFC: " + str(row[2]))
                    listbox.insert(2,"Nombre: " + str(row[3]))
                    listbox.insert(3,"Apellido Paterno: " + str(row[4]))
                    listbox.insert(4,"Apellido Materno: " + str(row[5]))
                    listbox.insert(5,"Edad: " + str(row[6]))
                    listbox.insert(6,"Sueldo: " + str(row[7]))
                    listbox.insert(7,"Calle: " + str(row[8]))
                    listbox.insert(8,"Número: " + str(row[9]))
                    listbox.insert(9,"Código Postal: " + str(row[10]))
                    listbox.insert(10,"Estado: " + str(row[11]))
                    listbox.insert(11,"Colonia: " + str(row[12]))
                    listbox.insert(12,"Fecha de nacimiento: " + str(row[13]))
                    listbox.insert(13,"¿Es mesero?: " + str(row[14]))
                    listbox.insert(14,"¿Es administrativo?: " + str(row[15]))
                    listbox.insert(15,"¿Es cocinero?: " + str(row[16]))
                    listbox.insert(16,"Horario: " + str(row[17]))
                    listbox.insert(17,"Rol: " + str(row[18]))
                    listbox.insert(18,"Especialidad: " + str(row[19]))
                con.close()
            else:
                listbox.delete(0, 'end')
                #Imagen en blanco
                cambiar_img("https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/Fotos%20150x150/white.png")
                listbox.insert(0,"El empleado no existe.")
                con.close()
        else:
            listbox.delete(0, 'end')
            #Imagen en blanco
            cambiar_img("https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/Fotos%20150x150/white.png")
            listbox.insert(0,"Por favor, ingresa el número de empleado.")
    except:
        listbox.delete(0, 'end')
        listbox.insert(0,"El formato del número de empleado es incorrecto.")
        #Imagen en blanco
        cambiar_img("https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/Fotos%20150x150/white.png")

#Función que permite visualizar la imagen del empleado
def cambiar_img(aux):
    global imagen
    try:
        URL=aux
        u = urlopen(URL)
        raw_data = u.read()
        u.close()
        imagen = ImageTk.PhotoImage(data=raw_data)
        foto=Label(tab1,image=imagen).place(relx=0.40,rely=0.165,width=150,height=150)
    except:
        listbox.delete(0, 'end')
        URL="https://raw.githubusercontent.com/erikcalvillomartinez/Fotos/main/Fotos%20150x150/white.png"
        u = urlopen(URL)
        raw_data = u.read()
        u.close()
        imagen = ImageTk.PhotoImage(data=raw_data)
        foto=Label(tab1,image=imagen).place(relx=0.40,rely=0.165,width=150,height=150)

#--------------------------------Código de la segunda pestaña--------------------------------

#Etiquetas que permiten visualizar texto en la tercera pestaña
etiqueta_tab2=Label(tab2,text="Cantidad de ordenes y el total que se pagó por dichas ordenes \n de un mesero en el día de hoy")
etiqueta_tab2.place(relx=0.0167,rely=0.08,relwidth=1)
etiqueta_tab2.config(bg="#245485",fg="white",font=("Arial",12,"bold"))
etiqueta2_tab2=Label(tab2,text="Ingresa el número de empleado del mesero")
etiqueta2_tab2.place(relx=0.015,rely=0.725,relwidth=1)
etiqueta2_tab2.config(bg="#245485",fg="white",font=("Arial",12,"bold"))

#Visualización de lo que devuelve PostgreSQL
listbox_tab2= Listbox(tab2)
listbox_tab2.place(relx=0.127,rely=0.2,relwidth=0.75,relheight=0.50)
barra_tab2 = Scrollbar(tab2,command=listbox.yview)
barra_tab2.place(relx=0.85,rely=0.205,relheight=0.49)
listbox_tab2.config(yscrollcommand=barra_tab2.set,border=0,font=("Arial",12,"bold"))

#Ingreso del número de empleado y búsqueda 
entrada_tab2=Entry(tab2)
entrada_tab2.place(relx=0.372,rely=0.78)
entrada_tab2.config(font=(11))
boton_tab2=Button(tab2,text="Buscar",command=lambda:buscar_tab2())
boton_tab2.place(relx=0.47,rely=0.85)
boton_tab2.config(bg="white")

#Función que permite buscar por un número de empleado

def buscar_tab2():
    variable=str(entrada_tab2.get())
    #Se realiza la conexión con postgreSQL
    con = psycopg2.connect(
            database=NOMBRE_BD, 
            user="postgres", 
            password=PASSWORD_POSTGRES, 
            host="localhost"
        )

    try:
        if variable !='':       
            cur=con.cursor()
            cur.execute("SELECT * FROM mesero_ordenes_al_dia_function("+variable+');')
            rows = cur.fetchall()
            if(len(rows)!=0):
                listbox_tab2.delete(0, 'end')
                for row in rows:
                    listbox_tab2.insert(0,"Número de empleado: " + str(row[0]))
                    listbox_tab2.insert(1,"Número de ordenes: " + str(row[1]))
                    listbox_tab2.insert(2,"Precio total de las ordenes: " + str(row[2]))
                con.close()
            else:
                listbox_tab2.delete(0, 'end')
                listbox_tab2.insert(0,"El empleado no es mesero o no existe.")
                con.close()
        else:
            listbox_tab2.delete(0, 'end')
            listbox_tab2.insert(0,"Por favor, ingresa el número de empleado.")
    except:
        listbox_tab2.delete(0, 'end')
        listbox_tab2.insert(0,"El formato del número de empleado es incorrecto.")




#--------------------------------Código de la tercer pestaña--------------------------------

#Etiquetas que permiten visualizar texto en la cuarta pestaña
etiqueta_tab3=Label(tab3,text="Cantidad de ordenes y ventas, así como el monto total \nde dichas ventas en una fecha dada")
etiqueta_tab3.place(relx=0.002,rely=0.08,relwidth=1)
etiqueta_tab3.config(bg="#245485",fg="white",font=("Arial",12,"bold"))
etiqueta2_tab3=Label(tab3,text="Ingresa la fecha(Empezando por día o por año)")
etiqueta2_tab3.place(relx=0.017,rely=0.725,relwidth=1)
etiqueta2_tab3.config(bg="#245485",fg="white",font=("Arial",12,"bold"))

#Visualización de lo que devuelve PostgreSQL
listbox_tab3= Listbox(tab3)
listbox_tab3.place(relx=0.127,rely=0.2,relwidth=0.75,relheight=0.50)
barra_tab3 = Scrollbar(tab3,command=listbox.yview)
barra_tab3.place(relx=0.85,rely=0.205,relheight=0.49)
listbox_tab3.config(yscrollcommand=barra_tab3.set,border=0,font=("Arial",12,"bold"))

#Ingreso de la fecha y búsqueda 
entrada_tab3=Entry(tab3)
entrada_tab3.place(relx=0.376,rely=0.78)
entrada_tab3.config(font=(11))
boton_tab3=Button(tab3,text="Buscar",command=lambda:buscar_tab3())
boton_tab3.place(relx=0.4747,rely=0.85)
boton_tab3.config(bg="white")

#Función que permite buscar por una fecha

def buscar_tab3():
    variable=str(entrada_tab3.get())
    #Se realiza la conexión con postgreSQL
    con = psycopg2.connect(
            database=NOMBRE_BD, 
            user="postgres", 
            password=PASSWORD_POSTGRES, 
            host="localhost"
        )

    try:
        if variable !='':       
            cur=con.cursor()
            cur.execute("SELECT * FROM cantidad_monto_ventas_fecha_function('"+variable+"');")
            rows = cur.fetchall()
            if(len(rows)!=0):
                listbox_tab3.delete(0, 'end')
                for row in rows:
                    listbox_tab3.insert(0,"Fecha: " + str(row[0]))
                    listbox_tab3.insert(1,"Cantidad de ordenes: " + str(row[1]))
                    listbox_tab3.insert(2,"Cantidad de ventas: " + str(row[2]))
                    listbox_tab3.insert(3,"Monto total ventas: " + str(row[3]))
                con.close()
            else:
                listbox_tab3.delete(0, 'end')
                listbox_tab3.insert(0,"No se encontraron ventas en esa fecha.")
                con.close()
        else:
            listbox_tab3.delete(0, 'end')
            listbox_tab3.insert(0,"Por favor, ingresa una fecha.")
    except:
        listbox_tab3.delete(0, 'end')
        listbox_tab3.insert(0,"El formato de la fecha es incorrecto.")
    
    

#--------------------------------Código de la cuarta pestaña--------------------------------

#Etiquetas que permiten visualizar texto en la quinta pestaña
etiqueta_tab4=Label(tab4,text="Cantidad de ordenes y ventas, así como el monto total \nde dichas ventas entre dos fechas dadas")
etiqueta_tab4.place(relx=0.002,rely=0.04,relwidth=1)
etiqueta_tab4.config(bg="#245485",fg="white",font=("Arial",13,"bold"))
etiqueta2_tab4=Label(tab4,text="Ingresa la fecha inicial empezando por día o por año(Límite inferior)")
etiqueta2_tab4.place(relx=0.017,rely=0.662,relwidth=1)
etiqueta2_tab4.config(bg="#245485",fg="white",font=("Arial",10,"bold"))
etiqueta3_tab4=Label(tab4,text="Ingresa la fecha final empezando por día o por año(Límite superior)")
etiqueta3_tab4.place(relx=0.017,rely=0.77,relwidth=1)
etiqueta3_tab4.config(bg="#245485",fg="white",font=("Arial",10,"bold"))

#Visualización de lo que devuelve PostgreSQL
listbox_tab4= Listbox(tab4)
listbox_tab4.place(relx=0.127,rely=0.14,relwidth=0.75,relheight=0.50)
barra_tab4 = Scrollbar(tab4,command=listbox.yview)
barra_tab4.place(relx=0.85,rely=0.145,relheight=0.49)
listbox_tab4.config(yscrollcommand=barra_tab4.set,border=0,font=("Arial",12,"bold"))

#Ingreso de la fechas y búsqueda 
entrada_tab4=Entry(tab4)
entrada_tab4.place(relx=0.376,rely=0.715)
entrada_tab4.config(font=(11))
entrada2_tab4=Entry(tab4)
entrada2_tab4.place(relx=0.376,rely=0.82)
entrada2_tab4.config(font=(11))
boton_tab4=Button(tab4,text="Buscar",command=lambda:buscar_tab4())
boton_tab4.place(relx=0.4753,rely=0.9)
boton_tab4.config(bg="white")

#Función que permite buscar por dos fechas
def buscar_tab4():
    variable1=str(entrada_tab4.get())
    variable2=str(entrada2_tab4.get())
    #Se realiza la conexión con postgreSQL
    con = psycopg2.connect(
            database=NOMBRE_BD, 
            user="postgres", 
            password=PASSWORD_POSTGRES, 
            host="localhost"
        )

    try:
        if variable1 !='' and variable2!='':       
            cur=con.cursor()
            cur.execute("SELECT * FROM cantidad_monto_ventas_fechas_function"+"('"+variable1+"',"+"'"+variable2+"');")
            rows = cur.fetchall()
            if(len(rows)!=0):
                listbox_tab4.delete(0, 'end')
                for row in rows:
                    listbox_tab4.insert(0,"Fecha inicial: " + str(row[0]))
                    listbox_tab4.insert(1,"Fecha final: " + str(row[1]))
                    listbox_tab4.insert(2,"Cantidad de ordenes: " + str(row[2]))
                    listbox_tab4.insert(3,"Cantidad de ventas: " + str(row[3]))
                    listbox_tab4.insert(4,"Monto total de ventas: " + str(row[4]))
                con.close()
            else:
                listbox_tab4.delete(0, 'end')
                listbox_tab4.insert(0,"No se encontraron ventas entre esas fechas.")
                con.close()
        else:
            listbox_tab4.delete(0, 'end')
            listbox_tab4.insert(0,"Por favor, ingresa las fechas.")
    except:
        listbox_tab4.delete(0, 'end')
        listbox_tab4.insert(0,"El formato de las fechas es incorrecto, revisalo e intenta de nuevo.")
    
Ventana.mainloop()
