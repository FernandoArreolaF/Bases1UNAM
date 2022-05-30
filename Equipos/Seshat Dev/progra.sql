
ALTER TABLE ORDEN ALTER COLUMN TOTAL_PAGO SET NOT NULL;
ALTER TABLE ORDEN ALTER COLUMN TOTAL_PAGO SET DEFAULT 0;

CREATE OR REPLACE FUNCTION sum_total() 
RETURNS TRIGGER AS
$sum_total$
	begin
	 UPDATE orden
	 SET TOTAL_PAGO=(
		 SELECT SUM(PRECIO) FROM
						menu_categoria JOIN CONTIENE ON menu_categoria.ID_IDENTIFICADOR=NEW.ID_IDENTIFICADOR
	 )
	 WHERE ORDEN.FOLIO=NEW.FOLIO;
	 RETURN NEW;
 END;
$sum_total$  LANGUAGE plpgsql;

DROP TRIGGER SUMA_ORDEN ON CONTIENE;

CREATE TRIGGER SUMA_ORDEN
  AFTER INSERT
  ON CONTIENE
  FOR EACH ROW
  EXECUTE PROCEDURE sum_total();
---> Ordenes del dia x empleado

Create or replace function ordenes_empleado(num_empleado int) returns text as $$
DECLARE
dia int;
i int;
begin

dia = getdate();
i = extract(day from dia);

if (num_empleado = orden.num_empleado_MESERO and i = extract(day from orden.fecha)) then
	select * from orden where num_empleado = orden.num_empleado_MESERO;
	else
	RAISE NOTICE 'EL CODIGO INGRESADO NO CORRESPONDE A UN MESERO';
	end if;

return 'registro completo';
end;
$$ language 'plpgsql';


ALTER TABLE ORDEN ALTER COLUMN cantidad_alimentos SET NOT NULL;
ALTER TABLE ORDEN ALTER COLUMN cantidad_alimentos SET DEFAULT 0;


ALTER TABLE ORDEN ALTER COLUMN cantidad_alimentos SET NOT NULL;
ALTER TABLE ORDEN ALTER COLUMN cantidad_alimentos SET DEFAULT 0;


Después hay que ejecutar y bueno, declarar el trigger
CREATE OR REPLACE FUNCTION sum_cantidad() 
RETURNS TRIGGER AS
$sum_cantidad$
	begin
	 UPDATE orden
	 SET CANTIDAD_ALIMENTOS=CANTIDAD_ALIMENTOS +1
	 WHERE ORDEN.FOLIO=NEW.FOLIO;
	 RETURN NEW;
 END;
$sum_cantidad$  LANGUAGE plpgsql;

CREATE TRIGGER SUMA_CANTIDAD
  AFTER INSERT
  ON CONTIENE
  FOR EACH ROW
  EXECUTE PROCEDURE SUM_CANTIDAD();


CREATE VIEW MESERO_CONSULTA AS 
SELECT SUM(O.TOTAL_PAGO), COUNT(O.FOLIO)
FROM ORDEN AS O
WHERE O.FECHA=NOW();

DROP VIEW MESERO_CONSULTA;

SELECT * FROM MESERO_CONSULTA;


-->Vista platillo más vendido

CREATE VIEW PLATILLOMAIN AS
SELECT C.ID_IDENTIFICADOR,M.NOMBRE_ALIMENTO
FROM CONTIENE as C
INNER JOIN MENU_CATEGORIA AS M ON C.ID_IDENTIFICADOR=M.ID_IDENTIFICADOR
GROUP BY C.ID_IDENTIFICADOR, M.ID_IDENTIFICADOR HAVING COUNT(C.ID_IDENTIFICADOR)=MAX(C.ID_IDENTIFICADOR); 

--> Vista Factura

CREATE VIEW FACTURA AS 
SELECT CLIENTE.RFC_CLIENTE,ORDEN.FECHA,MENU_CATEGORIA.nombre_alimento,contiene.folio, orden.total_pago
FROM CLIENTE, ORDEN,menu_categoria,contiene
WHERE CLIENTE.RFC_CLIENTE = ORDEN.RFC_CLIENTE
AND MENU_CATEGORIA.id_identificador=contiene.id_identificador;

--Calculo de ordenes en un intervalo

SELECT sum(precio) FROM 
menu_categoria inner JOIN CONTIENE ON menu_categoria.ID_IDENTIFICADOR=CONTIENE.ID_IDENTIFICADOR
inner JOIN ORDEN ON CONTIENE.FOLIO=ORDEN.FOLIO
WHERE extract(month from orden.fecha)>=# and extract(month from orden.fecha)<#;

--Alimentos no disponibles
SELECT*FROM MENU_CATEGORIA WHERE DISPONIBILIDAD='0'; 

--Indice receta

SELECT *
FROM MENU_CATEGORIA
WHERE RECETA = 'AQUÍ VA LO DE LA RECETA';
