INSERT INTO
    mesero (
        numero_empleado_id,
        hora_fin,
        hora_inicio
    )
VALUES (
        '13',
        '1971-01-01 17:04:00',
        '1971-01-01 07:00:00'
    ), (
        '1',
        '1971-01-01 17:05:00',
        '1971-01-01 07:00:00'
    ), (
        '15',
        '1971-01-01 17:30:00',
        '1971-01-01 07:00:00'
    ), (
        '8',
        '1971-01-01 17:53:00',
        '1971-01-01 07:00:00'
    ), (
        '5',
        '1971-01-01 17:45:00',
        '1971-01-01 07:00:00'
    ), (
        '2',
        '1971-01-01 17:06:00',
        '1971-01-01 07:00:00'
    ), (
        '20',
        '1971-01-01 17:48:00',
        '1971-01-01 07:00:00'
    ), (
        '3',
        '1971-01-01 17:17:00',
        '1971-01-01 07:00:00'
    ), (
        '14',
        '1971-01-01 17:03:00',
        '1971-01-01 07:00:00'
    ), (
        '17',
        '1971-01-01 17:44:00',
        '1971-01-01 07:00:00'
    ), (
        '10',
        '1971-01-01 17:44:00',
        '1971-01-01 07:00:00'
    );

-- Consistencia

update empleado e
set es_mesero = true
where e.numero_empleado_id in (
        select
            numero_empleado_id
        from mesero
    );

update empleado e
set es_mesero = false
where
    e.numero_empleado_id not in (
        select
            numero_empleado_id
        from mesero
    );