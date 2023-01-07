drop table categoria cascade;
drop table articulo cascade;
drop table estado cascade;
drop table proveedor cascade;
drop table surtir cascade;
drop table cliente cascade;
drop table venta cascade;
drop table tiene cascade;
drop table sucursal cascade;
drop table tipo cascade;
drop table empleado cascade;
drop table telefono cascade;
drop table realiza cascade;

create table categoria(
idCat smallint not null,
categoria varchar(15) not null,
constraint categoria_pk primary key (idCat)
);

create table articulo(
codBarras varchar(12) not null,
fotografia bytea not null,
nombre varchar(15) not null,
precioVenta float not null,
precioCompra float not null,
stock smallint not null,
idCat smallint not null,
constraint articulo_pk primary key (codBarras),
constraint art_cat_fk foreign key (idCat)
references categoria (idCat)
);

create table estado(
idEdo smallint not null,
estado varchar(50) not null,
constraint estado_pk primary key (idEdo)
);

create table proveedor(
rfcProv varchar(13) not null,
razSocialProv varchar(150) not null,
calle varchar(50) not null,
colonia varchar(50) not null,
numero smallint not null,
codPostal varchar(5) not null,
telefono varchar(10) not null,
ctaPago varchar(20) not null,
idEdo smallint not null,
constraint proveedor_pk primary key (rfcProv),
constraint prov_edo_fk foreign key (idEdo)
references estado (idEdo)
);

create table surtir(
codBarras varchar(12) not null,
rfcProv varchar(13) not null,
constraint surtir_pk primary key (codBarras,rfcProv),
constraint surtir_art_fk foreign key (codBarras)
references articulo (codBarras),
constraint surtir_prov_fk foreign key (rfcProv)
references proveedor (rfcProv)
);

create table cliente(
rfcCliente varchar(13) not null,
nombres varchar(100) not null,
apPat varchar(50) not null,
apMat varchar(50) null,
email varchar(100) not null,
razSocialCliente varchar(150) not null,
telefonoCliente varchar(10) not null,
calle varchar(50) not null,
colonia varchar(50) not null,
numero smallint not null,
codPostal varchar(5) not null,
idEdo smallint not null,
constraint cli_pk primary key (rfcCliente),
constraint cli_edo_fk foreign key (idEdo)
references estado (idEdo)
);

create table venta(
folio varchar(7) not null,
fecha timestamp not null,
cantTotalArt smallint default 0 not null,
montoTotal float default 0.0 not null,
rfcCliente varchar(13) null,
constraint venta_pk primary key (folio),
constraint venta_cli_fk foreign key (rfcCliente)
references cliente (rfcCliente)
);

create table tiene(
folio varchar(7) not null,
codBarras varchar(12) not null,
cantXArt smallint default 0 not null,
montoXArt float default 0.0 not null,
constraint tiene_pk primary key (folio,codBarras),
constraint tiene_venta_fk foreign key (folio)
references venta (folio),
constraint tiene_art_fk foreign key (codBarras)
references articulo (codBarras)
);

create table sucursal(
telefonoSuc varchar(10) not null,
calle varchar(50) not null,
colonia varchar(50) not null,
numero smallint not null,
codPostal varchar(5) not null,
anioFund smallint not null,
idEdo smallint not null,
constraint suc_pk primary key (telefonoSuc),
constraint suc_edo_fk foreign key (idEdo)
references estado (idEdo)
);

create table tipo(
idTipo smallint not null,
tipo varchar(50) not null,
constraint tipo_pk primary key (idTipo)
);

create table empleado(
numEmp varchar(5) not null,
fechaIng date not null,
rfcEmp varchar(13) not null,
curp varchar(18) not null,
email varchar(100) not null,
nombres varchar(100) not null,
apPat varchar(50) not null,
apMat varchar(50) null,
calle varchar(50) not null,
colonia varchar(50) not null,
numero smallint not null,
codPostal varchar(5) not null,
idTipo smallint not null,
idEdo smallint not null,
numEmpSup varchar(5) default null,
telefonoSuc varchar(10) not null,
constraint emp_pk primary key (numEmp),
constraint emp_tipo_fk foreign key (idTipo)
references tipo (idTipo),
constraint emp_edo_fk foreign key (idEdo)
references estado (idEdo),
constraint emp_emp_fk foreign key (numEmpSup)
references empleado (numEmp),
constraint emp_suc_fk foreign key (telefonoSuc)
references sucursal (telefonoSuc)
);

create table telefono(
telefono varchar(10) not null,
numEmp varchar(5) not null,
constraint tel_pk primary key (telefono,numEmp),
constraint tel_emp_fk foreign key (numEmp)
references empleado (numEmp)
);

create table realiza(
folio varchar(7) not null,
numEmp varchar(5) not null,
numEmpCobrador varchar(5) not null,
constraint realiza_pk primary key (folio,numEmp),
constraint realiza_emp_fk foreign key (numEmp)
references empleado (numEmp),
constraint realiza_empCob_fk foreign key (numEmpCobrador)
references empleado (numEmp)
);
