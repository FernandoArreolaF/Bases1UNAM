from Controlador import Controlador
from Modelo import Modelo
from tkinter import Tk
from Ventana_Orden import Ventana_Orden

root = Tk()
root.title('Proyecto BD - Restaurante')
root.config(bg='white')
root.geometry('1000x900')
root.resizable(0, 0)

modelo = Modelo()
app = Controlador(modelo)

Ventana_Orden(root, app)

root.mainloop()