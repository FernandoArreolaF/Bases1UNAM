-- Proyecto final | Equipo: THE NORMALIZERS | Entrega 25/05/2025

CREATE TABLE categoria(
categoria_id    numeric(10) not null,
nombre          varchar(40) not null,
CONSTRAINT pk_categoria PRIMARY KEY(categoria_id)
);

CREATE TABLE telefono(
telefono_id    numeric(10) not null,
telefono       varchar(40) not null,
CONSTRAINT pk_telefono_id PRIMARY KEY(telefono_id),
CONSTRAINT uq_telefono UNIQUE(telefono)
);

CREATE TABLE sucursal(
sucursal_id     numeric(10) not null,
ubicacion       varchar(40) not null,
telefono        varchar(40) not null,
año_fundacion   SMALLINT not null,
CONSTRAINT pk_sucursal PRIMARY KEY(sucursal_id)
);


CREATE TABLE empleado (
empleado_id     numeric(10) not null,
supervisor_id   numeric(10),
sucursal_id     numeric(10) not null,
telefono_id     numeric(10) not null,
num_empleado    varchar(10) not null,
rfc             varchar(40) not null,
 curp            varchar(40) not null, 
nombre          varchar(40) not null,
ap_paterno      varchar(40) not null,
ap_materno      varchar(40),
calle           varchar(40) not null,
numero          varchar(10) not null,
cp              varchar(40) not null,
colonia         varchar(40) not null,
estado          varchar(40) not null,
email           varchar(40) not null,
fecha_ingreso   date not null,
tipo_empleado   varchar(10) not null,
    
CONSTRAINT pk_empleado PRIMARY KEY(empleado_id),
CONSTRAINT fk_empleado_supervisor FOREIGN KEY(supervisor_id) REFERENCES empleado(empleado_id),
CONSTRAINT fk_empleado_sucursal FOREIGN KEY(sucursal_id) REFERENCES sucursal(sucursal_id),
CONSTRAINT fk_empleado_telefono FOREIGN KEY(telefono_id) REFERENCES telefono(telefono_id),
CONSTRAINT uq_num_empleado UNIQUE (num_empleado),
CONSTRAINT chk_tipo_empleado CHECK (
    tipo_empleado IN ('cajero', 'vendedor', 'administrativo', 'seguridad', 'limpieza')
 )
);



CREATE TABLE cliente(
cliente_id      numeric(10) not null,  
rfc             varchar(40) not null, 
nombre          varchar(40) not null,
ap_paterno      varchar(40) not null,
ap_materno      varchar(40) null,
razon_social    varchar(40) null,
calle           varchar(40) not null,
numero          varchar(40) not null,
cp              varchar(40) not null,
colonia         varchar(40) not null,
estado          varchar(40) not null,
email           varchar(40) not null,
telefono        varchar(40) not null,
CONSTRAINT pk_cliente PRIMARY KEY(cliente_id),
CONSTRAINT uq_cliente_rfc UNIQUE (rfc)
);


CREATE TABLE proveedor(
proveedor_id    numeric(10) not null,  
rfc             varchar(40) not null,
razon_social    varchar(40) not null,
calle           varchar(40) not null,
numero          varchar(40) not null,
cp              varchar(40) not null,
colonia         varchar(40) not null,
estado          varchar(40) not null,
telefono        varchar(40) not null,
num_cuenta      varchar(40) not null,
CONSTRAINT pk_proveedor PRIMARY KEY(proveedor_id),
CONSTRAINT uq_proveedor_rfc UNIQUE (rfc)
);


CREATE TABLE articulo(
articulo_id     numeric(10) not null,
categoria_id    numeric(10) not null,
cod_barras      varchar(40) not null,
nombre          varchar(40) not null,
precio_venta    numeric(20,2) not null,
precio_compra   numeric(20,2) not null,
stock           numeric(20) not null,
fotografia      bytea   not null,
CONSTRAINT pk_articulo PRIMARY KEY(articulo_id),
CONSTRAINT fk_articulo_categoria FOREIGN KEY(categoria_id) REFERENCES categoria(categoria_id),
CONSTRAINT uq_cod_barras UNIQUE (cod_barras)
);

CREATE TABLE articulo_proveedor(
articulo_proveedor_id   numeric(10) not null,
articulo_id             numeric(10) not null,
proveedor_id            numeric(10) not null,
fecha_inicio_surtido DATE,
CONSTRAINT pk_articulo_proveedor PRIMARY KEY(articulo_proveedor_id),
CONSTRAINT fk_articulo_proveedor1 FOREIGN KEY(articulo_id) REFERENCES articulo(articulo_id),
CONSTRAINT fk_articulo_proveedor2 FOREIGN KEY(proveedor_id) REFERENCES proveedor(proveedor_id)
);

CREATE TABLE venta(
venta_id                numeric(10) not null,
empleado_vendedor_id    numeric(10) not null,
empleado_cobrador_id    numeric(10) not null,
cliente_id              numeric(10),
folio                   varchar(40) not null,
fecha_venta             date not null, 
monto_total             numeric(20,2) not null DEFAULT 0.00,
cantidad_articulos      numeric(10,0)not null DEFAULT 0,
CONSTRAINT pk_venta PRIMARY KEY(venta_id),
CONSTRAINT fk_venta_asesor FOREIGN KEY(empleado_vendedor_id) REFERENCES empleado(empleado_id),
CONSTRAINT fk_venta_cobrador FOREIGN KEY(empleado_cobrador_id) REFERENCES empleado(empleado_id),
CONSTRAINT fk_venta_cliente FOREIGN KEY(cliente_id) REFERENCES cliente(cliente_id),
CONSTRAINT uq_folio_venta UNIQUE (folio)
);

CREATE TABLE articulo_venta(
articulo_venta_id    numeric(10) not null,
articulo_id          numeric(10) not null,
venta_id             numeric(10) not null,
cantidad             numeric(10) not null,
monto_por_articulo   numeric(20,2) not null,
CONSTRAINT pk_articulo_venta PRIMARY KEY(articulo_venta_id),
CONSTRAINT fk_articulo_venta1 FOREIGN KEY(articulo_id) REFERENCES articulo(articulo_id),
CONSTRAINT fk_articulo_venta2 FOREIGN KEY(venta_id) REFERENCES venta(venta_id)
);
