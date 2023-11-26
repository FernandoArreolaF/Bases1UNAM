-- Table: Empleado

CREATE TABLE
    empleado(
        numero_empleado_id serial,
        ap_pat varchar(40) not null,
        ap_mat varchar(40),
        email varchar(200) not null,
        pw varchar(70) not null,
        calle varchar(60) not null,
        codigo_postal varchar(5) not null,
        colonia varchar(60) not null,
        edad numeric(3, 0) not null,
        estado varchar(40) not null,
        es_administrador boolean default false not null,
        es_cocinero boolean default false not null,
        es_mesero boolean default false not null,
        fecha_nacimiento date not null,
        foto bytea null,
        nombre varchar(70) not null,
        numero_calle varchar(40) not null,
        rfc char(13) not null,
        sueldo numeric(8, 2) not null,
        constraint empleado_pk primary key(numero_empleado_id),
        constraint empleado_rfc_uk unique(rfc),
        constraint subtipo_empleado_total_chk check( (es_administrador = true)
            or (es_cocinero = true)
            or (es_mesero = true)
        ),
        constraint empleado_codigo_postal_chk check(codigo_postal ~ '^[0-9]{5}$'),
        constraint empleado_edad_chk check(edad>=0),
        constraint empleado_email_uk unique(email),
        constraint empleado_email_chk check(email ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
    );

-- Table: Telefono

create table
    telefono(
        numero_empleado_id serial,
        telefono numeric(15, 0),
        constraint telefono_pk primary key(numero_empleado_id, telefono),
        constraint telefono_numero_empleado_id_fk foreign key(numero_empleado_id) references empleado(numero_empleado_id),
        constraint telefono_telefono_chk check(telefono > 0)
    );

-- cliente

create table
    cliente(
        cliente_id serial,
        email varchar(200) not null,
        pw varchar(70) not null,
        nombre varchar(40) not null,
        ap_pat varchar(40) not null,
        ap_mat varchar(40),
        calle varchar(60),
        codigo_postal char(5),
        colonia varchar(60),
        es_moral boolean,
        estado varchar(40),
        fecha_nacimiento date not null,
        numero_calle varchar(40),
        rfc char(13),
        constraint cliente_pk primary key(cliente_id),
        constraint cliente_rfc_uk unique(rfc),
        constraint cliente_email_uk unique(email),
        constraint cliente_email_chk check(email ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
    );

-- Table: Dependiente

create table
    dependiente(
        dependiente_id serial,
        numero_empleado_id serial,
        ap_mat varchar(40),
        ap_pat varchar(40) not null,
        curp char(18) not null,
        nombre varchar(40) not null,
        parentesco varchar(40) not null,
        constraint dependiente_pk primary key(dependiente_id),
        constraint dependiente_numero_empleado_id_fk foreign key(numero_empleado_id) references empleado(numero_empleado_id),
        constraint dependiente_curp_uk unique(curp),
        constraint dependiente_parentesco_chk check(
            parentesco in (
                'Hermano',
                'Hermana',
                'Padre',
                'Madre',
                'Hijo',
                'Hija',
                'Abuelo',
                'Abuela',
                'Nieto',
                'Nieta',
                'Tío',
                'Tía',
                'Primo',
                'Prima',
                'Sobrino',
                'Sobrina'
            )
        )
    );

-- Table: administrador

create table
    administrador(
        numero_empleado_id serial,
        rol varchar(40) not null,
        constraint administrador_pk primary key(numero_empleado_id),
        constraint administrador_numero_empleado_id_fk foreign key(numero_empleado_id) references empleado(numero_empleado_id),
        constraint administrador_rol_chk check(
            rol in (
                'Dueño',
                'Gerente General',
                'Gerente de Operaciones',
                'Gerente de Recursos Humanos',
                'Gerente Financiero',
                'Gerente de Marketing'
            )
        )
    );

-- mesero

create table
    mesero(
        numero_empleado_id serial,
        hora_fin timestamp not null,
        hora_inicio timestamp not null,
        constraint mesero_pk primary key(numero_empleado_id),
        constraint mesero_numero_empleado_id_fk foreign key(numero_empleado_id) references empleado(numero_empleado_id),
        constraint mesero_hora_inicio_chk check(hora_inicio < hora_fin)
    );

-- cocinero

create table
    cocinero(
        numero_empleado_id serial,
        especialidad varchar(40) not null,
        constraint cocinero_pk primary key(numero_empleado_id),
        constraint cocinero_numero_empleado_id_fk foreign key(numero_empleado_id) references empleado(numero_empleado_id),
        constraint cocinero_especialidad_chk check(
            especialidad in (
                'Cocina Francesa',
                'Cocina Italiana',
                'Cocina Japonesa',
                'Cocina Mexicana',
                'Repostería',
                'Cocina Vegetariana',
                'Cocina de Fusión',
                'Parrilla y Asados',
                'Cocina Tailandesa',
                'Cocina Molecular'
            )
        )
    );

-- categoria_alimento

create table
    categoria_alimento(
        categoria_alimento_id serial,
        nombre varchar(60) not null,
        descripcion text not null,
        constraint categoria_alimento_pk primary key(categoria_alimento_id)
    );

-- alimento

create table
    alimento(
        alimento_id serial,
        categoria_alimento_id serial,
        descripcion varchar(200) not null,
        disponible boolean default false not null,
        nombre varchar(60) not null,
        precio numeric(10, 2) not null,
        receta text not null,
        constraint alimento_pk primary key(alimento_id),
        constraint alimento_categoria_alimento_id_fk foreign key(categoria_alimento_id) references categoria_alimento(categoria_alimento_id)
    );

-- orden_general

create table
    orden_general(
        orden_general_id serial,
        estatus varchar(40) default 'REGISTRADA' not null,
        genero_factura boolean default false not null,
        folio varchar(40),
        fecha timestamp default now() not null,
        total numeric(15, 2) DEFAULT 0 not null,
        cliente_id serial not null,
        numero_empleado_id serial,
        constraint orden_general_pk primary key(orden_general_id),
        constraint orden_general_cliente_id_fk foreign key(cliente_id) references cliente(cliente_id),
        constraint orden_general_numero_empleado_fk foreign key(numero_empleado_id) references mesero(numero_empleado_id),
        constraint orden_general_estatus_chk check(
            estatus in (
                'REGISTRADA',
                'EN PROGRESO',
                'ENTREGADA',
                'CANCELADA'
            )
        ),
        constraint orden_general_folio_chk check(folio ~ '^ORD-[1-9][0-9]*$')
    );

-- orden_detalle

create table
    orden_detalle(
        orden_general_id serial,
        alimento_id serial,
        cantidad numeric(3, 0) not null,
        subtotal numeric(12, 2) not null,
        constraint orden_detalle_pk primary key(orden_general_id, alimento_id),
        constraint orden_detalle_orden_general_id foreign key(orden_general_id) references orden_general(orden_general_id),
        constraint orden_detalle_alimento_id foreign key(alimento_id) references alimento(alimento_id),
        constraint orden_detalle_cantidad_chk check(cantidad > 0)
    );