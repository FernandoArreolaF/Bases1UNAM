INSERT INTO
    cocinero (
        numero_empleado_id,
        especialidad
    )
VALUES ('6', 'Cocina Vegetariana'), ('17', 'Cocina Tailandesa'), ('10', 'Repostería'), ('1', 'Cocina Italiana'), ('5', 'Cocina Tailandesa'), ('19', 'Parrilla y Asados'), ('20', 'Cocina Japonesa'), ('8', 'Cocina Molecular'), ('9', 'Cocina Francesa'), ('14', 'Repostería');

-- Consistencia

update empleado e
set es_cocinero = true
where e.numero_empleado_id in (
        select
            numero_empleado_id
        from cocinero
    );

update empleado e
set es_cocinero = false
where
    e.numero_empleado_id not in (
        select
            numero_empleado_id
        from cocinero
    );