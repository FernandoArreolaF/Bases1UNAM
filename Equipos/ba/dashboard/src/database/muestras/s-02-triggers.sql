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
        90,
        'REGISTRADA',
        true,
        CURRENT_TIMESTAMP,
        1,
        14
    );
select * from orden_general where orden_general_id = 90;
INSERT INTO
    orden_detalle (
        orden_general_id,
        alimento_id,
        cantidad,
        subtotal
    )
VALUES (90, 4, 10, 690), (90, 5, 5, 65), (90, 6, 5, 95);
select * from orden_general where orden_general_id = 90;