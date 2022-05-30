import PIL

from tkinter import ttk
from tkinter import *
from datetime import datetime
from tkinter import Menubutton, Menu, Label, messagebox
from Controlador import Controlador
from PIL import Image, ImageTk

class Ventana_Orden():
  
  MAX_PRODUCTOS = 6

  # cosntructor de la ventana de ordenes
  def __init__(self, root: Tk, controlador: Controlador) -> None:
    
    # lista para almacenar los productos que se seleccionen para la orden
    self.orden = []
    
    # variable para conocer cuantos productos llevamos en la orden
    self.cantidad_productos = 0
    self.app = controlador

    self.img_dlt = Image.open('boton-eliminar.png')
    self.img_dlt = self.img_dlt.resize((25,25))
    self.img_dlt = ImageTk.PhotoImage(self.img_dlt)

    # obtenemos una lista de todos los productos disponibles 
    self.lista_productos = self.app.obtener_productos()

    # contenedor para seleccionar productos para la orden 
    self.contenedor_principal = Frame(root)

    # contenedor para meter los datos del cliente si requiere factura
    self.contenedor_factura = Frame(root)

    self.init_UI_orden()

  #coloca en pantalla el producto a aniadir en pantalla
  def seleccionar_producto_platillo(self, *args):
    self.producto_seleccionado.set(self.platillo_seleccionado.get())

  def seleccionar_producto_bebida(self, *args):
    self.producto_seleccionado.set(self.bebida_seleccionada.get())

  def busca_producto(self, nombre_producto):
    
    for p in self.lista_productos:
      if p.nombre == nombre_producto:
        return p

    return None

  def eliminar_producto_orden(self, contenedor, p):
    for i in range(len(self.orden)):
      if self.orden[i].nombre == p.nombre:
        self.orden.pop(i)
        contenedor.pack_forget()
        contenedor.destroy()
        self.cantidad_productos = self.cantidad_productos - 1
        break

  def aumentar_cantidad(self, producto, cantidad):
    for p in self.orden:
      if p.nombre == producto.nombre:
        p.cantidad = cantidad

  def agregar_producto(self, ventana: Frame, producto):

    #Obtiene el valor del campo
    nombre_producto = producto.get()

    if nombre_producto == '':
      messagebox.showinfo(
          message="No se ha seleccionado un producto para agregar.", 
          title="Mensaje"
        )
    else:
      
      p = self.busca_producto(nombre_producto)

      # checa si ya se agrego el producto a la orden 
      encontrado = False
      for item in self.orden:
        if item.nombre == p.nombre:
          encontrado = True
          break
      
      if encontrado:
        messagebox.showinfo(
            message="Producto ya añadido, aumente su cantidad.", 
            title="Mensaje"
          )
          
      elif self.cantidad_productos >= self.MAX_PRODUCTOS:
        
        messagebox.showinfo(
            message="Limite de productos por orden alcanzado.", 
            title="Mensaje"
          )

      else:
        if p: 
          ventana_producto = Frame(
              ventana, 
              width=610, 
              height=40, 
              bg='blue',
            )

          ventana_producto.pack(fill='x', pady=10)
          ventana_producto.columnconfigure(0, weight=1)
          ventana_producto.columnconfigure(1, weight=1)
          ventana_producto.columnconfigure(2, weight=1)
          ventana_producto.columnconfigure(3, weight=1)

          cantidad = StringVar(value=1)

          Label(
              ventana_producto, 
              text = p.nombre,
              wraplength=200
            ).grid(
                column=0, 
                row=0, 
                padx=10, 
                pady=10,
                sticky=W
            )

          Label(
              ventana_producto, 
              text= str(p.precio),
              width=20
            ).grid(
                column=1, 
                row=0, 
                padx=10, 
                pady=10,
                sticky=W
            )
          
          Spinbox(
            ventana_producto, 
            from_=1, to=20, increment=1,
            textvariable=cantidad,
            width=10,
            command=lambda: self.aumentar_cantidad(p, int(cantidad.get()))
          ).grid(column=2, row=0, padx=10, pady=10, sticky=W)
          
          ttk.Button(
            ventana_producto, 
            image=self.img_dlt,
            command=lambda: self.eliminar_producto_orden(ventana_producto, p)
          ).grid(column=3, row=0, pady=10)

          p.cantidad = 1
          self.orden.append(p)

          self.cantidad_productos = self.cantidad_productos + 1

  def limpiar_campos(self):
    self.cuerpo_ventana_agregado.destroy()
    self.cuerpo_ventana_agregado = Frame(self.ventana_agregado)
    self.cuerpo_ventana_agregado.pack(fill='x')

    self.orden = []
    self.cantidad_productos = 0

    self.entry_rfc_cliente.delete(0, "end")

  def enviar_orden(self, id_empleado, rfc_cliente):
    if len(self.orden) == 0: 
      messagebox.showinfo(
          message="Se debe agregar por lo menos un producto antes.", 
          title="Mensaje"
        )

    elif id_empleado == "":
      messagebox.showinfo(
          message="Se debe agregar el numero del mesero.", 
          title="Mensaje"
        )

    else:
      if rfc_cliente == "":
        res = self.app.enviar_orden(self.orden, int(id_empleado))
        if res[0]: 
          messagebox.showinfo(
            message=res[1], 
            title="Mensaje"
          )

          self.limpiar_campos()
        
        else:
          messagebox.showinfo(
            message=res[1], 
            title="Mensaje"
          )
      else:
        res = self.app.enviar_orden_factura(self.orden, int(id_empleado), str(rfc_cliente).upper())
        if res[0]: 
          messagebox.showinfo(
            message=res[1], 
            title="Mensaje"
          )

          self.limpiar_campos()

        else:
          messagebox.showinfo(
            message=res[1], 
            title="Mensaje"
          )

  #inicializacion_interfaz
  def init_UI_orden(self):
    
    # contenedor principal
    self.contenedor_principal.config(bd=5)
    self.contenedor_principal.config(relief='raised')
    self.contenedor_principal.pack(expand=True, fill='both')

    #definicion de ventanas y configuracion 

    ventana_encabezado = Frame(self.contenedor_principal, padx=10, pady=10, border=10)
    ventana_encabezado.config(height=50)
    ventana_encabezado.pack(fill='x')
    ventana_encabezado.columnconfigure(0, weight=1)
    ventana_encabezado.columnconfigure(1, weight=1)
    ventana_encabezado.columnconfigure(2, weight=1)

    ventana_seleccion = Frame(self.contenedor_principal, padx=20, pady=20)
    ventana_seleccion.config(bg='white', relief='groove', bd=3, width=600, height=100)
    ventana_seleccion.pack(fill='x', padx=20, pady=20)
    ventana_seleccion.columnconfigure(0, weight=1)
    ventana_seleccion.columnconfigure(1, weight=1)

    self.ventana_agregado = Frame(self.contenedor_principal, border=20)
    self.ventana_agregado.config(relief='ridge', bd=3, bg='white')
    self.ventana_agregado.pack(padx=20, pady=20, fill='x')

    encabezado_ventana_agregado = Frame(self.ventana_agregado)
    encabezado_ventana_agregado.pack(fill='x')

    encabezado_ventana_agregado.columnconfigure(0, weight=1)
    encabezado_ventana_agregado.columnconfigure(1, weight=1)
    encabezado_ventana_agregado.columnconfigure(2, weight=1)
    encabezado_ventana_agregado.columnconfigure(3, weight=1)

    self.cuerpo_ventana_agregado = Frame(self.ventana_agregado)
    self.cuerpo_ventana_agregado.pack(fill='x')

    ventana_envio_orden = Frame(self.contenedor_principal)
    ventana_envio_orden.pack(fill='x', padx=20, pady=10)

    # === contenido de ventana_encabezado ===
    Label(
        ventana_encabezado, 
        text='Nueva orden',
        justify=CENTER
      ).grid(column=0, row=0, padx=20, columnspan=3)

    Label(
        ventana_encabezado, 
        text='fecha: ' + datetime.today().strftime('%d-%m-%Y')
    ).grid(column=0, row=3)

    contenedor_empleado = Frame(ventana_encabezado)
    contenedor_empleado.grid(column=2, row=3)

    Label(
        contenedor_empleado,
        text="Numero Empleado: "
      ).pack(side=LEFT)

    self.entry_id_empleado = Entry(contenedor_empleado)
    self.entry_id_empleado.pack(side=RIGHT)

    # === contenido de ventana_seleccion ===
    #para saber que producto fue seleccionado
    self.producto_seleccionado = StringVar(ventana_seleccion)
    self.producto_seleccionado.set('')

    self.platillo_seleccionado = StringVar(ventana_seleccion)
    self.platillo_seleccionado.set('Sin seleccion')

    self.bebida_seleccionada = StringVar(ventana_seleccion)
    self.bebida_seleccionada.set('Sin seleccion')

    lista_platillos = []
    lista_bebidas = []

    for p in self.lista_productos:
      if p.tipo == 'Bebida':
        lista_bebidas.append(p)
      elif p.tipo == 'Platillo':
        lista_platillos.append(p)

    Label(
        ventana_seleccion, 
        text='Platillo',
        justify=CENTER,
        bg='white'
    ).grid(column=0, row=0)

    menu_platillos = OptionMenu(
        ventana_seleccion, 
        self.platillo_seleccionado, 
        *lista_platillos
      )

    menu_platillos.grid(column=0, row=1)

    Label(
        ventana_seleccion, 
        text='Bebida',
        justify=CENTER,
        bg='white'
    ).grid(column=1, row=0)

    menu_bebida = OptionMenu(
        ventana_seleccion, 
        self.bebida_seleccionada, 
        *lista_bebidas
      )

    menu_bebida.grid(column=1, row=1)

    mensaje_seleccion = Label(
      ventana_seleccion, 
      textvariable=self.producto_seleccionado,
      justify=CENTER,
      bg='white'
    ).grid(column=0, row=3, rowspan=2)

    self.platillo_seleccionado.trace('w', self.seleccionar_producto_platillo)
    self.bebida_seleccionada.trace('w', self.seleccionar_producto_bebida)

    boton_agregar = Button(
        ventana_seleccion, 
        text='Agregar', 
        command=lambda: self.agregar_producto(self.cuerpo_ventana_agregado, self.producto_seleccionado)
      )

    boton_agregar.grid(column=1, row=3, rowspan=2)

    # === contenido de ventana_agregado ===

    Label(encabezado_ventana_agregado, text='Nombre').grid(column=0, row=0, padx=10)
    Label(encabezado_ventana_agregado, text='Precio').grid(column=1, row=0, padx=10)
    Label(encabezado_ventana_agregado, text='Cantidad').grid(column=2, row=0, padx=10)
    Label(encabezado_ventana_agregado, text='Del').grid(column=3, row=0, padx=10)

    # === contenido ventana_envio_orden ===
    
    contenedor_cliente = Frame(
      ventana_envio_orden
    )
    contenedor_cliente.pack(side=LEFT)

    Label(contenedor_cliente, text="RFC cliente").pack(side=LEFT)

    self.entry_rfc_cliente = Entry(contenedor_cliente)
    self.entry_rfc_cliente.pack(side=RIGHT)

    btn_enviar_orden = Button(
        ventana_envio_orden, 
        text="Terminar orden",
        command=lambda: self.enviar_orden(
            self.entry_id_empleado.get(), 
            self.entry_rfc_cliente.get()
          )
      )
    btn_enviar_orden.pack(side=RIGHT)
