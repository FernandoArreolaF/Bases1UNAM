#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  conexion.py
#  
#  Copyright 2022 serveradmin <serveradmin@bll64>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  
import psycopg2
conexion=psycopg2.connect(database="PROYECTO", user="postgres", password="123456");
print("Restaurante Puro Sabor Mexicano")
print("Elige una opcion")
print("1. Empleados")
print("2. Nueva orden")
print("3. Platillo mas vendido")
print("4. Consultar ordenes")
print("5. Productos no disponibles")
print("6. Crear factura")
print("7. Consultar facturas")
opcion = int(input())
if opcion == 1:
	print("Elige una opcion")
	print("1. Cocineros")
	print("2. Meseros")
	print("3. Administrativos")
	opcion1 = int(input())
	if opcion1 == 1:
		cur1 = conexion.cursor()
		cur1.execute('SELECT "num_Empleado", "nombre_Pila", "ap_Paterno", "ap_Materno", "sueldo", "edad", "estado", "colonia", "código_Postal", "calle", "número", "especialidad", "fecha_Nacimiento" FROM "info_cocineros"')
		listacoc = cur1.fetchall()
		for lst in listacoc:
			print("Número de Empleado: "+str(lst[0]))
			print("Nombre completo: "+lst[1]+" "+lst[2]+" "+lst[3])
			print("Sueldo :$"+str(lst[4]))
			print("Domicilio: "+lst[9]+" "+str(lst[10])+" COLONIA "+lst[7]+" CP "+str(lst[8])+" "+lst[6])
			print("Fecha de Nacimiento: "+str(lst[12]))
			print("Especialidad: "+lst[11])
		print("Teléfonos: ")
		cur14 = conexion.cursor()
		cur14.execute('SELECT * FROM "tel_cocinero"')
		lt1 = cur14.fetchall()
		for l1 in lt1:
			print(str(l1[0])+": "+str(l1[1]))
		print("Presionar S para ver familiares")
		opcf = str(input())
		if opcf == 'S' or opcf == 's':
			cur11 = conexion.cursor()
			cur11.execute('SELECT * FROM fam_cocineros')
			listaf1 = cur11.fetchall()
			for lf1 in listaf1:
				print("CURP: "+lf1[1])
				print("Nombre completo: "+lf1[3]+" "+lf1[4]+" "+lf1[5])
				print("Parentesco: "+lf1[2])
	if opcion1 == 2:
		cur2 = conexion.cursor()
		cur2.execute('SELECT "num_Empleado", "nombre_Pila", "ap_Paterno", "ap_Materno", "sueldo", "edad", "estado", "colonia", "código_Postal", "calle", "número", "hora_Entrada", "hora_Salida", "fecha_Nacimiento" FROM "info_meseros"')
		listames = cur2.fetchall()
		for lst1 in listames:
			print("Número de Empleado: "+str(lst1[0]))
			print("Nombre completo: "+lst1[1]+" "+lst1[2]+" "+lst1[3])
			print("Sueldo :$"+str(lst1[4]))
			print("Domicilio: "+lst1[9]+" "+str(lst1[10])+" COLONIA "+lst1[7]+" CP "+str(lst1[8])+" "+lst1[6])
			print("Fecha de Nacimiento: "+str(lst1[13]))
			print("Horario: De "+str(lst1[11])+" a "+str(lst1[12]))
		print("Teléfonos: ")
		cur15 = conexion.cursor()
		cur15.execute('SELECT * FROM "tel_mesero"')
		lt2 = cur15.fetchall()
		for l2 in lt2:
			print(str(l2[0])+": "+str(l2[1]))
		print("Presionar S para ver familiares")
		opcf = str(input())
		if opcf == 'S' or opcf == 's':
			cur12 = conexion.cursor()
			cur12.execute('SELECT * FROM fam_meseros')
			listaf2 = cur12.fetchall()
			for lf2 in listaf2:
				print("CURP: "+lf2[1])
				print("Nombre completo: "+lf2[3]+" "+lf2[4]+" "+lf2[5])
				print("Parentesco: "+lf2[2])
	if opcion1 == 3:
		cur3 = conexion.cursor()
		cur3.execute('SELECT "num_Empleado", "nombre_Pila", "ap_Paterno", "ap_Materno", "sueldo", "edad", "estado", "colonia", "código_Postal", "calle", "número", "rol", "fecha_Nacimiento" FROM "info_admin"')
		listadmin = cur3.fetchall()
		for lst2 in listadmin:
			print("Número de Empleado: "+str(lst2[0]))
			print("Nombre completo: "+lst2[1]+" "+lst2[2]+" "+lst2[3])
			print("Sueldo :$"+str(lst2[4]))
			print("Domicilio: "+lst2[9]+" "+str(lst2[10])+" COLONIA "+lst2[7]+" CP "+str(lst2[8])+" "+lst2[6])
			print("Fecha de Nacimiento: "+str(lst2[12]))
			print("Puesto: "+str(lst2[11]))
		print("Teléfonos: ")
		cur16 = conexion.cursor()
		cur16.execute('SELECT * FROM "tel_admin"')
		lt1 = cur16.fetchall()
		for l3 in lt3:
			print(str(l3[0])+": "+str(l3[1]))
		print("Presionar S para ver familiares")
		opcf = str(input())
		if opcf == 'S' or opcf == 's':
			cur13 = conexion.cursor()
			cur13.execute('SELECT * FROM fam_admin')
			listaf3 = cur13.fetchall()
			for lf3 in listaf3:
				print("CURP: "+lf3[1])
				print("Nombre completo: "+lf3[3]+" "+lf3[4]+" "+lf3[5])
				print("Parentesco: "+lf3[2])
if opcion == 2:
	cur4 = conexion.cursor()
	cur4.execute('SELECT * FROM "lista_productos"')
	listprod = cur4.fetchall()
	for lst4 in listprod:
		print(str(lst4[0])+" "+lst4[1]+" $"+str(lst4[2]))
	print("Especificar productos a agregar")
	productos = int(input())
	if productos > 0 and productos <= 3:
		for i in range(productos):
			print("Ingresa el ID del producto a añadir")
			id_prod = int(input())
			cur4.execute("CALL NUEVA_ORDEN(%s)",(id_prod,))
			conexion.commit()
			print(conexion.notices)
		print("Ingresar numero de mesero")
		nummes = int(input())
		cur15 = conexion.cursor()
		cur15.execute('SELECT "descripción", "precio" FROM "PRODUCTO" prod FULL OUTER JOIN "LISTA_ORDEN" lst on prod."id_Producto" = lst."id_Producto" WHERE lst."id_Producto" is not null')
		detalle = cur15.fetchall()
		for det in detalle:
			print(det[0]+" $"+str(det[1]))
		cur6 = conexion.cursor()
		cur6.execute("CALL CERRAR_ORDEN(%s)",(nummes,))
		cur6.execute('SELECT "folio", "total" from "ORDEN"')
		miorden = cur6.fetchall()
		for order in miorden:
			print("Folio: "+order[0]+" Total a pagar: $"+str(order[1]))
		cur6.execute('DELETE FROM "LISTA_ORDEN"')
		cur6.execute("CALL BORRAR_ORDEN()")
		conexion.commit()
	elif productos <= 0:
		print("Error: Numero de productos invalido")
	elif productos > 3:
		print("Error: La orden debe ser de 1 a 3 productos")
if opcion == 3:
	cur5 = conexion.cursor()
	cur5.execute('SELECT * FROM "mas_vendido"')
	mv = cur5.fetchall()
	for masven in mv:
		print("Tipo: "+masven[0])
		print("ID: "+str(masven[1]))
		print("Descirpcion: "+masven[2])
		print("Precio: $"+str(masven[4]))
		print("Categoria: "+masven[5])
if opcion == 4:
	print("Elige una opcion")
	print("1. Por mesero")
	print("2. Por fecha de orden")
	print("3. Por intervalo de fechas")
	opcion2 = int(input())
	if opcion2 == 1:
		print("Ingresar numero de empleado")
		nummes1 = int(input())
		cur7 = conexion.cursor()
		cur7.execute("CALL RESUMEN_MESERO(%s)",(nummes1,))
		print(conexion.notices)
	if opcion2 == 2:
		print("Ingresar fecha")
		fecha = str(input())
		cur8 = conexion.cursor()
		cur8.execute("CALL ORDENES_POR_FECHA(%s)",(fecha,))
		print(conexion.notices)
	if opcion2 == 3:
		print("Ingresar fecha de inicio")
		fechaIn = str(input())
		print("Ingresar fecha de fin")
		fechaFin = str(input())
		cur9 = conexion.cursor()
		cur9.execute("CALL ORDENES_ENTRE_FECHAS(%s,%s)",(fechaIn,fechaFin,))
		print(conexion.notices)
if opcion == 5:
	cur10 = conexion.cursor()
	cur10.execute('SELECT * FROM "no_disponibles"')
	nd = cur10.fetchall()
	for nodis in nd:
		print(str(nodis[1])+" "+nodis[2])
if opcion == 6:
	cur17 = conexion.cursor()
	print("Ingresa RFC")
	rfc = str(input())
	print("Ingresa razón social")
	rzs = str(input())
	print("Ingresa nombre")
	nom = str(input())
	print("Ingresa apellido paterno")
	appat = str(input())
	print("Ingresa apellido materno")
	apmat = str(input())
	print("Ingresa estado")
	est = str(input())
	print("Ingresa colonia")
	col = str(input())
	print("Ingresa CP")
	cp = int(input())
	print("Ingresa calle")
	cal = str(input())
	print("Ingresa numero")
	num = int(input())
	print("Ingresa folio")
	folio = str(input())
	cur17.execute("CALL crear_factura(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(rfc,rzs,nom,appat,apmat,est,col,cp,cal,num,folio,))
	conexion.commit()
if opcion == 7:
	cur18 = conexion.cursor()
	cur18.execute('SELECT "rfc_Cliente", "razón_Social", "folio_ORDEN" from "FACTURA"')
	lisfac = cur18.fetchall()
	for lf in lisfac:
		print("RFC: "+lf[0])
		print("Razón social: "+lf[1])
		print("Folio: "+lf[2])
		
