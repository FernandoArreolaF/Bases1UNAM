package com.example.papews;

public class Constantes {

    private final static String URL_WEB_SERVICE = "https://serene-escarpment-45910.herokuapp.com/";
    public final static String URL_INSERTAR_PRODUCTO = URL_WEB_SERVICE + "Producto_Insertar-Brinda.php";
    public final static String URL_AGREGAR_STOCK = URL_WEB_SERVICE + "Producto_AgregarSTOCK.php";
    public final static String URL_ACTUALIZAR_PRODUCTO = URL_WEB_SERVICE + "Producto_Actualizar.php";
    public final static String URL_ELIMINAR_PRODUCTO = URL_WEB_SERVICE + "Producto_Eliminar.php";
    public final static String URL_LISTAR_PRODUCTO = URL_WEB_SERVICE + "Producto_GETALL.php";
    public final static String URL_INSERTAR_CLIENTE = URL_WEB_SERVICE + "Cliente_Insertar.php";
    public final static String URL_ACTUALIZAR_CLIENTE = URL_WEB_SERVICE + "Cliente_Actualizar.php";
    public final static String URL_ELIMINAR_CLIENTE = URL_WEB_SERVICE + "Cliente_Eliminar.php";
    public final static String URL_LISTAR_CLIENTE = URL_WEB_SERVICE + "Cliente_GETALL.php";

    public final static String URL_INSERTAR_CORREO = URL_WEB_SERVICE + "Email_Insertar.php";
    public final static String URL_ACTUALIZAR_CORREO = URL_WEB_SERVICE + "Email_Actualizar.php";
    public final static String URL_ELIMINAR_CORREO = URL_WEB_SERVICE + "Email_Eliminar.php";
    public final static String URL_LISTAR_CORREO = URL_WEB_SERVICE + "Email_FiltroGETClie.php/?RFC={RFC}";

    public final static String URL_INSERTAR_PROVEEDOR = URL_WEB_SERVICE + "Proveedor_Insertar.php";
    public final static String URL_ACTUALIZAR_PROVEEDOR = URL_WEB_SERVICE + "Proveedor_Actualizar.php";
    public final static String URL_ELIMINAR_PROVEEDOR = URL_WEB_SERVICE + "Proveedor_Eliminar.php";
    public final static String URL_LISTAR_PROVEEDOR = URL_WEB_SERVICE + "Proveedor_GETALL.php";

    public final static String URL_INSERTAR_TELEFONO = URL_WEB_SERVICE + "Telefono_Insertar.php";
    public final static String URL_ACTUALIZAR_TELEFONO = URL_WEB_SERVICE + "Telefono_Actualizar.php";
    public final static String URL_ELIMINAR_TELEFONO = URL_WEB_SERVICE + "Telefono_Eliminar.php";
    public final static String URL_LISTAR_TELEFONO = URL_WEB_SERVICE + "Telefono_FiltroGETProv.php/?RAZONSOCIAL={RAZONSOCIAL}";

    public final static String URL_ELIMINAR_VENTA = URL_WEB_SERVICE + "Venta_Eliminar.php";
    public final static String URL_LISTAR_VENTA = URL_WEB_SERVICE + "Venta_FiltroGETClien.php/?RFC={RFC}";
    public final static String URL_DETALLES_VENTA = URL_WEB_SERVICE + "Venta_GETDetalles.php/?NOVENTA={NOVENTA}";
    public final static String URL_DETALLES_VENTA2 = URL_WEB_SERVICE + "Venta_GETDetalles2.php/?NOVENTA={NOVENTA}";

    public final static String URL_GANANCIAS = URL_WEB_SERVICE + "Ganancia_FechasPRO.php/?FECHA1={FECHA1}&FECHA2={FECHA2}";

    public final static String URL_CREAR_VENTA = URL_WEB_SERVICE + "Venta_Insertar-Incluye.php";
    public final static String URL_NUEVO_PRODUCTO_VENTA = URL_WEB_SERVICE + "Incluye_Insertar.php";
    //public final static String URL_ACTUALIZAR_CANTIDAD = URL_WEB_SERVICE + "Incluye_Actualizar.php";
    public final static String URL_BORRAR_PRODUCTO_VENTA = URL_WEB_SERVICE + "Incluye_Eliminar.php";

    public final static String URL_CONSULTA_MENOR = URL_WEB_SERVICE + "Producto_Filtro_STOCK.php/?STOCK={STOCK}";


}
