INSERT INTO
    orden_general (
        orden_general_id,
        estatus,
        genero_factura,
        fecha,
        cliente_id,
        numero_empleado_id
    )
VALUES (
        81,
        'REGISTRADA',
        true,
        CURRENT_TIMESTAMP,
        1,
        14
    );

select total from orden_general where orden_general_id = 81;

INSERT INTO
    orden_detalle (
        orden_general_id,
        alimento_id,
        cantidad,
        subtotal
    )
VALUES (81, 4, 10, 690), (81, 5, 5, 65), (81, 6, 5, 95);
select total from orden_general where orden_general_id = 81;

select * from obtener_ordenes_mesero(14);

select * from obtener_ordenes_mesero(4);

select * from obtener_estadisticas_ventas('2022-01-01','2022-12-31');

select * from obtener_estadisticas_ventas(CURRENT_DATE);