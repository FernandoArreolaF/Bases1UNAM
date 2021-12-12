-- 1 tienda don juan
INSERT INTO public.tienda(
	nombre, id_tienda)
	VALUES ('Papeleria Don Juan', 1);


----- 3 Provedores -- despues de tienda
INSERT INTO public.provedores(
id_provedor, razon_social, estado, codigo_postal, colonia, calle, numero, 
	nombre, ap_paterno, ap_materno, id_tienda)
VALUES 
(1, 'Plumas S.A', 'Jalisco', 15080, 'Chavarrieta', '5 de mayo', 24,
		'Juan', 'Martinez','Flores', '1'),
(2, 'Lapices S.A', 'Sonora', 15090, 'Del mar', 'Jardines', 28,
		'Angelica', 'Rodriguez','Garcia', '1'),
(3, 'Gomas S.A', 'Michoacan', 16080, 'San miguel', 'Iturbide', 32,
		'Ivan', 'Paz','Osorio', '1');

--- inserta 4 productos
INSERT INTO public.producto_almacen(
codigo_barras, precio_compra, fecha_compra, cantidad_ejemplares, id_tienda,precio_venta)
VALUES 
(1111, 10.5 , '4-10-1998', 40, 1,20.5),
(2222, 20.5 , '8-12-1998', 40, 1,30.5),
(3333, 30.5 , '4-12-1998', 40, 1,40.5),
(4444, 40.5 , '4-06-1998', 40, 1,50.5);

---  3 clientes
INSERT INTO public.cliente(
id_cliente, rfc, nombre, ap_paterno, ap_materno, calle, numero, colonia, codigo_postal, estado)
VALUES 
(1, 'CAPV841211G54', 'Francisco', 'Pineda', 'Campos', 'Robles', 44, 'Independencia', 12080, 'CDMX'),
(2, 'CAPV841211G55', 'Pablo', 'Ortiz', 'Ocampo', 'Encinos', 48, 'Progreso', 12090, 'Baja california'),
(3, 'CAPV841211G56', 'Pedro', 'Silva', 'Jimenez', 'Aldama', 34, 'Union', 12300, 'Yucatan');

--- VENTA 1
INSERT INTO public.venta(
id_venta, num_venta, total_venta, fecha_venta, id_tienda, id_cliente)
VALUES 
(1, 'VENT-001', 0, '9-12-2021', 1, 1);

--- 1 venta de un prit
INSERT INTO public.producto_venta(
descripcion, marca, cantidad, total_articulo, codigo_barras, id_venta)
VALUES 
('Un prit', 'patito', 2, 0 , 1111, 1);