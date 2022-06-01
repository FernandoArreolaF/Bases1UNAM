INSERT INTO public.categoria(
	id_categoria, nombre_categoria, descripcion)
	VALUES (1, 'producto', 'Platos con una porcion de arroz y una de frijoles incluye 10 tortillas');
INSERT INTO public.cliente(
	rfc, razon_social, nombre, ap_paterno, ap_materno, calle, no_exterior, colonia, estado, cp, fecha_nacimiento, email)
	VALUES ('AIEJ780824LT9','JESUS ARMANDO AVILA ESCOBEDO', 'JESUS', 'AVILA', 'ESCOBEDO', 'PUERTO LIBERTAD', '15', 'JARDINES', 'ESTADO DE MEXICO', '75302', '1970-07-15', 'TACOGUAPO@GMAIL.COM');

INSERT INTO public.dependiente(
	curp, no_empleado, nombre, ap_paterno, ap_materno, parentesco)
	VALUES ('PED55283FR', 'EMP-002', 'FERNANDO', 'PEREZ', 'SANCHES', 'HIJA');

INSERT INTO public.empleado(
	rfc, nombre, ap_paterno, calle, no_exterior, colonia, estado, cp, fecha_nacimiento,  sueldo, horario, foto)
	VALUES ( 'EIPH740812EN2','HEBERT', 'ESPINOZA', 'AV CONSTITUCION', '2', 'PATRIOTISMO', 'CDMX', '98754', '1970-06-23',
			200, '20:00-21:00', 'EMP-001.JPG');

INSERT INTO public.orden(
 		no_empleado, rfc_cte)
	VALUES ('EMP-001', 'AIEJ780824LT9');

INSERT INTO public.orden(no_empleado, rfc_cte)VALUES ('EMP-001');

INSERT INTO public.orden_producto(
	id_producto, folio, cantidad)
	VALUES (1, 'ORD-001', 1);

INSERT INTO public.producto(
	id_producto, nombre, descripcion, receta, disponibilidad, id_categoria, precio)
	VALUES (1, 'enchiladas', 'tortillas fritas, sumergidas en salsa verde', '2 tortillas 2 tomates 3 cebollas', true, 1, 25),
	(2,'torta','bolillo embarrado con mayonesa, va con jamons y queso', 'un bolillo, 2 lonchas de jamon y queso, se parte el bolillo',true,
	1,30),(3,'tacos','5 tacos de suadero con 2 tortillas', 'se fire la tortilla, se coce la carne y se junta',false,
	1,50),(4,'pepsi','botella de pepsi de 600ml','se bre la botella y se sirve en un vaso de 600 ml',true,2,10);

INSERT INTO public.telefono(
	telefono, no_empleado)
	VALUES ('55215057', 'EMP-001'),('66343623', 'EMP-001'),('72305684', 'EMP-001'),('543232653','EMP-002');

