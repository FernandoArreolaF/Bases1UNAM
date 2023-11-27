--@Autor: DataMatrix Studios
--@Fecha creación:  2023
--@Descripción: Creación de las tablas para la BD de un restaurante.

-- Creación de la base de datos
-- create database Restaurate;
-- \c Restaurate

--
-- ENTIDAD EMPLEADO
--

create table EMPLEADO
(
	Numero_empleado numeric(4, 0) PRIMARY KEY,
	RFC varchar(13) not null,
	Nombre_empleado varchar(50) not null,
	Apellido_paterno varchar(50) not  null,
	Apellido_materno varchar(50) null,
	Fecha_nacimiento Date not null,
	Edad numeric(3, 0) not null,
	Sueldo numeric(8, 2) not null,
	Foto bytea not null,
	-- Domicilio
	Estado varchar(50) not null,
	Avenida_calle varchar(50) not null,
	Numero_exterior_vivienda numeric(5, 0) null,
	Colonia varchar(50) not null,
	Codigo_postal numeric(6, 0) not null,
	-- Rol del empleado
	Es_cocinero bit null,
	Es_mesero bit null,
	Es_administrativo bit null
);

--
-- ATRIBUTO MULTIVALUADO DE EMPLEADO → TELEFONO
--

create table EMPLEADO_TELEFONO
(
	Numero_empleado numeric(4, 0),
	Telefono_Id numeric(10, 0),
	constraint EMPLEADO_TELEFONO_PK PRIMARY KEY(Numero_empleado, Telefono_Id)
);

--
-- ENTIDAD COCINERO → TIPO DE EMPLEADO
--

create table COCINERO
(
	Numero_empleado_cocinero numeric(4, 0) PRIMARY KEY,
	Especialdad varchar(50),
	constraint Numero_empleado_cocinero_Fk FOREIGN KEY (Numero_empleado_cocinero) references EMPLEADO(Numero_empleado)
);

--
-- ENTIDAD MESERO → TIPO DE EMPLEADO
--

create table MESERO
(
	Numero_empleado_mesero numeric(4, 0) PRIMARY KEY,
	Horario_descripcion varchar(500) not null,
	constraint Numero_empleado_mesero_Fk FOREIGN KEY (Numero_empleado_mesero) references EMPLEADO(Numero_empleado)
);

--
-- ENTIDAD ADMINISTRATIVO → TIPO DE EMPLEADO
--

create table ADMINISTRATIVO
(
	Numero_empleado_administrativo numeric(4, 0) PRIMARY KEY,
	Rol varchar(50) not null,
	constraint Numero_empleado_administrativo_Fk FOREIGN KEY (Numero_empleado_administrativo) references EMPLEADO(Numero_empleado)  
);

--
-- ENTIDAD DEPENDIENTE → ENTIDAD DEBIL DE EMPLEADO
--

create table DEPENDIENTE
(
	ID_dependiente numeric(10, 0) not null,
	Numero_empleado numeric(4, 0) not null,
	Curp varchar(13) not null,
	Nombre_dependiente varchar(50) not null,
	Apellido_paterno varchar(50) not null,
	Apellido_materno varchar(50) null,
	Parentesco varchar(50) not null,
	constraint dependiente_pk PRIMARY KEY(ID_dependiente, Numero_empleado),
	constraint Numero_empleado_Fk FOREIGN KEY (Numero_empleado) references EMPLEADO(Numero_empleado)  
);

--
-- ENTIDAD CLIENTE
--

create table CLIENTE
(
	ID_cliente numeric(10, 0) PRIMARY KEY,
	RFC_cliente varchar(13) not null,
	Nombre_cliente varchar(50) not null,
	Apellido_paterno varchar(50) not null,
	Apellido_materno varchar(50) null,
	Fecha_nacimiento Date not null,
	Razon_social varchar(500) not null,
	Email varchar(200) not null,
	-- Domicilio
	Estado varchar(50) not null,
	Avenida_calle varchar(50) not null,
 	Numero_exterior_vivienda numeric(5, 0) not null,
	Colonia varchar(50) not null,
	Codigo_postal numeric(6, 0) not null
);

--
-- ENTIDAD FACTURA
--

create table FACTURA
(
	ID_factura numeric(10, 0) PRIMARY KEY,
	ID_cliente numeric(10, 0) not null,
	constraint ID_cliente_fk FOREIGN KEY (ID_cliente) references CLIENTE(ID_cliente)  
);

--
-- ENITDAD ORDEN
--

create table ORDEN
(
	Folio_orden varchar(14) PRIMARY KEY,
	Fecha_orden date not null,
	Total_a_pagar numeric(12, 2) not null,
	Mesero_atendio numeric(4, 0) not null,
	ID_factura numeric(10, 0) not null,
	constraint Mesero_atendio_fk FOREIGN KEY (Mesero_atendio) references MESERO(Numero_empleado_mesero)  ,
	constraint ID_factura_fk FOREIGN KEY (ID_factura) references FACTURA(ID_factura)  ,
	constraint chk_folio_orden check (Folio_orden = 'ORD-%')
);

--
-- ENTIDAD CATEGORIA
--

create table CATEGORIA
(
	ID_Categoria numeric(3, 0) PRIMARY KEY,
	Nombre_categoria varchar(100) not null,
	Descripcion_categoria varchar(500) not null
);

--
-- ENTIDAD ALIMENTOS (PLATILLO Y BEBIDA)
--

create table ALIMENTOS
(
	ID_ALIMENTO numeric(6, 0) PRIMARY KEY,
	Nombre_platillo varchar(100) not null,
	Receta_platillo varchar(1000) not null,
	Descripcion_platillo varchar(500) not null,
	Disponibilidad_platillo varchar(10) not null,
	Precio_platillo numeric(10, 2) not null,
	ID_Categoria numeric(3, 0) not null,
	constraint ID_Categoria_Fk FOREIGN KEY (ID_Categoria) references CATEGORIA(ID_Categoria)  
);

--
-- ENITDAD RELACION M:M → RELACIÓN ENTRE ORDEN Y PLATILLO
--

create table ORDEN_CONTIENE_PLATILLO
(
	ID_ALIMENTO numeric(6, 0) not null,
	Folio_orden varchar(14) not null,
	Cantidad_platillo numeric(5, 0) not null,
	constraint ID_ALIMENTO_Folio_orden_pk PRIMARY KEY(ID_ALIMENTO, Folio_orden),
	constraint ID_ALIMENTO_Fk FOREIGN KEY (ID_ALIMENTO) references ALIMENTOS(ID_ALIMENTO)  ,
	constraint Folio_orden_Fk FOREIGN KEY (Folio_orden) references ORDEN(Folio_orden)  

);