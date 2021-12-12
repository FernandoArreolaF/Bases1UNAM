\copy proveedor(nombre,razon_social,telefono,estado,codigo_postal,colonia,calle,num_domicilio) from '/home/serveradmin/Downloads/datosPROVEEDOR.txt' with NULL as 'NULL' DELIMITER '|' encoding 'UTF8';

\copy cliente(rfc,nombre,ap_paterno,ap_materno,estado,codigo_postal,colonia,calle,num_domicilio) from '/home/serveradmin/Downloads/datosCLIENTE.txt' with NULL as 'NULL' DELIMITER '|' encoding 'UTF8';

\copy categoria(descripcion) from '/home/serveradmin/Downloads/datosCATEGORIA.txt' with NULL as 'NULL' DELIMITER '|' encoding 'UTF8';

\copy correo(cliente_id,email) from '/home/serveradmin/Downloads/datosCORREO.txt' with NULL as 'NULL' DELIMITER '|' encoding 'UTF8';

\copy venta(venta_id,fecha_venta,pago_final,cliente_id,cantidad_articulos) from '/home/serveradmin/Downloads/datosVENTA.txt' with NULL as 'NULL' DELIMITER '|' encoding 'UTF8';

\copy producto(codigo_barras,nombre,precio_proveedor,fecha_compra,marca,num_ejemplares,proveedor_id,categoria_id) from '/home/serveradmin/Downloads/datosPRODUCTO.txt' with NULL as 'NULL' DELIMITER '|' encoding 'UTF8';

\copy articulo(articulo_id,producto_id,precio,venta_id) from '/home/serveradmin/Downloads/datosARTICULO.txt' with NULL as 'NULL' DELIMITER '|' encoding 'UTF8';