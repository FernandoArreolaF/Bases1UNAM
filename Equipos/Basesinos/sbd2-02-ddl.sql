drop database Restaurante_Final;

create database Restaurante_Final;

\c restaurante_final

create sequence estado_id_seq
start with 1
increment by 1
minvalue 1
maxvalue 999999;

create table estado(
  estado_id         numeric(6,0)    not null default nextval('estado_id_seq'),
  estado            varchar(40)     not null,
  fecha_registro    date not null default now(),
  constraint estado_pk primary key (estado_id)
);

create sequence empleado_id_seq
start with 1
increment by 1
minvalue 1
maxvalue 9999;

create table empleado (
  empleado_id         numeric(4,0)    not null default nextval('empleado_id_seq'),
  numero_empleado     numeric(4,0)    not null,
  rfc                 varchar(13)     not null,
  nombre              varchar(20)     not null,
  ap_paterno          varchar(20)     not null,
  ap_materno          varchar(20)     not null,
  fecha_nacimiento    date            not null,
  edad                numeric(2,0)    not null,
  sueldo              numeric(9,2)    not null,
  foto                bytea           not null,
  estado_id           numeric(6,0)    not null,
  cp                  numeric(6,0)    not null,
  colonia             varchar(40)     not null,
  calle               varchar(40)     not null,
  numero              numeric(3,0)    not null,
  es_cocinero         boolean         not null,
  es_administrativo   boolean         not null,
  es_mesero           boolean         not null,
  fecha_registro      date            not null default now(),
  constraint empleado_pk primary key(empleado_id),
  constraint empleado_rfc_uk unique(rfc),
  constraint numero_empleado_uk unique(numero_empleado),
  constraint empleado_tipo_chk check (
      es_cocinero = true or es_administrativo = true or es_mesero = true 
  ),
  constraint empleado_estado foreign key(estado_id) references estado(estado_id)
);

create sequence telefono_empleado_id_seq
start with 1
increment by 1
minvalue 1
maxvalue 99999;

create table telefono_empleado(
  telefono_empleado_id    numeric(5,0)    not null default nextval('telefono_empleado_id_seq'),
  num_telefono            varchar(10)     not null,
  empleado_id             numeric(4,0)    not null,
  fecha_registro          date            not null default now(),
  constraint telefono_empleado_pk primary key(telefono_empleado_id),
  constraint telefono_empleado_fk foreign key(empleado_id) references empleado(empleado_id) on delete cascade
);

create sequence dependiente_id_seq
start with 1
increment by 1
minvalue 1
maxvalue 99999;

create table dependiente (  
  dependiente_id  numeric(5,0)    not null default nextval('dependiente_id_seq'),
  curp            varchar(18)     not null,
  parentesco      varchar(20)     not null,
  nombre          varchar(20)     not null,
  ap_paterno      varchar(20)     not null,
  ap_materno      varchar(20)     not null,
  empleado_id     numeric(4,0)    not null,
  fecha_registro  date            not null default now(),
  constraint dependiente_pk primary key(dependiente_id),
  constraint dependiente_empleado_fk foreign key(empleado_id)
    references empleado(empleado_id) on delete cascade,
  constraint dependiente_curp_uk unique(curp)
);

create table cocinero (
  empleado_id     numeric(4,0),
  especialidad    varchar(40)     not null,
  fecha_registro  date            not null default now(),
  constraint cocinero_empleado_fk foreign key (empleado_id) 
    references empleado(empleado_id) on delete cascade on update cascade,
  constraint cocinero_empleado_pk primary key (empleado_id)
);

create table administrativo (
  empleado_id     numeric(4,0),
  rol             varchar(40)     not null,
  fecha_registro  date            not null default now(),
  constraint administrativo_empleado_fk foreign key (empleado_id) 
    references empleado(empleado_id) on delete cascade on update cascade,
  constraint administrativo_empleado_pk primary key (empleado_id)
);

create table mesero (
  empleado_id     numeric(4,0),
  horario_inicio  varchar(5) not null, 
  horario_final   varchar(5) not null,
  fecha_registro  date       not null default now(),
  constraint mesero_empleado_fk foreign key (empleado_id) 
    references empleado(empleado_id) on delete cascade on update cascade,
  constraint mesero_empleado_pk primary key (empleado_id)
);

create sequence categoria_id_seq
start with 1
increment by 1
minvalue 1
maxvalue 99;

create table categoria(
  categoria_id    numeric(2,0)    not null default nextval('categoria_id_seq'),
  nombre          varchar(40)     not null,
  descripcion     varchar(120)    not null,   
  fecha_registro  date            not null default now(), 
  constraint categoria_pk primary key(categoria_id)
);


create sequence factura_folio_seq
start with 1
increment by 1
minvalue 1
maxvalue 99999;

create sequence orden_id_seq
start with 1
increment by 1
minvalue 1
maxvalue 9999999999;

create table orden(
  orden_id        numeric(10,0)   not null default nextval('orden_id_seq'),
  folio           varchar(14)     not null default ('ORD-' || nextval('factura_folio_seq')::TEXT),
  fecha_orden     timestamptz     not null,
  total           numeric(9,2)    not null,
  empleado_id     numeric(4,0)    null,
  fecha_registro  date            not null default now(), 
  constraint orden_pk primary key(orden_id),
  constraint orden_empleado_id_fk foreign key(empleado_id)
    references mesero(empleado_id) on delete set null on update cascade
);

create sequence producto_id_seq
start with 1
increment by 1
minvalue 1
maxvalue 9999999999;

create table producto(
  producto_id       numeric(10,0)   not null default nextval('producto_id_seq'),
  nombre            varchar(40)     not null,
  descripcion       varchar(180)    not null,
  precio            numeric(7,2)    not null,
  disponibilidad    boolean         not null,
  es_platillo       boolean         not null,
  es_bebida         boolean         not null,
  receta            varchar(400)    not null,
  categoria_id      numeric(2,0)    not null,
  fecha_registro    date            not null default now(), 
  constraint producto_pk primary key(producto_id),
  constraint producto_categoria_id_fk foreign key(categoria_id) 
    references categoria(categoria_id) on update cascade,
  constraint producto_es_tipo_chk
    check((es_platillo = true and es_bebida = false)
       or (es_platillo = false and es_bebida = true)),
  constraint precio_chk check(precio > 0)
);

create sequence orden_producto_id_seq
start with 1
increment by 1
minvalue 1
maxvalue 999999999999999;


create table orden_producto(
  orden_producto_id numeric(15,0)   not null default nextval('orden_producto_id_seq'),
  total_producto    numeric(7,2)    not null,
  cantidad_producto numeric(2,0)    not null,
  orden_id          numeric(10,0)   not null,
  producto_id       numeric(10,0)   not null,
  fecha_registro    date            not null default now(), 
  constraint orden_producto_pk primary key(orden_producto_id),
  constraint orden_producto_orden_id_fk
    foreign key(orden_id) references orden(orden_id),
  constraint orden_producto_producto_id_fk
    foreign key(producto_id) references producto(producto_id)
);

create sequence cliente_id_seq
start with 1
increment by 1
minvalue 1
maxvalue 99999;

create table cliente(
  cliente_id      numeric(5,0)    not null default nextval('cliente_id_seq'),
  rfc             varchar(13)     not null,
  razon_social    varchar(40)     not null,
  fecha_nacimiento date           not null,
  nombre          varchar(20)     not null,
  ap_paterno      varchar(20)     not null,
  ap_materno      varchar(20)     not null,
  email           varchar(40)     not null,
  estado_id       numeric(6,0)    not null,
  cp              numeric(5,0)    not null,
  colonia         varchar(40)     not null,
  calle           varchar(40)     not null,
  numero          numeric(3,0)    not null,
  fecha_registro  date            not null default now(), 
  constraint cliente_pk primary key(cliente_id),
  constraint cliente_estado_fk foreign key(estado_id) 
    references estado(estado_id),
  constraint cliente_rfc_uk unique(rfc)
);

create sequence factura_id_seq
start with 1
increment by 1
minvalue 1
maxvalue 9999999;

create table factura (
  factura_id      numeric(7,0)  not null default nextval('factura_id_seq'),
  fecha_factura   timestamptz   not null, 
  cliente_id      numeric(5,0)  not null,
  orden_id        numeric(10,0) not null,
  fecha_registro  date          not null default now(), 
  constraint factura_pk primary key (factura_id),
  constraint factura_cliente_fk foreign key (cliente_id)
    references cliente(cliente_id),
  constraint factura_orden_fk foreign key (orden_id)
    references orden(orden_id)
);
