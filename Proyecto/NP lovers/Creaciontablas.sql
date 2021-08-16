create table CLIENTE(
	email_cliente varchar(50),
	rfc_cliente varchar(13) not null,
	numeroClie integer,
	calleClie varchar(35),
	codPosClie integer,
	colClie varchar(30),
	estRepClie varchar(25),
	ciudadClie varchar(30),
	nombreClie varchar(25),
	apPatClie varchar(30),
	apMatClie varchar(30) null
);


create table VENTA(

	numVenta varchar(8),
	fechaVenta date,

	cantidadUno integer, 
	codProdUno integer,
	cantidadDos integer null,
	codProdDos integer null,
	cantidadTres integer null,
	codProdTres integer null,	
	totalVenta money null,
	rfcCliente varchar(13) null
);


create table SERVICIO(
	idServ integer not null,
	numServ integer,
	descServ varchar(1000),
	precServ money,
	numImpresion integer,
	numRecarga integer,
	numVenta varchar(8)
);

create table PRODUCTO(
	codigoProd integer not null,
	marcaProd varchar(20),
	stock_Prod integer,
	nomRegalo varchar(50) null,
	nomArtDePape varchar(50) null, 
	descProd varchar(1000),
	precDeComprProd money,
	precDeVentaProd money,
	numVenta varchar(8),
	razonSocial_Prov varchar(35)
);

create table PROVEEDOR(
	razonSocial_Prov varchar(35) not null,
	telef_Prov varchar(13),
	calleProv varchar(30),
	numeroProv varchar(5),
	ciudadProv varchar(30),
	nombreProv varchar(30),
	apPatProv varchar(25),
	apMatProv varchar(25) null
);


alter table CLIENTE add constraint pk_cliente primary key (rfc_cliente);

alter table VENTA add constraint pk_venta primary key (numVenta);
alter table VENTA add constraint fk_numVenta_RFC foreign key(rfcCliente) references CLIENTE(rfc_cliente);  

alter table SERVICIO add constraint pk_numServ primary key (numServ);
alter table SERVICIO add constraint fk_numServ_numVenta foreign key(numVenta) references VENTA(numVenta);
alter table SERVICIO add constraint ck_numServ CHECK (numServ = 1 OR numServ = 2);

alter table PROVEEDOR add constraint pk_razonSocial_Prov primary key (razonSocial_Prov);

alter table PRODUCTO add constraint pk_codigoProd primary key (codigoProd);
alter table PRODUCTO add constraint fk_codigoProd_numVenta foreign key(numVenta) references VENTA(numVenta);
alter table PRODUCTO add constraint fk_codigoProd_razonSocial_Prov foreign key(razonSocial_Prov) references PROVEEDOR(razonSocial_Prov);

create sequence SQ_numeroClie
	start with 111
	increment by 1;


create sequence SQ_numVenta
	start with 1
	increment by 1;


