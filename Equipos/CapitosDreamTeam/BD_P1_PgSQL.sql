--Proyecto Final BD Grupo 01
--Equipo CapitosDreamTeam
-- Autores:
--Alvarez Salgado Eduardo Antonio
--Lara Hernández Emmanuel
--Merida Serralde Francisco Jared
--Ponce de León Reyes Bruno
--Zepeda Aparicio Diego Arturo

--Código PgSQL para cumplir con los requerimientos del restaurante

-- Creando índice para el idproducto
CREATE INDEX idx_detalle_orden_idproducto ON detalle_orden(idproducto);

-- Creando procedimiento que permite obtener el total de ordenes de un mesero
CREATE OR REPLACE PROCEDURE ordenes(num_cl int4)
AS
$$
DECLARE
    nombre varchar(50);
    ap_pat varchar(50);
    ap_mat varchar(50);
    total_ordenes int;
    total_pago numeric(10,2);
    
BEGIN

    SELECT nompila, appaterno, apmaterno
    INTO nombre, ap_pat, ap_mat
    FROM empleado
    WHERE numeroempleado = num_cl;
  
    IF EXISTS(SELECT * FROM empleado e JOIN mesero m ON e.numeroempleado = m.numeroempleado WHERE e.numeroempleado = num_cl)
      THEN
        SELECT COUNT(*)
        INTO total_ordenes
        FROM orden
        WHERE numeroempleado = num_cl AND fechaorden::date = CURRENT_DATE;

        SELECT SUM(totalapagar)
        INTO total_pago
        FROM orden
        WHERE numeroempleado = num_cl AND fechaorden::date = CURRENT_DATE;
    
        RAISE NOTICE 'El mesero % % % ha hecho % orden(es) hoy, y su total es: $%', nombre, ap_pat, ap_mat, total_ordenes, total_pago;
      ELSE
        RAISE EXCEPTION 'ERROR: El empleado % % % no es un mesero', nombre, ap_pat, ap_mat;
      END IF;
END;
$$
LANGUAGE plpgsql;


-- Creando vista del producto más vendido
CREATE OR REPLACE VIEW v_producto_mas_vendido AS
SELECT p.idproducto, p.nombreproducto, p.descripcion, p.receta, p.precio, p.cantidaddisponible, p.tipoproducto, p.nombrecategoria, SUM(d.cantidad) AS total_vendido
FROM producto p JOIN detalle_orden d ON p.idproducto = d.idproducto
GROUP BY p.idproducto, p.nombreproducto, p.descripcion, p.receta, p.precio, p.cantidaddisponible, p.tipoproducto, p.nombrecategoria
HAVING SUM(d.cantidad) = (SELECT MAX(total_vendido) FROM (SELECT SUM(cantidad) AS total_vendido FROM detalle_orden GROUP BY idproducto) t);

-- __________________________________________________________________________________________

-- Creando trigger de validación de productos y actualización del mismo
CREATE OR REPLACE FUNCTION fun_detalle_orden()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_precio NUMERIC(10,2);
    v_cantidad smallint;
    p_nombre varchar(50);
BEGIN
  
    SELECT precio, cantidaddisponible
    INTO v_precio, v_cantidad
    FROM producto
    WHERE idproducto = NEW.idproducto;

    IF (v_cantidad - NEW.cantidad) < 0 THEN
        SELECT p.nombreproducto INTO p_nombre FROM producto p JOIN detalle_orden d ON p.idproducto = d.idproducto WHERE p.idproducto = NEW.idproducto;
        RAISE EXCEPTION'El producto % no está disponible o la cantidad deseada supera la cantidad disponible', p_nombre;
    END IF;
  
    NEW.preciototalproducto := NEW.cantidad * v_precio;
    UPDATE producto SET cantidaddisponible = (v_cantidad - NEW.cantidad) WHERE idproducto = NEW.idproducto;
    RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER trg_detalle_orden_bi
BEFORE INSERT ON detalle_orden
FOR EACH ROW
EXECUTE FUNCTION fun_detalle_orden();

CREATE OR REPLACE FUNCTION fun_actualizar_total_orden()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE orden
    SET totalapagar = (
        SELECT COALESCE(SUM(preciototalproducto),0)
        FROM detalle_orden
        WHERE folio = NEW.folio
    )
    WHERE folio = NEW.folio;

    RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER trg_actualizar_total
AFTER INSERT
ON detalle_orden
FOR EACH ROW
EXECUTE FUNCTION fun_actualizar_total_orden();



------Obtener productos no disponibles
CREATE OR REPLACE PROCEDURE mostrar_no_disponibles() AS $$
DECLARE 
    registro_producto record;
    contador smallint := 0;

BEGIN
    RAISE NOTICE 'A continuacion se muestran los productos no disponibles por el momento';
    FOR registro_producto IN
        SELECT idProducto, nombreProducto
        FROM PRODUCTO
        WHERE cantidadDisponible = 0
    LOOP
        contador := contador+1;
        RAISE NOTICE '%.->   ID: % | PRODUCTO: %', 
                contador, registro_producto.idProducto, registro_producto.nombreProducto;
    END LOOP;
    
    IF contador = 0 THEN
        RAISE NOTICE 'Todos los productos estan disponibles por el momento';
    END IF;
END;
$$ LANGUAGE plpgsql;

--Mandar a llamar mostrar_no_disponibles() para probar la función
--CALL mostrar_no_disponibles();


------"Vista" para factura de una orden
--- Funcion datos_factura() que recopile los datos necesarios para la factura de una orden
CREATE OR REPLACE FUNCTION datos_factura(p_folio varchar(15)) 
RETURNS TABLE(
    idFactura integer,
    fechaFactura timestamp,
    folioOrden varchar(15),
    rfcCliente varchar(13),
    nombreCliente varchar(150),
    domicilioCliente varchar(215),
    razonSocialCliente varchar(254),
    nombreProducto varchar(50),
    cantidadProducto integer,
    precioUnitario decimal(10,2),
    precioTotalProducto decimal(10,2),
    montoTotal decimal(10,2),
    importeTotal decimal(10,2)
)
AS $$
DECLARE
    registro_factura record;

BEGIN
    RAISE NOTICE 'Generando factura para la orden %', p_folio;
    FOR registro_factura IN
        SELECT f.idFactura, f.fechaFactura, f.folio, c.rfc, 
            c.nomPila || ' ' || c.apPaterno || ' ' || c.apMaterno AS nombreCompleto, 
            c.domEstado || ' ' || c.domCodigoPostal || ' ' || c.domColonia || ' ' || 
            c.domCalle || ' ' || c.domNumero AS domicilio,
            c.razonSocial, p.nombreProducto, d.cantidad, 
            p.precio, d.precioTotalProducto, o.totalAPagar
        FROM FACTURA f
        JOIN ORDEN o ON f.folio=o.folio
        JOIN DETALLE_ORDEN d ON d.folio=o.folio
        JOIN CLIENTE c ON c.idCliente=f.idCliente
        JOIN PRODUCTO p ON p.idProducto=d.idProducto
        WHERE f.folio=p_folio
    LOOP
        idFactura := registro_factura.idFactura;
        fechaFactura := registro_factura.fechaFactura;
        folioOrden := registro_factura.folio;
        rfcCliente := registro_factura.rfc;
        nombreCliente := registro_factura.nombreCompleto;
        domicilioCliente := registro_factura.domicilio;
        razonSocialCliente := registro_factura.razonSocial;
        nombreProducto := registro_factura.nombreProducto;
        cantidadProducto := registro_factura.cantidad;
        precioUnitario := registro_factura.precio;
        precioTotalProducto := registro_factura.precioTotalProducto;
        montoTotal := registro_factura.totalAPagar;
        importeTotal := (registro_factura.totalAPagar * 1.16);

        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--Mandar a llamar datos_factura() para probar la función
--SELECT * FROM datos_factura('ORD-0002');


------Total del número de ventas y monto total en un periodo de tiempo
CREATE OR REPLACE FUNCTION totales_periodo(
        IN fechaInicio date,
        IN fechaFin date,
        OUT total_num_ventas smallint,
        OUT total_monto numeric(10,2)
) AS $$
BEGIN
    SELECT COUNT(*), SUM(totalAPagar) 
    INTO total_num_ventas, total_monto
    FROM ORDEN
    WHERE CAST(fechaOrden AS date) BETWEEN fechaInicio AND fechaFin;

    IF total_monto IS NULL THEN
        total_monto := 0.00;
    END IF;
    RAISE NOTICE 'Resultados de ventas entre el % y el %', fechaInicio, fechaFin;
    RAISE NOTICE '>>  Numero_total_ventas: %  |  Monto_total_ventas: $% MXN', total_num_ventas, total_monto;
END;
$$ LANGUAGE plpgsql;

--Mandar a llamar totales_periodo() para probar la función

/* Opción 1 (Bloque anónimo para guardar los parámetros de salida)
DO $$
DECLARE
    resultado_num_ventas smallint;
    resultado_monto_total numeric(10,2);

BEGIN
    SELECT total_num_ventas, total_monto INTO resultado_num_ventas, resultado_monto_total
    FROM totales_periodo('2026-05-29', '2026-05-31');
END;
$$ LANGUAGE plpgsql;
*/

-- Opción 2 (Llamada de la función con SELECT)
--SELECT * FROM totales_periodo('2026-05-29', '2026-05-31');