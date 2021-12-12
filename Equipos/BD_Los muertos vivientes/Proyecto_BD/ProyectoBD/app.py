from flask import Flask, render_template, request
from flask.wrappers import Request
import psycopg2

app = Flask(__name__)



try:
    Connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '1234',
        database = 'proyecto_bd'
    )
    print("conexion exitosa")
    cursor = Connection.cursor()
    
except Exception as ex:
    print(ex)

@app.route('/')
def Hola():
    return render_template('cliente.html')

@app.route('/cliente', methods = ['POST'])
def cliente():
    if request.method == 'POST':
        nombre = request.form['nombre']
        ap_paterno = request.form['ap_paterno']
        ap_materno = request.form['ap_materno']
        rfc = request.form['rfc']
        estado = request.form['estado']
        colonia = request.form['colonia']
        codigo_postal = request.form['codigo_postal']
        calle = request.form['calle']
        numero = request.form['numero']
        id_cliente = request.form['id_cliente']
        insertSQLcliente = """INSERT INTO public.cliente(
	    id_cliente, rfc, nombre, ap_paterno, ap_materno, estado, colonia, codigo_postal, calle, numero)
	    VALUES (%s, %s, %s, %s, %s, %s,%s, %s, %s, %s);"""
        cursor.execute(insertSQLcliente,(id_cliente,rfc,nombre,ap_paterno,ap_materno,estado,colonia,codigo_postal,calle,numero))
        print("deberia imprimir")
        Connection.commit()
    return render_template('venta.html')
    
@app.route('/venta',methods = ['POST'])
def venta():
    if request.method == 'POST':
        id_tienda= request.form['id_tienda']
        fecha_venta = request.form['fecha_venta']
        num_venta = request.form['num_venta']
        id_venta = request.form['id_venta']
        id_cliente = request.form['id_cliente']
        
        insertSQLcliente = """INSERT INTO public.venta(
        id_venta, num_venta, total_venta, fecha_venta, id_tienda, id_cliente)
        VALUES 
        (%s, %s, %s, %s, %s, %s);"""
        cursor.execute(insertSQLcliente,(id_venta,num_venta,0,fecha_venta,id_tienda,id_cliente))
        
        print("deberia imprimir")
        Connection.commit()
    return render_template('productoVenta.html')

@app.route('/producto',methods = ['POST'])
def producto():
    if request.method == 'POST':
        codigo_barras= request.form['codigo_barras']
        id_venta = request.form['id_venta']
        cantidad = request.form['cantidad']
        marca = request.form['marca']
        descripcion = request.form['descripcion']
        
        insertSQLcliente = """INSERT INTO public.producto_venta(
        descripcion, marca, cantidad, total_articulo, codigo_barras, id_venta)
        VALUES 
        (%s, %s, %s, %s , %s, %s);"""
        cursor.execute(insertSQLcliente,(descripcion,marca,cantidad,0,codigo_barras,id_venta))
        print("deberia imprimir")
        Connection.commit()
    return render_template('productoVenta.html')
 



if __name__ == "__main__":
    app.run(debug = True , port = 4000)