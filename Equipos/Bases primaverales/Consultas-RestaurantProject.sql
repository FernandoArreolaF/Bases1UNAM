--FUNCIONES QUE SE UTILIZAN EN EL PROYECTO PARA LA ADMINISTRACIÓN DE LA BASE DE DATOS.
--PUNTO1.
--Cada que se agregue un producto a la orden, debe actualizarse los totales
--(por producto y venta), as ́ı como validar que el producto est ́e disponible


--Funcion que le entra una secuencia(bigint) y retorna el character varying ya con el folio formado
--de esta manera se genera super automatico el folio de la orden con el formato (ORD-xxx) correspondiente
create or replace function concatena_folio_function(in_idorden bigint) returns character varying(7) as
$$
declare
folio character varying(7);
idc character varying(3);
ord character varying(4);
cerocero character varying(2);
cero character varying(1);
declare
conteo smallint;
begin
idc = cast( in_idorden as character varying );
ORD = 'ORD-';
cerocero = '00';
cero = '0';
if (length(idc) = 1) then
folio= ORD||cerocero||idc;
  return (folio);
elsif (length(idc) = 2) then
folio= ORD||cero||idc;
  return (folio);
elsif (length(idc) = 3) then
folio:= ORD||idc;
  return (folio);
else
    RAISE NOTICE 'nada';
end if;
RAISE NOTICE 'Folio generado(%)', folio;
end
$$
LANGUAGE plpgsql;

-- secuencia id_orden
CREATE SEQUENCE orden_seq
START WITH 1 
INCREMENT BY 1
MAXVALUE 999
MINVALUE 0
CYCLE;

--FUNCION QUE CUMPLE EL PUNTO 1 solo es necesario asignar el numero del empleado que lo va a atender, se verifica que sea mesero
create or replace function agregar_orden(num_e integer) returns void as -- solo se agrega numero de empleado;
$$
begin
if exists(select num_empleado from empleado where num_empleado= num_e) then
if tipo_empleado.tipo_mesero='f' from tipo_empleado where tipo_empleado.num_empleado=num_e then
     raise exception 'No es un mesero';
    else
    insert into orden(id_orden, fec_orden, precio_total_orden, num_empleado) 
    values ( (concatena_folio_function(nextval('orden_seq'))), (select current_date), 0, num_e);
    end if;
 else 
 raise exception 'No existe este empleado';
end if;
end;
$$
LANGUAGE plpgsql;

--SOBRECARGA DE LA FUNCION PARA QUE LE ENTRE COMO PARAMETRO EL IDORDEN Y EL NUMEMPLEADO
--FUNCION QUE CUMPLE EL PUNTO 1 solo es necesario asignar el numero del empleado que lo va a atender, se verifica que sea mesero
create or replace function agregar_orden(idorden character varying(7),num_e integer) returns void as -- solo se agrega numero de empleado;
$$
begin
if exists(select num_empleado from empleado where num_empleado= num_e) then
if tipo_empleado.tipo_mesero='f' from tipo_empleado where tipo_empleado.num_empleado=num_e then
     raise exception 'No es un mesero';
    else
    insert into orden(id_orden, fec_orden, precio_total_orden, num_empleado) 
    values ( idorden, (select current_date), 0, num_e);
    end if;
 else 
 raise exception 'No existe este empleado';
end if;
end;
$$
LANGUAGE plpgsql;


--INMEDIATAMENTE QUE SE GENERA LA FUNCION ANTERIOR SE VA GENERANDO AUTOMATICAMENTE
--TODO LO QUE SIGUE SE VA A IR CON EL FOLIO ANTERIOR GENERADO DE MANERA AUTOMATICA
--DEJANDO UNA SIMULACIÓN 100% REAL
--DESPUES TENEMOS QUE AGREGAR UN CLIENTE INSERTANDO EN EL CAMPO DE id_orden : 
--concatena_folio_function(currval('orden_seq'))
--con currval('orden_seq') lo que hacemos es recuperar el valor del id_orden del cliente actual
-- asi ya no es necesario estar tomando ese numero a cada momento, solamente al hacer la asociacion con el cliente
--insert into cliente(id_cliente,nombre_cliente,ap_paterno,ap_materno,id_orden) values ('1','ramiro','riger','romero', concatena_folio_function(currval('orden_seq')));

--Validación de disponibilidad del platillo tambien cumple con el punto 1
create or replace function disponible_bool(in_idplatilloybebida integer) returns bool as
$$
declare
esta_disponible boolean;
begin
if in_idplatilloybebida = (select id_platilloybebida from platilloybebida 
where in_idplatilloybebida = platilloybebida.id_platilloybebida )then
raise notice 'El platillo existe';
if (select disponibilidad from platilloybebida 
where in_idplatilloybebida = platilloybebida.id_platilloybebida)  is TRUE then
raise notice 'Claro este producto esta disponible';
esta_disponible = TRUE;
return(esta_disponible);
elsif (select disponibilidad from platilloybebida 
where in_idplatilloybebida = platilloybebida.id_platilloybebida ) is FALSE then
esta_disponible = FALSE;
raise exception 'Lo sentimos, este producto ya no está disponible :(';
else 
    raise exception 'Este platillo no se encuentra en nuestra lista de opciones';
end if;
else 
raise exception 'Este platillo no se encuentra en nuestra lista de opciones';
end if;
raise notice 'Claro este producto esta disponible';
return(esta_disponible );
end;

$$
LANGUAGE plpgsql;

-- Dentro de esta funcion hacemos el agregado de los productos a la orden
--de igual manera se tiene que hacer al momento de hacer la orden, se va a agaregar
--los productos a la misma orden siempre y cuando no se haya mandado a llamar la funcion de 
--agregar_orden(num_empleado)
--esta funcion recibe como parametro el id del producto que se quiera agregar y la cantidad
--de piezas que se quiera de ese producto
--
create or replace function agregar_producto(id_pb integer, cantidad integer) returns void as
$$
declare 
orden_new character varying(7);
cantidadp integer;
cantidadb integer;
begin 
orden_new = concatena_folio_function(currval('orden_seq'));
if (select disponible_bool(id_pb)) is TRUE then
if (select es_platillo from platilloybebida where platilloybebida.id_platilloybebida = id_pb )is true then
cantidadp = cantidad;
cantidadb = 0;
insert into corresponde(id_platilloybebida, id_orden, cant_platillo,cant_bebida, precio_total_bebida, precio_total_platillo) 
values (id_pb, orden_new, cantidadp, cantidadb, 0, ((select precio_platilloybebida from platilloybebida where id_pb = platilloybebida.id_platilloybebida) * cantidadp));
-- se actualiza el atributo cantidad_vendido para una proxima consulta
update platilloybebida set cantidad_vendido = (select cantidad_vendido from platilloybebida where platilloybebida.id_platilloybebida = id_pb) + cantidadp where id_platilloybebida = id_pb;

elsif (select es_bebida from platilloybebida where platilloybebida.id_platilloybebida = id_pb ) is true then
cantidadb = cantidad;
cantidadp = 0;
insert into corresponde(id_platilloybebida, id_orden, cant_platillo,cant_bebida, precio_total_bebida, precio_total_platillo) 
values ( id_pb, orden_new, cantidadp, cantidadb, ((select precio_platilloybebida from platilloybebida where id_pb = platilloybebida.id_platilloybebida) * cantidadb), 0);
-- se actualiza el atributo cantidad_vendido para una proxima consulta
update platilloybebida set cantidad_vendido = (select cantidad_vendido from platilloybebida where platilloybebida.id_platilloybebida = id_pb) + cantidadb where id_platilloybebida = id_pb;

--(select cantidad_vendido from platilloybebida pb where (select id_platilloybebida from corresponde c ) = id_pb ) + cantidadb;
else 
raise exception 'El platillo no está disponible';
end if;
-- se actualiza de manera correcta el precio total de la orden con el ingreso de cada producto.
update orden set precio_total_orden = ((select sum(precio_total_platillo) from corresponde c where c.id_orden = orden_new)+ (select sum(precio_total_bebida) 
from corresponde c where c.id_orden = orden_new))where id_orden = orden_new;
else
 raise exception 'El id del producto no existe en el menú o no se encuentra disponible';
end if;
end;
$$
LANGUAGE plpgsql;


------------------------
--FUNCION SOBRECARGADA QUE RECIBE COMO PARAMETRO EL ID_ORDEN MANUALMENTE, EL ID DEL PRODUCTO Y LA CANTIDAD
create or replace function agregar_producto(idordenn character varying(7),id_pb integer, cantidad integer) returns void as
$$
declare 
orden_new character varying(7);
cantidadp integer;
cantidadb integer;
begin 
orden_new = idordenn;
if (select disponible_bool(id_pb)) is TRUE then
if (select es_platillo from platilloybebida where platilloybebida.id_platilloybebida = id_pb )is true then
cantidadp = cantidad;
cantidadb = 0;
insert into corresponde(id_platilloybebida, id_orden, cant_platillo,cant_bebida, precio_total_bebida, precio_total_platillo) 
values (id_pb, orden_new, cantidadp, cantidadb, 0, ((select precio_platilloybebida from platilloybebida where id_pb = platilloybebida.id_platilloybebida) * cantidadp));
-- se actualiza el atributo cantidad_vendido para una proxima consulta
update platilloybebida set cantidad_vendido = (select cantidad_vendido from platilloybebida where platilloybebida.id_platilloybebida = id_pb) + cantidadp where id_platilloybebida = id_pb;

elsif (select es_bebida from platilloybebida where platilloybebida.id_platilloybebida = id_pb ) is true then
cantidadb = cantidad;
cantidadp = 0;
insert into corresponde(id_platilloybebida, id_orden, cant_platillo,cant_bebida, precio_total_bebida, precio_total_platillo) 
values ( id_pb, orden_new, cantidadp, cantidadb, ((select precio_platilloybebida from platilloybebida where id_pb = platilloybebida.id_platilloybebida) * cantidadb), 0);
-- se actualiza el atributo cantidad_vendido para una proxima consulta
update platilloybebida set cantidad_vendido = (select cantidad_vendido from platilloybebida where platilloybebida.id_platilloybebida = id_pb) + cantidadb where id_platilloybebida = id_pb;

--(select cantidad_vendido from platilloybebida pb where (select id_platilloybebida from corresponde c ) = id_pb ) + cantidadb;
else 
raise exception 'El platillo no está disponible';
end if;
-- se actualiza de manera correcta el precio total de la orden con el ingreso de cada producto.
update orden set precio_total_orden = ((select sum(precio_total_platillo) from corresponde c where c.id_orden = orden_new)+ (select sum(precio_total_bebida) 
from corresponde c where c.id_orden = orden_new))where id_orden = orden_new;
else
 raise exception 'El id del producto no existe en el menú o no se encuentra disponible';
end if;
end;
$$
LANGUAGE plpgsql;

-- VISTA ADICIONAL PARA TENER MÁS PRESENTABLE LA ORDEN
create view orden_view as
select orden.id_orden  as Folio_orden,orden.fec_orden as Fecha_orden, orden.num_empleado, platilloybebida.id_platilloybebida as id_producto, platilloybebida.nombre_platilloybebida as Nombre_producto, platilloybebida.precio_platilloybebida as Precio_producto, corresponde.cant_platillo as Cantidad_platillo, corresponde.precio_total_platillo, corresponde.cant_bebida as Cantidad_bebida, corresponde.precio_total_bebida, orden.precio_total_orden
from orden inner join corresponde on orden.id_orden=corresponde.id_orden
                   inner join platilloybebida on platilloybebida.id_platilloybebida=corresponde.id_platilloybebida;



--PUNTO 2 
--Crear al menos, un  ́ındice, del tipo que se prefiera y donde se prefiera.
--Justificar el porque de la eleccion en ambos aspectos.
create index ind_fecha on orden("fec_orden");

--Se elije este indice debido a que en muchas implementaciones reales en donde para llevar
--un registro de las cosas que se estan vendiendo  y de esta manera podemos llevar un control
--imagninando que queremos ver todos los detalles de las ordenes que se hicieron en tal dia
--algo conocido como corte en las empresas


--PUNTO 3
--Dado un n ́umero de empleado, mostrar la cantidad de  ́ordenes que ha
--registrado en el d ́ıa as ́ı como el total que se ha pagado por dichas  ́ordenes.
--Si no se trata de un mesero, mostrar un mensaje de error.
--Se implementa otra manera de ingresar entradas y mostrar salida todo por medio de parametros
-- ingresando solo el numero de empleado y se verificara si es mesero
create or replace function total_dia( in num_emp int, out Cantidad_Ordenes int, out Total_Ordenes int)
language plpgsql
as $$
begin 
  if tipo_empleado.tipo_mesero='f' from tipo_empleado where tipo_empleado.num_empleado=num_emp then
     raise exception 'No es un mesero';
end if;
  select count(*), sum(precio_total_orden)
  into Cantidad_Ordenes, Total_Ordenes
  from orden
  where num_empleado = num_emp
  and
  fec_orden = current_date;
end; $$;



--PUNTO 4
--Vista que muestre todos los detalles del platillo m ́as vendido.
--se ordena el atributo más vendido y se muestra todo sobre él incluyendo su categoría
--por medio del atributo cantidad vendido
create view mas_vendido as 
select 
pb.id_platilloybebida as id_producto, pb.nombre_platilloybebida as nombre_producto, pb.receta, c.id_categoria, c.nombre_categoria, c.descripcion_categoria
from platilloybebida pb inner join  categoria c on pb.id_categoria =c.id_categoria
order by pb.cantidad_vendido desc  limit 1;


--PUNTO 5
--Permitir obtener el nombre de aquellos productos que no esten disponibles.
create view no_disponible as
select nombre_platilloybebida as nombre_producto from platilloybebida where disponibilidad = FALSE;


--PUNTO 6
--De manera autom ́atica se genere una vista que contenga informaci ́on ne-
--cesaria para asemejarse a una factura de una orden.
--
--SE TIENE QUE AGREGAR PREVIAMENTE UNA FACTURA PARA PODER CONSULTAR ESTA VISTA
--insert into factura(rfc,razon_social,calle,colonia,cp,estado,email,fec_nacimiento,id_cliente)
--values('asdfghjkierw1','asociados empresa','sur14','itzazima',923,'aguascalientes','mireyo@12com', '2000-01-01',1);
--CREATE TABLE public."factura"(rfc character varying(13) NOT NULL,razon_social character varying(50) NOT NULL,calle character varying(50) NOT NULL,colonia character varying(50) NOT NULL,cp smallint NOT NULL,estado character varying(35) NOT NULL,email character varying(150) NOT NULL,fec_nacimiento date NOT NULL,id_cliente integer NOT NULL,PRIMARY KEY (rfc));

--PUEDE IMPLEMENTARSE DE UNA MEJOR MANERA, YA QUE DE ESTA MANERA SE NOS REPETIEN MUCHOS ATRIBUTOS

create view facturaaa as 
select orden.id_orden as folio_orden, orden.precio_total_orden,  cliente.nombre_cliente, cliente.ap_paterno, cliente.ap_materno , 
factura.rfc, factura.calle, factura.colonia, factura.estado, factura.email, factura.fec_nacimiento, platilloybebida.id_platilloybebida, 
platilloybebida.nombre_platilloybebida, corresponde.cant_platillo, corresponde.cant_bebida,platilloybebida.precio_platilloybebida 
as precio_unitario, corresponde.precio_total_platillo, corresponde.precio_total_bebida 
from platilloybebida inner join corresponde on platilloybebida.id_platilloybebida=corresponde.id_platilloybebida 
inner join orden on corresponde.id_orden = orden.id_orden inner join cliente on orden.id_orden=cliente.id_orden
inner join factura on factura.id_cliente=cliente.id_cliente where orden.id_orden = concatena_folio_function(currval('orden_seq'));


--PUNTO 7
--Dada una fecha, o una fecha de inicio y fecha de fin, regresar el total del
--numero de ventas y el monto total por las ventas en ese periodo de tiempo.
--Para implementar este punto se crearon dos funciones
--la primer funcion es con una sola fecha como parametro
--la segunda es una sobre carga, es decir la misma funcion pero con las dos entradas
--ambas regresan el total de numero de ventas de ese dia y el monto total de ese dia

--funcion con un solo parametro de entrada
create or replace function ventas_fecha(in inicio date, out Numero_Ventas int, out Monto_Total int)
language plpgsql
as $$
begin
   select count (*), sum(precio_total_orden)
   into Numero_Ventas, Monto_Total
   from orden
   where fec_orden=inicio;
end; $$;

--funcion con dos parametros de entrada sobre cargada y regresa entre un rango de fechas
create or replace function ventas_fecha(in inicio date, in fin date, out Numero_Ventas int, out Monto_Total int)
language plpgsql
as $$
begin
   select count (*), sum(precio_total_orden)
   into Numero_Ventas, Monto_Total
   from orden
   where fec_orden  between inicio and  fin;
end; $$;

--vistas adicionales con las cuales e podría formar la parte de la factura con una implementación más presentable
-- LA INTERFAZ GRAFICA TIENE QUE CONECTARSE A LA BASE Y LLEVARSE INFORMACION
--POR LO TANTO LA MEJOR IMPLEMENTACIÓN PARA LA PARTE DE DLA FACTURA GENERADA EN LA INTERFAZ
--ES OCUPANDO ESTAS FUNCIONES ADICIONALES

--FUNCIONES ADICIONALES

--MUESTRA LOS DATOS DEL CLIENTE QUE SE ESTA ATENDIENDO EN EL MOMENTO(1 SOLO REGISTRO)
-- EN UNA SOLA FILA
create view datos_cliente as 
select orden.id_orden as folio_orden, orden.precio_total_orden,  cliente.nombre_cliente, cliente.ap_paterno, cliente.ap_materno , factura.rfc, factura.calle, factura.colonia, factura.estado, factura.email, factura.fec_nacimiento from orden inner join cliente on orden.id_orden=cliente.id_orden
          inner join factura on factura.id_cliente=cliente.id_cliente where orden.id_orden = concatena_folio_function(currval('orden_seq'));


-- MUESTRA LOS PRODUCTOS Y TODAS SUS CARACTERISTICAS, LOS PRODUCTOS SON CORRESPONDIENTES
--SOLAMENTE A LA ORDEN ACTUAL CON EL CURRVAL AL IGUAL QUE LA ANTERIOR
create view datos_producto as
select  platilloybebida.id_platilloybebida, platilloybebida.nombre_platilloybebida, corresponde.cant_platillo, corresponde.cant_bebida,platilloybebida.precio_platilloybebida as precio_unitario, corresponde.precio_total_platillo, corresponde.precio_total_bebida
from platilloybebida inner join corresponde on platilloybebida.id_platilloybebida=corresponde.id_platilloybebida where corresponde.id_orden = concatena_folio_function(currval('orden_seq'));


--NOTA: PARA CREAR TODAS LAS FUNCIONES SE PUEDE EJECUTAR ESTE SCRIPT 
