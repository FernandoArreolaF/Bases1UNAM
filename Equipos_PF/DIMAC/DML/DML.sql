---------------------------------------------------------------------
--                                                                 --
--                             DML                                 --
--                                                                 --
---------------------------------------------------------------------


-----------------INSERTS CORRECTOS-----------------------------------


--PROVEEDOR
INSERT INTO PROVEEDOR (rs_prov, nom_prov) VALUES('Baco S.A', 'Baco');
INSERT INTO PROVEEDOR VALUES ('Bic S.A. de C.V.', 'Bic');
INSERT INTO PROVEEDOR VALUES('Barrilito S.A', 'Barrilito');
INSERT INTO PROVEEDOR VALUES('Dixon S.A', 'Dixon');
INSERT INTO PROVEEDOR VALUES('Sablon S.A', 'Sablon');

--ESTADO_COLONIA_PROVEEDOR

INSERT INTO ESTADO_COLONIA_PROVEEDOR VALUES (84552, 'Mérida', 'Tabacalera');
INSERT INTO ESTADO_COLONIA_PROVEEDOR VALUES(29652, 'Jalisco', 'Lindavista');
INSERT INTO ESTADO_COLONIA_PROVEEDOR VALUES(0470, 'Estado de Mexico', 'Zona Industrial Chalco');
INSERT INTO ESTADO_COLONIA_PROVEEDOR VALUES(25672, 'Chihuahua', 'Benito Juárez');
INSERT INTO ESTADO_COLONIA_PROVEEDOR VALUES (09850,'CDMX', 'Portales Sur');

--CALLE_NUM_PROVEEDOR

INSERT INTO CALLE_NUM_PROVEEDOR VALUES ('Baco S.A', 84552, 'Montes Urales', 25);

INSERT INTO CALLE_NUM_PROVEEDOR VALUES ('Bic S.A. de C.V.', 29652, 'Garzas', 256);

INSERT INTO CALLE_NUM_PROVEEDOR VALUES ( 'Barrilito S.A', 0470, 'Alamos', 229);
 
INSERT INTO CALLE_NUM_PROVEEDOR VALUES ('Dixon S.A', 25672, 'Ignacio Zaragoza', 123);

INSERT INTO CALLE_NUM_PROVEEDOR VALUES ('Sablon S.A', 09850, 'Dalias', 4);



--PRODUCTO
INSERT INTO PRODUCTO (cod_barras, nom_prod, desc_prod, precio_prod, stock_prod, marca_prod, tipo_producto) VALUES ('54646', 'Plumas', 'Caja con 12 plumas t.neg.', 46.50, 10, 'Bic', 'ap');

INSERT INTO PRODUCTO (cod_barras, nom_prod, desc_prod, precio_prod, stock_prod, marca_prod, tipo_producto) VALUES ('34782', 'Peluche', 'Osito panda', 51.90, 10 , 'Barrilito','rg');

INSERT INTO PRODUCTO (cod_barras, nom_prod, desc_prod, precio_prod, stock_prod, marca_prod, tipo_producto) VALUES ('264782', 'Mochila', 'Mochila deportiva', 200.00, 10 , 'Baco','rg');

INSERT INTO PRODUCTO (cod_barras, nom_prod, desc_prod, precio_prod, stock_prod, marca_prod, tipo_producto) VALUES ('7890327', 'Cuaderno', 'Cuaderno 100h Cuadro ch', 25.00 , 10 , 'Baco','ap');

INSERT INTO PRODUCTO (cod_barras, nom_prod, desc_prod, precio_prod, stock_prod, marca_prod, tipo_producto) VALUES ('1245789562', 'Lapiz Adhesivo Pritt', 'Lapiz Adhesivo de 11gr', 12.00, 10, 'Dixon','ap');

INSERT INTO PRODUCTO (cod_barras, nom_prod, desc_prod, precio_prod, stock_prod, marca_prod, tipo_producto) VALUES ('1245826473', 'Impresion', 'Impresion a color', 10.00,10, 'Sablon','ip');

INSERT INTO PRODUCTO (cod_barras, nom_prod, desc_prod, precio_prod, stock_prod, marca_prod, tipo_producto) VALUES ('1465237319', 'recarga', 'Recarga de 30 días', 100.00,10, 'Sablon', 'rc');



--SUMINISTRA

INSERT INTO SUMINISTRA (rs_prov, cod_barras, fecha_compra, precio_compra) VALUES ('Bic S.A. de C.V.','54646', '15/05/2019', 30.00);

INSERT INTO SUMINISTRA (rs_prov, cod_barras, fecha_compra, precio_compra) VALUES ('Barrilito S.A','34782', '15/05/2019', 31.90);

INSERT INTO SUMINISTRA (rs_prov, cod_barras, fecha_compra, precio_compra) VALUES ('Baco S.A', '7890327', '15/05/2019', 5.00);

INSERT INTO SUMINISTRA (rs_prov, cod_barras, fecha_compra, precio_compra) VALUES ('Baco S.A', '264782', '15/05/2019', 50.00);

INSERT INTO SUMINISTRA (rs_prov, cod_barras, fecha_compra, precio_compra) VALUES ('Dixon S.A', '1245789562', '15/05/2019', 2.00);

INSERT INTO SUMINISTRA (rs_prov, cod_barras, fecha_compra, precio_compra) VALUES ('Sablon S.A', '1245826473', '15/05/2019', 2.00);

INSERT INTO SUMINISTRA (rs_prov, cod_barras, fecha_compra, precio_compra) VALUES ('Sablon S.A', '1465237319', '15/05/2019', 50.00);


--CLIENTE

INSERT INTO CLIENTE  VALUES ('VIQD-200398-RWT', 'Diego Armando', 'Vivanco', 'Quintanar' );
INSERT INTO CLIENTE  VALUES ('TAME-069346-RRT', 'Jose', 'Diaz', 'Bonilla');
INSERT INTO CLIENTE  VALUES ('MKMP-360776-RLT', 'Karolina', 'Cedillo', 'Rivera' );
INSERT INTO CLIENTE  VALUES ('JRFD-015467-KLI', 'Eduardo', 'Martinez', 'Rivera');
INSERT INTO CLIENTE  VALUES('UTJM-817263-RGE', 'Mauricio', 'Flores' , 'Hernández');

--ESTADO_COLONIA_CLIENTE

INSERT INTO ESTADO_COLONIA_CLIENTE VALUES(14090, 'La Joya', 'CDMX');
INSERT INTO ESTADO_COLONIA_CLIENTE VALUES(09840, 'Narvarte', 'CDMX');
INSERT INTO ESTADO_COLONIA_CLIENTE VALUES(09810, 'Portales Norte', 'CDMX');
INSERT INTO ESTADO_COLONIA_CLIENTE VALUES(98763, 'Chihuahua', 'Cruz del Farol');
INSERT INTO ESTADO_COLONIA_CLIENTE VALUES(14250, 'CDMX', 'Escuadrón 201');

--CALLE_NUM_CLIENTE

INSERT INTO CALLE_NUM_CLIENTE VALUES('VIQD-200398-RWT', 14090, 'Palmas', 45);
INSERT INTO CALLE_NUM_CLIENTE VALUES('TAME-069346-RRT',  09840, 'Laureles', 130);
INSERT INTO CALLE_NUM_CLIENTE VALUES('MKMP-360776-RLT', 09810, 'Catarroja', 40);
INSERT INTO CALLE_NUM_CLIENTE VALUES('JRFD-015467-KLI', 98763, 'Rapsodia', 78);
INSERT INTO CALLE_NUM_CLIENTE VALUES('UTJM-817263-RGE', 14250, 'Benito Juárez', 201);


--VENTA

INSERT INTO VENTA(num_venta, fecha_venta, cantidad_a_pagar, rs_cliente) 
VALUES('VENT-001', '13/05/2020', 200.00, 'VIQD-200398-RWT');--Compro una mochila

INSERT INTO VENTA(num_venta, fecha_venta, cantidad_a_pagar, rs_cliente)  
VALUES('VENT-002', '1/05/2020', 50.00, 'VIQD-200398-RWT');--Compro 2 cuadernos

INSERT INTO VENTA(num_venta, fecha_venta, cantidad_a_pagar, rs_cliente )
VALUES('VENT-003','10/05/2020', 51.90, 'TAME-069346-RRT');


INSERT INTO VENTA VALUES('VENT-006', '2020-05-19', 47, 'VIQD-200398-RWT');
INSERT INTO VENTA VALUES('VENT-005', '2020-05-19', 96, 'VIQD-200398-RWT');
INSERT INTO VENTA VALUES('VENT-007', '2020-05-20', 47, 'VIQD-200398-RWT');
INSERT INTO VENTA VALUES('VENT-008', '2020-05-20', 96, 'VIQD-200398-RWT');
INSERT INTO VENTA VALUES('VENT-009', '2020-05-20', 96, 'VIQD-200398-RWT');
INSERT INTO VENTA VALUES('VENT-010', '2020-05-20', 52, 'UTJM-817263-RGE');

---PRODUCTO_VENTA
INSERT INTO PRODUCTO_VENTA(cod_barras, num_venta, cantidad_producto, precio_por_producto)
VALUES('264782', 'VENT-001', 1, 200.00);
INSERT INTO PRODUCTO_VENTA(cod_barras, num_venta, cantidad_producto, precio_por_producto)
VALUES('7890327', 'VENT-002', 2, 25.00);
INSERT INTO PRODUCTO_VENTA(cod_barras, num_venta, cantidad_producto, precio_por_producto)
VALUES('34782', 'VENT-003', 1, 51.90);

---PRODUCTO

INSERT INTO PRODUCTO_VENTA VALUES ('54646', 'VENT-005', 2, 47);
INSERT INTO PRODUCTO_VENTA VALUES ('54646', 'VENT-006', 1, 47);
INSERT INTO PRODUCTO_VENTA VALUES ('54646', 'VENT-007', 1, 47);
INSERT INTO PRODUCTO_VENTA VALUES ('54646', 'VENT-008', 2, 47);
INSERT INTO PRODUCTO_VENTA VALUES ('54646', 'VENT-009', 1, 47);
INSERT INTO PRODUCTO_VENTA VALUES ('34782', 'VENT-010', 1, 52);

----EMAIL_CLIENTE

INSERT INTO EMAIL_CLIENTE VALUES('diegovqd@gmail.com', 'VIQD-200398-RWT');
INSERT INTO EMAIL_CLIENTE VALUES('bonilla1999@gmail.com', 'TAME-069346-RRT');
INSERT INTO EMAIL_CLIENTE VALUES('KaroCedillo43@gmail.com', 'MKMP-360776-RLT');
INSERT INTO EMAIL_CLIENTE VALUES('EMRivera311@gmail.com', 'JRFD-015467-KLI');
INSERT INTO EMAIL_CLIENTE VALUES('MauricioFH90@gmail.com', 'UTJM-817263-RGE');

----TELEFONO_PROVEEDOR

INSERT INTO TELEFONO_PROVEEDOR	VALUES ('Baco S.A', '5523984572');
INSERT INTO TELEFONO_PROVEEDOR	VALUES ('Bic S.A. de C.V.', '5518276728');
INSERT INTO TELEFONO_PROVEEDOR	VALUES ('Barrilito S.A', '5536314576');
INSERT INTO TELEFONO_PROVEEDOR	VALUES ('Dixon S.A', '5515134294');
INSERT INTO TELEFONO_PROVEEDOR	VALUES ('Sablon S.A', '5532189746');

