
--Crear Base de Datos
create database proyectoequipobd;

--Conectar con la Base de Datos
\c proyectoequipobd;


-- Función que permite calcular la edad
create or replace function get_age(fecha_nacimiento date) returns int
language plpgsql immutable  
as $CODE$
begin 
	return extract (year from age(fecha_nacimiento)); 
end;
$CODE$;


-- Tabla Empleado
create table empleado(
	num_empleado int not null,
	nombre varchar(25) not null,
	apellido_pat varchar(15) not null,
	apellido_mat varchar (15) null,
	rfc_emp char(13) not null,
	fecha_nacimiento date not null,
	edad int generated always as (get_age(fecha_nacimiento)) stored,
	estado varchar(10) not null,
	cp int not null,
	colonia varchar(25) not null,
	calle varchar(15) not null,
	numero_calle int not null,
	sueldo money not null,
	foto bytea not null,
	constraint empleado_pk primary key (num_empleado)
);


-- Telefono de los empleados (atributo multivaluado)
create table empleado_telefono(
	telefono char(10) not null,
	num_empleado int not null,
	constraint empleado_tel_pk primary key (telefono),
	constraint emptel_emp_fk foreign key (num_empleado) 
	references empleado(num_empleado) on delete cascade on update cascade
); 


-- Tabla cocinero
create table cocinero(
	num_empleado int not null,
	especialidad varchar(100) not null,
	constraint cocinero_pk primary key (num_empleado),
	constraint cocinero_emp_fk foreign key (num_empleado) 
	references empleado(num_empleado) on delete cascade on update cascade
);


-- Tabla administrativo
create table administrativo (
	num_empleado int not null,
	rol varchar(50) not null,
	constraint administrativo_pk primary key (num_empleado),
	constraint admin_emp_fk foreign key (num_empleado)
	references empleado(num_empleado) on delete cascade on update cascade
);


-- Tabla mesero
create table mesero(
	num_empleado int not null,
	hora_inicio time not null,
	hora_fin time not null, 
	constraint empleado_mesero_pk primary key (num_empleado),
	constraint mesero_emp_fk foreign key (num_empleado) 
	references empleado(num_empleado) on delete cascade on update cascade
);


-- Tabla dependiente
create table dependiente(
	curp char(18) not null,
	num_empleado int not null,
	parentesco varchar(10) not null,
	nombre varchar(25) not null,
	apellido_pat varchar(15) not null,
	apellido_mat varchar(15) null,
	constraint dependiente_pk primary key (curp),
	constraint depe_emp_fk foreign key (num_empleado)
	references empleado(num_empleado) on delete cascade on update cascade
);


-- Tabla cliente
create table cliente(
	rfc_cliente char(13) not null,
	nombre varchar(25) not null,
	apellido_pat varchar(15) not null,
	apellido_mat varchar(15) null,
	email varchar(50) not null,
	razon_social varchar(50) not null,
	fecha_nacimiento date not null,
	estado varchar(15) not null,
	cp int not null,
	colonia varchar(25) not null,
	calle varchar(15) not null,
	numero_calle int not null,
	constraint cliente_pk primary key (rfc_cliente)
);


-- Tabla orden (ORD-001)
create table orden(
	folio char(7) not null,
	num_empleado int not null,
	rfc_cliente char(13) not null,
	fecha date default now(),
	total money not null,
	constraint orden_pk primary key (folio),
	constraint orden_emp_fk foreign key (num_empleado) 
	references empleado(num_empleado) on delete cascade on update cascade,
	constraint orden_cli_fk foreign key (rfc_cliente) 
	references cliente(rfc_cliente) on delete cascade on update cascade
);


-- Tabla categoria
create table categoria(
	nombre_categoria varchar(15) not null,
	descripcion varchar(150) not null,
	constraint categoria_pk primary key (nombre_categoria)
);


-- Tabla platillo_bebida
create table platillo_bebida(
	nombre_platilloBebida varchar(25) not null,
	precio money not null,
	descripcion varchar(200) not null,
	receta varchar(400) not null,
	disponibilidad int not null,
	nombre_categoria varchar(15) not null,
	constraint platilloBeb_pk primary key(nombre_platilloBebida),
	constraint platBe_cat_fk foreign key(nombre_categoria) 
	references categoria(nombre_categoria) on delete cascade on update cascade
);


-- Tabla enlista (orden-platillo)
create table enlista(
	folio char(7) not null,
	nombre_platilloBebida varchar(25) not null,
	cantidad_platilloBebida int not null,
	precio_platilloBebida money not null,
	constraint enlista_pk primary key(folio,nombre_platilloBebida),
	constraint enlista_folio foreign key(folio)
	references orden(folio) on delete cascade on update cascade,
	constraint enlista_nomPB foreign key(nombre_platilloBebida)
	references platillo_bebida(nombre_platilloBebida) on delete cascade on update cascade
);