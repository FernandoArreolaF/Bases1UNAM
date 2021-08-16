from tkinter import *
import psycopg2
from tkinter import messagebox

window = Tk()
window.title("Papeleria")
window.geometry("1500x1200")

canvas = Canvas(window, height=1200, width=1500)
canvas.pack()
canvas.config(bg="black")

frame = Frame()
frame.place(relx=0.1, rely=0.1, relheight=0.8, relwidth=0.8)
frame.config(bg="blue")

label = Label(frame, text=' SISTEMA DE LA PAPELERIA ', font=("Arial",24), anchor=CENTER, bg="pink")
label.grid(row=0, column=3, columnspan=4, sticky=W+E)

label  = Label(frame, text='', bg="blue")
label.grid(row=1, column=1)
label = Label(frame, text='Registrar producto', font=("Arial",14), anchor=CENTER, bg="orange")
label.grid(row=2, column=2, sticky=W+E)
label = Label(frame, text='Registrar provedor', font=("Arial",14), anchor=CENTER, bg="green")
label.grid(row=2, column=4, sticky=W+E)
label = Label(frame, text='  Registrar cliente  ', font=("Arial",14), anchor=CENTER, bg="yellow")
label.grid(row=2, column=6, sticky=W+E)
label = Label(frame, text='           Venta           ', font=("Arial",14), anchor=CENTER, bg="red")
label.grid(row=2, column=8, sticky=W+E)
label  = Label(frame, text='', bg="blue")
label.grid(row=3, column=1)
#--------------------------------------producto
label = Label(frame, text='Codigo de barras:', font=("Arial",10), anchor=W)
label.grid(row=4, column=1, sticky=W+E)
entry1=Entry(frame)
entry1.grid(row=4, column=2)
label = Label(frame, text='Precio Compra:', font=("Arial",10), anchor=W)
label.grid(row=5, column=1, sticky=W+E)
entry2=Entry(frame)
entry2.grid(row=5, column=2)
label = Label(frame, text='Precio Venta:', font=("Arial",10), anchor=W)
label.grid(row=6, column=1, sticky=W+E)
entry3=Entry(frame)
entry3.grid(row=6, column=2)
label = Label(frame, text='Fecha:', font=("Arial",10), anchor=W)
label.grid(row=7, column=1, sticky=W+E)
label = Label(frame, text='Automatico', font=("Arial",10), bg="pink")
label.grid(row=7, column=2)
label = Label(frame, text='Cantidad:', font=("Arial",10), anchor=W)
label.grid(row=8, column=1, sticky=W+E)
entry5=Entry(frame)
entry5.grid(row=8, column=2)
label = Label(frame, text='Nombre:', font=("Arial",10), anchor=W)
label.grid(row=9, column=1, sticky=W+E)
entry6=Entry(frame)
entry6.grid(row=9, column=2)
label = Label(frame, text='Marca:', font=("Arial",10), anchor=W)
label.grid(row=10, column=1, sticky=W+E)
entry7=Entry(frame)
entry7.grid(row=10, column=2)
label = Label(frame, text='Descripcion:', font=("Arial",10), anchor=W)
label.grid(row=11, column=1, sticky=W+E)
entry8=Entry(frame)
entry8.grid(row=11, column=2)
label = Label(frame, text='Provedor:', font=("Arial",10), anchor=W)
label.grid(row=12, column=1, sticky=W+E)
entry9=Entry(frame)
entry9.grid(row=12, column=2)
#--------------------------------------provedor
label = Label(frame, text='ID Provedor:', font=("Arial",10), anchor=W)
label.grid(row=4, column=3, sticky=W+E)
label = Label(frame, text='Automatico', font=("Arial",10), bg="pink")
label.grid(row=4, column=4)
label = Label(frame, text='Nombre:', font=("Arial",10), anchor=W)
label.grid(row=5, column=3, sticky=W+E)
entry11=Entry(frame)
entry11.grid(row=5, column=4)
label = Label(frame, text='Apellido:', font=("Arial",10), anchor=W)
label.grid(row=6, column=3, sticky=W+E)
entry12=Entry(frame)
entry12.grid(row=6, column=4)
label = Label(frame, text='Estado:', font=("Arial",10), anchor=W)
label.grid(row=7, column=3, sticky=W+E)
entry13=Entry(frame)
entry13.grid(row=7, column=4)
label = Label(frame, text='Cod Postal:', font=("Arial",10), anchor=W)
label.grid(row=8, column=3, sticky=W+E)
entry14=Entry(frame)
entry14.grid(row=8, column=4)
label = Label(frame, text='Colonia:', font=("Arial",10), anchor=W)
label.grid(row=9, column=3, sticky=W+E)
entry15=Entry(frame)
entry15.grid(row=9, column=4)
label = Label(frame, text='Calle:', font=("Arial",10), anchor=W)
label.grid(row=10, column=3, sticky=W+E)
entry16=Entry(frame)
entry16.grid(row=10, column=4)
label = Label(frame, text='Numero:', font=("Arial",10), anchor=W)
label.grid(row=11, column=3, sticky=W+E)
entry17=Entry(frame)
entry17.grid(row=11, column=4)
label = Label(frame, text='Razon Social:', font=("Arial",10), anchor=W)
label.grid(row=12, column=3, sticky=W+E)
entry18=Entry(frame)
entry18.grid(row=12, column=4)
label = Label(frame, text='Telefono 1:', font=("Arial",10), anchor=W)
label.grid(row=13, column=3, sticky=W+E)
entry19=Entry(frame)
entry19.grid(row=13, column=4)
label = Label(frame, text='Telefono 2:', font=("Arial",10), anchor=W)
label.grid(row=14, column=3, sticky=W+E)
entry20=Entry(frame)
entry20.grid(row=14, column=4)
#--------------------------------------cliente
label = Label(frame, text='ID Cliente:', font=("Arial",10), anchor=W)
label.grid(row=4, column=5, sticky=W+E)
label = Label(frame, text='Automatico', font=("Arial",10), bg="pink")
label.grid(row=4, column=6)
label = Label(frame, text='Nombre:', font=("Arial",10), anchor=W)
label.grid(row=5, column=5, sticky=W+E)
entry22=Entry(frame)
entry22.grid(row=5, column=6)
label = Label(frame, text='Apellido:', font=("Arial",10), anchor=W)
label.grid(row=6, column=5, sticky=W+E)
entry23=Entry(frame)
entry23.grid(row=6, column=6)
label = Label(frame, text='Estado:', font=("Arial",10), anchor=W)
label.grid(row=7, column=5, sticky=W+E)
entry24=Entry(frame)
entry24.grid(row=7, column=6)
label = Label(frame, text='Cod Postal:', font=("Arial",10), anchor=W)
label.grid(row=8, column=5, sticky=W+E)
entry25=Entry(frame)
entry25.grid(row=8, column=6)
label = Label(frame, text='Colonia:', font=("Arial",10), anchor=W)
label.grid(row=9, column=5, sticky=W+E)
entry26=Entry(frame)
entry26.grid(row=9, column=6)
label = Label(frame, text='Calle:', font=("Arial",10), anchor=W)
label.grid(row=10, column=5, sticky=W+E)
entry27=Entry(frame)
entry27.grid(row=10, column=6)
label = Label(frame, text='Numero:', font=("Arial",10), anchor=W)
label.grid(row=11, column=5, sticky=W+E)
entry28=Entry(frame)
entry28.grid(row=11, column=6)
label = Label(frame, text='RFC:', font=("Arial",10), anchor=W)
label.grid(row=12, column=5, sticky=W+E)
entry29=Entry(frame)
entry29.grid(row=12, column=6)
label = Label(frame, text='Email:', font=("Arial",10), anchor=W)
label.grid(row=13, column=5, sticky=W+E)
entry30=Entry(frame)
entry30.grid(row=13, column=6)
label = Label(frame, text='Email2:', font=("Arial",10), anchor=W)
label.grid(row=14, column=5, sticky=W+E)
entry31=Entry(frame)
entry31.grid(row=14, column=6)
#--------------------------------------venta
label = Label(frame, text='Num Venta:', font=("Arial",10), anchor=W)
label.grid(row=4, column=7, sticky=W+E)
label = Label(frame, text='Automatico', font=("Arial",10), bg="pink")
label.grid(row=4, column=8)
label = Label(frame, text='ID Cliente:', font=("Arial",10), anchor=W)
label.grid(row=5, column=7, sticky=W+E)
entry33=Entry(frame)
entry33.grid(row=5, column=8)
label = Label(frame, text='Codigo de barras:', font=("Arial",10), anchor=W)
label.grid(row=6, column=7, sticky=W+E)
entry34=Entry(frame)
entry34.grid(row=6, column=8)
label = Label(frame, text='Fecha:', font=("Arial",10), anchor=W)
label.grid(row=7, column=7, sticky=W+E)
label = Label(frame, text='Automatico', font=("Arial",10), bg="pink")
label.grid(row=7, column=8)
label = Label(frame, text='Cantidad:', font=("Arial",10), anchor=W)
label.grid(row=8, column=7, sticky=W+E)
label = Label(frame, text='Automatico', font=("Arial",10), bg="pink")
label.grid(row=8, column=8)

def save_producto(cod, pc, pv, cant, nom, marca, desc, prov):
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query='''INSERT INTO PRODUCTO VALUES(%s,%s,%s,CURRENT_DATE,%s,%s,%s,%s,%s)'''
	cursor.execute(query,(cod, pc, pv, cant, nom, marca, desc, prov))
	messagebox.showinfo("Producto", "Se registro un producto!")
	conn.commit()
	conn.close()
	display_producto()

def save_provedor(nom, ap, est, cp, col, calle, num, rz, t1, t2):
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query='''INSERT INTO PROVEDOR VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s)'''
	query2='''INSERT INTO TELEFONO VALUES(%s,%s)'''
	query3='''SELECT COUNT(*) FROM PROVEDOR'''
	cursor.execute(query3)
	row=cursor.fetchone()
	nextidp=int((str(row)[1:-2]))+1
	cursor.execute(query,(str(nextidp), nom, ap, est, cp, col, calle, num, rz))
	cursor.execute(query2,(str(nextidp), t1))
	if t2:
		cursor.execute(query2,(str(nextidp), t2))
	messagebox.showinfo("Proveedor", "Se registro un proveedor!")
	conn.commit()
	conn.close()
	display_provedor()

def save_cliente(nom, ap, est, cp, col, calle, num, rfc, c1, c2):
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query='''INSERT INTO CLIENTE VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s)'''
	query2='''INSERT INTO EMAIL VALUES(%s,%s)'''
	query3='''SELECT COUNT(*) FROM CLIENTE'''
	cursor.execute(query3)
	row=cursor.fetchone()
	nextidc=int((str(row)[1:-2]))+1
	cursor.execute(query,(str(nextidc), nom, ap, est, cp, col, calle, num, rfc))
	cursor.execute(query2,(str(nextidc), c1))
	if c2:
		cursor.execute(query2,(str(nextidc), c2))
	messagebox.showinfo("Cliente", "Se registro un cliente!")
	conn.commit()
	conn.close()
	display_cliente()

def venta(idc, cod):
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()	
	query='''INSERT INTO VENTA VALUES(%s,%s,%s,CURRENT_DATE,%s)'''
	query2=f'''SELECT PRECIO_VENTA FROM PRODUCTO WHERE codigo_barras={cod}'''
	query3='''SELECT COUNT(*) FROM VENTA'''
	query4=f'''SELECT CANTIDAD_EJEM FROM PRODUCTO WHERE codigo_barras={cod}'''	
	cursor.execute(query3)
	row=cursor.fetchone()
	nextnv=int((str(row)[1:-2]))+1
	if nextnv<10:
		snextnv=f"VENT-00{nextnv}"
	elif nextnv<100:
		snextnv=f"VENT-0{nextnv}"
	elif nextnv<1000:
		snextnv=f"VENT-{nextnv}" 
	else:	
		print("La base de datos esta llena\n")
	cursor.execute(query4)
	row=cursor.fetchone()
	ncantidad=(int(str(row)[10:-4]))-1
	if ncantidad<0:
		messagebox.showerror("ERROR", "Ya no hay stock!")
	else:
		if ncantidad<3:
			messagebox.showwarning("ERROR", f"Con esta venta quedarian {ncantidad} articulos!")
		query5=f'''UPDATE PRODUCTO SET CANTIDAD_EJEM={ncantidad} WHERE codigo_barras={cod}'''
		cursor.execute(query5)
		cursor.execute(query2)
		row=cursor.fetchone()	
		cursor.execute(query,(snextnv, idc, cod, str(row)[10:-4]))
		messagebox.showinfo("Venta", "Compra registrada!")
	conn.commit()
	conn.close()
	display_producto()
	display_venta()

label = Label(frame, text='', bg="blue")
label.grid(row=16, column=1)
label = Label(frame, text='', bg="blue")
label.grid(row=17, column=1)
label = Label(frame, text='CodigoBarras|Nombre|Precio|Stock|', bg="orange", anchor=W)
label.grid(row=18, column=2, columnspan=2, sticky=W+E)
def display_producto():
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query='''SELECT CODIGO_BARRAS, NOMBRE, PRECIO_VENTA, CANTIDAD_EJEM FROM PRODUCTO'''
	cursor.execute(query)
	row=cursor.fetchall()
	listbox = Listbox(frame, width=16, heigh=4)
	listbox.grid(row=19, column=2, columnspan=3, sticky=W+E)
	for x in row:
		listbox.insert(END, x)
	conn.commit()
	conn.close()

label = Label(frame, text='ID|Apellido|Nombre|RazonSocial|Telefono|', bg="green", anchor=W)
label.grid(row=20, column=2, columnspan=2, sticky=W+E)
def display_provedor():
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query='''SELECT ID_PROVEDOR, APELLIDO, NOMBRE, RAZON_SOCIAL FROM PROVEDOR'''
	cursor.execute(query)
	row=cursor.fetchall()
	listbox = Listbox(frame, width=16, heigh=4)
	listbox.grid(row=21, column=2, columnspan=2, sticky=W+E)
	for x in row:
		listbox.insert(END, x)
	query2='''SELECT *FROM TELEFONO'''
	cursor.execute(query2)
	row2=cursor.fetchall()
	listbox = Listbox(frame, width=16, heigh=4)
	listbox.grid(row=21, column=4, columnspan=1, sticky=W+E)
	for x in row2:
		listbox.insert(END, x)
	conn.commit()
	conn.close()

label = Label(frame, text='ID|Apellido|Nombre|RFC|EMAIL|', bg="yellow", anchor=W)
label.grid(row=22, column=2, columnspan=2, sticky=W+E)
def display_cliente():
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query='''SELECT ID_CLIENTE, APELLIDO, NOMBRE, RFC FROM CLIENTE'''
	cursor.execute(query)
	row=cursor.fetchall()
	listbox = Listbox(frame, width=16, heigh=4)
	listbox.grid(row=23, column=2, columnspan=2, sticky=W+E)
	for x in row:
		listbox.insert(END, x)
	query2='''SELECT * FROM EMAIL'''
	cursor.execute(query2)
	row2=cursor.fetchall()
	listbox = Listbox(frame, width=16, heigh=4)
	listbox.grid(row=23, column=4, columnspan=1, sticky=W+E)
	for x in row2:
		listbox.insert(END, x)
	conn.commit()
	conn.close()

label = Label(frame, text='Numero|CodigoBarras|Cliente|Fecha|Precio', bg="red", anchor=W)
label.grid(row=24, column=2, columnspan=2, sticky=W+E)
def display_venta():
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query='''SELECT NUM_VENTA, CODIGO_BARRAS, ID_CLIENTE, FECHA_VENTA, CANTIDAD_PAGAR FROM VENTA'''
	cursor.execute(query)
	row=cursor.fetchall()
	listbox = Listbox(frame, width=16, heigh=4)
	listbox.grid(row=25, column=2, columnspan=3, sticky=W+E)
	for x in row:
		listbox.insert(END, x)
	conn.commit()
	conn.close()

button = Button(frame, text="Guardar producto", bg='orange', command=lambda:save_producto(
	entry1.get(),
	entry2.get(),
	entry3.get(),
	entry5.get(),
	entry6.get(),
	entry7.get(),
	entry8.get(),
	entry9.get()))
button.grid(row=15, column=2, sticky=W+E)

button = Button(frame, text="Guardar provedor", bg='green', command=lambda:save_provedor(
	entry11.get(),
	entry12.get(),
	entry13.get(),
	entry14.get(),
	entry15.get(),
	entry16.get(),
	entry17.get(),
	entry18.get(),
	entry19.get(),
	entry20.get()))
button.grid(row=15, column=4, sticky=W+E)

button = Button(frame, text="Guardar cliente", bg='yellow', command=lambda:save_cliente(
	entry22.get(),
	entry23.get(),
	entry24.get(),
	entry25.get(),
	entry26.get(),
	entry27.get(),
	entry28.get(),
	entry29.get(),
	entry30.get(),
	entry31.get()))
button.grid(row=15, column=6, sticky=W+E)

button = Button(frame, text="Vender", bg='red', command=lambda:venta(
	#entry32.get(),
	entry33.get(),
	entry34.get()))
button.grid(row=15, column=8, sticky=W+E)

#------------------------borrar

def borrar_producto(cb):
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query=f'''DELETE FROM PRODUCTO WHERE CODIGO_BARRAS={cb}'''
	cursor.execute(query)	
	messagebox.showinfo("Borrado", f"Se borro el producto: {cb}!")
	conn.commit()
	conn.close()
	display_producto()

def borrar_provedor(idp):
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query=f'''DELETE FROM PROVEDOR WHERE ID_PROVEDOR={idp}'''
	query2=f'''DELETE FROM TELEFONO WHERE ID_PROVEDOR={idp}'''
	cursor.execute(query2)
	cursor.execute(query)	
	messagebox.showinfo("Borrado", f"Se borro el proveedor: {idp}!")
	conn.commit()
	conn.close()
	display_provedor()

def borrar_cliente(idc):
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query=f'''DELETE FROM CLIENTE WHERE ID_CLIENTE={idc}'''
	query2=f'''DELETE FROM EMAIL WHERE ID_CLIENTE={idc}'''
	cursor.execute(query2)
	cursor.execute(query)		
	messagebox.showinfo("Borrado", f"Se borro el cliente: {idc}!")
	conn.commit()
	conn.close()
	display_cliente()

def borrar_venta(nv):
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query=f'''DELETE FROM VENTA WHERE NUM_VENTA='{nv}';'''
	cursor.execute(query)	
	messagebox.showinfo("Borrado", f"Se borro la venta: {nv}!")
	conn.commit()
	conn.close()
	display_venta()

button = Button(frame, text="Borrar producto:", bg='orange', command=lambda:borrar_producto(
	entry35.get()))
button.grid(row=18, column=6, sticky=W+E)
entry35=Entry(frame, bg='orange')
entry35.grid(row=19, column=6)
button = Button(frame, text="Borrar proveedor:", bg='green', command=lambda:borrar_provedor(
	entry36.get()))
button.grid(row=20, column=6, sticky=W+E)
entry36=Entry(frame, bg='green')
entry36.grid(row=21, column=6)
button = Button(frame, text="Borrar cliente:", bg='yellow', command=lambda:borrar_cliente(
	entry37.get()))
button.grid(row=22, column=6, sticky=W+E)
entry37=Entry(frame, bg='yellow')
entry37.grid(row=23, column=6)
button = Button(frame, text="Borrar venta:", bg='red', command=lambda:borrar_venta(
	entry38.get()))
button.grid(row=24, column=6, sticky=W+E)
entry38=Entry(frame, bg='red')
entry38.grid(row=25, column=6)


#----------------------consultas
def utilidad(cb):
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query=f'''SELECT (PRECIO_VENTA-PRECIO_COMPRA) FROM PRODUCTO WHERE CODIGO_BARRAS={cb}'''
	cursor.execute(query)
	row=cursor.fetchone()
	listbox = Listbox(frame, width=8, heigh=1)
	listbox.grid(row=25, column=8, columnspan=1)
	for x in row:
		listbox.insert(END, x)
	conn.commit()
	conn.close()
	label = Label(frame, text='UTILIDAD:')
	label.grid(row=24, column=8, sticky=W+E)

def fechas(f1, f2):
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query=f'''SELECT SUM(CANTIDAD_PAGAR) FROM VENTA WHERE FECHA_VENTA BETWEEN '{f1}' AND '{f2}';'''
	cursor.execute(query)
	row=cursor.fetchone()
	listbox = Listbox(frame, width=8, heigh=1)
	listbox.grid(row=25, column=8, columnspan=1)
	for x in row:
		listbox.insert(END, x)
	conn.commit()
	conn.close()
	label = Label(frame, text='Ganancia del preriodo:')
	label.grid(row=24, column=8, sticky=W+E)

def pocos_productos():
	conn=psycopg2.connect(
		dbname="papeleria",
		user="postgres",
		password="postgres",
		host="localhost",
		port="5432")
	cursor=conn.cursor()
	query=f'''SELECT NOMBRE FROM PRODUCTO WHERE CANTIDAD_EJEM<=3'''
	cursor.execute(query)
	row=cursor.fetchall()
	listbox = Listbox(frame, width=8, heigh=1)
	listbox.grid(row=25, column=8, columnspan=1)
	for x in row:
		listbox.insert(END, x)
	conn.commit()
	conn.close()
	label = Label(frame, text='Comprar mas de estos productos:')
	label.grid(row=24, column=8, sticky=W+E)

button = Button(frame, text="Calcular utilidad:", command=lambda:utilidad(
	entry39.get()))
button.grid(row=18, column=8, sticky=W+E)
entry39=Entry(frame)
entry39.grid(row=19, column=8)

button = Button(frame, text="Ganancia del preriodo:", command=lambda:fechas(
	entry40.get(),
	entry41.get()))
button.grid(row=20, column=8, sticky=W+E)
entry40=Entry(frame)
entry40.grid(row=21, column=8)
entry41=Entry(frame)
entry41.grid(row=21, column=9)

button = Button(frame, text="Pocos productos:", command=lambda:pocos_productos())
button.grid(row=22, column=8, sticky=W+E)

display_venta()
display_producto()
display_provedor()
display_cliente()
window.mainloop()