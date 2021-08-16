create table CLIENTE(
	emailClie varchar(50),
	rfcClie varchar(13),
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
	numVenta varchar(7) not null,
	cantidad integer,
	prcTotlxArtic money,
	totalVenta money,
	factVent varchar(20),
	rfcClie varchar(13)
);


create table SERVICIO(
	idServ integer,
	numServ integer,
	descServ varchar(1000),
	precServ money,
	numImpresion integer,
	numRecarga integer,
	numVenta varchar(7)
);

create table PRODUCTO(
	codigoProd integer not null,
	marcaProd varchar(20),
	stockProd integer,
	nomRegalo varchar(50),
	nomArtDePape varchar(50), 
	descProd varchar(1000),
	precDeComprProd money,
	numVenta varchar(7),
	razonSocialProv varchar(35)
);

create table PROVEEDOR(
	razonSocialProv varchar(35) not null,
	telefProv varchar(13),
	calleProv varchar(30),
	numeroProv varchar(5),
	ciudadProv varchar(30),
	nombreProv varchar(30),
	apPatProv varchar(25),
	apMatProv varchar(25) null
);


alter table CLIENTE add constraint PK_rfcClie primary key (rfcClie);

alter table VENTA add constraint PK_numVenta primary key (numVenta);
alter table VENTA add constraint FK_numVenta_RFC foreign key(rfcClie) references CLIENTE(rfcClie);  

alter table SERVICIO add constraint PK_numServ primary key (numServ);
alter table SERVICIO add constraint FK_numServ_numVenta foreign key(numVenta) references VENTA(numVenta);
alter table SERVICIO add constraint CK_numServ CHECK (numServ = 1 OR numServ = 2);

alter table PROVEEDOR add constraint PK_razonSocialProv primary key (razonSocialProv);

alter table PRODUCTO add constraint PK_codigoProd primary key (codigoProd);
alter table PRODUCTO add constraint FK_codigoProd_numVenta foreign key(numVenta) references VENTA(numVenta);
alter table PRODUCTO add constraint FK_codigoProd_razonSocialProv foreign key(razonSocialProv) references PROVEEDOR(razonSocialProv);

create sequence SQ_numClie
	start with 111
	increment by 1;


create sequence SQ_numVenta
	start with 1
	increment by 1;
	

