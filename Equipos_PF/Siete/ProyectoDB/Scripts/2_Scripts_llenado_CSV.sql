
/*---------------------------------------
-----------------------------------------
----------------------------------------
------	BLOQUE PARA CARGAR CSV--
--------------------------------------------
-------------------------------------------
------------------------------------------
---------------------------------------------
-------------------------------------------*/

\copy inventario from inventario.csv;
\copy regiones from regiones.csv;
\copy proveedor from proveedores.csv;
\copy telefono from telefonos.csv;
\copy marcas from marcas.csv ;
\copy cliente from cliente.csv;
\copy email from email.csv;
\copy producto_detalles from producto_detalles.csv ;
\copy producto_codigo from producto_codigo.csv;
\copy venta from ventas.csv;
\copy venta_detalles from venta_detalles.csv;
