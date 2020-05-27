CREATE OR REPLACE FUNCTION fn_inserta_datos() RETURNS VOID
LANGUAGE SQL
AS
$$
	--================================================================================
	--AUTORES: solucionesTI_AAAA
	--BD:PROYECTO_PAPELERIA
	--DESCRIPCIÓN:Insercion de datos.
	--FECHA DECREACIÓN 
	--================================================================================

	--------------------------------------------------------------------------
	--TABLA_1 CATEGORIA
	INSERT INTO CATEGORIA(nombre_categoria,descripcion)
	VALUES('Papeleria','Articulos escolares y de oficina');
	INSERT INTO CATEGORIA(nombre_categoria,descripcion) 
	VALUES('Regalos','Articulos relacionados a regalos (regalos y envolturas)');
	INSERT INTO CATEGORIA(nombre_categoria,descripcion)
	VALUES('Servicio de impresiones','Imp. B/N, color y en diferentes tamaños');
	INSERT INTO CATEGORIA(nombre_categoria,descripcion)
	VALUES('Servicio de recargas','Recargas telefónicas a todas las compañias');
	--SELECT * FROM CATEGORIA;
	--------------------------------------------------------------------------
	--TABLA_2 PROVEEDORES(ATRIBUTO DOMICILIO COMO Estado|C.P.|Col.|Calle y No.|nombre)
	INSERT INTO PROVEEDORES(razon_social,domicilio,nombre)
	VALUES('Papeleria_Mesones','CDMX, 06080, Centro, Mesones 32','Papeleria Mesones');
	INSERT INTO PROVEEDORES(razon_social,domicilio,nombre)
	VALUES('Tony_Superpapeleria_Mesones','CDMX, 06090, Centro, Mesones 160-B','Tony Superpapeleria Mesones');
	INSERT INTO PROVEEDORES(razon_social,domicilio,nombre)
	VALUES('La_Reyna_De_Mesones_SA_de_CV','CDMX, 06090, Centro, Jesús María 118','La Reyna');
	INSERT INTO PROVEEDORES(razon_social,domicilio,nombre)
	VALUES('Mobil_Mex_SA_de_CV,','CDMX, 11570, Lomas de Chapultepec, Monte Elbruz 132','Mobil Mex');
	INSERT INTO PROVEEDORES(razon_social,domicilio,nombre)
	VALUES('Grupo_Fila Dixon','EDOMEX, 54940, Tultitlan, Autopista Mexico-Queretaro 104 Int C','Grupo Dixon');
	INSERT INTO PROVEEDORES(razon_social,domicilio,nombre)
	VALUES('Papel_S.A.','CDMX, 06720, Doctores, Doctor Andrade 78','Papeles en tamaños');
	INSERT INTO PROVEEDORES(razon_social,domicilio,nombre)
	VALUES('Fantasías_Miguel_SA_de_CV','EDOMEX, 53100, Satelite, Cto Cirujanos 5','Fantasías Miguel');
	INSERT INTO PROVEEDORES(razon_social,domicilio,nombre)
	VALUES('Comercializadora_de_impresoras_Angel_SA_CV','CDMX, 06090,Centro,Mesones 55, Papeleria Mesones','Angel_impresoras');
	--SELECT * FROM PROVEEDORES;
	--------------------------------------------------------------------------
	--TABLA_3: TELEFONO_PROVEEDORES
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono) 
	VALUES(1,'5557094130');--PAPELERIA_MESONES
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono)
	VALUES(2,'800 000 8669');--PAPELERIA_TONY
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono)
	VALUES(3,'55 5522 5524');--PAPELERIA_REYNA_DE_MESONES --
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono)
	VALUES(4,'55 2282 3801');--MOBIL_MEX -- 
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono)
	VALUES(4,'553060 8671');--MOBIL_MEX --
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono)
	VALUES(5,'5864 7901');--GRUPO_DIXON
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono)
	VALUES(5,'5864 7949');--GRUPO_DIXON 
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono)
	VALUES(6,'55 5578 7400');--PAPELES 
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono)
	VALUES(7,'55 5393 9008');--Fantasias_Miguel
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono)
	VALUES(8,'55 26999 500');--IMPRESORAS_ANGEL (REFACCIONES)
	INSERT INTO TELEFONO_PROVEEDORES(id_proveedor,telefono)
	VALUES(8,'5630 8850');--IMPRESORAS_ANGEL (REFACCIONES)
	--SELECT * FROM TELEFONO_PROVEEDORES;
	--==============================================================================================================================
	--TABLA_4 PRODUCTOS, CATEGORIA 1: ARTICULOS DE PAPELERIA
	--(PRECIOUNITARIO|CATEGORIA|id_proveedor|codigo_barras|unidades_stock|marca|descripcion)
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',4.5,1,1,'A-0010-Z',100,'Bic','mediano negro');--PLUMAS MEDIANO
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',4.5,1,1,'A-0020-Z',100,'Bic','mediano rojo');
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',4.5,1,1,'A-0030-Z',90,'Bic','mediano azul');
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',4.5,1,1,'A-0040-Z',90,'Bic','mediano verde');

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',5.0,1,1,'A-0010-Y',100,'Bic','fino negro');--PLUMAS FINO
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',5.0,1,1,'A-0020-Y',100,'Bic','fino rojo');
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',5.0,1,1,'A-0030-Y',90,'Bic','fino azul');
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',5.0,1,1,'A-0040-Y',90,'Bic','fino verde');

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',4.5,1,1,'A-0010-X',100,'Bic','diamante negro');--PLUMAS DIAMANTE
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',4.5,1,1,'A-0020-X',100,'Bic','diamante rojo');
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',4.5,1,1,'A-0030-X',100,'Bic','diamante azul');
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Pluma',4.5,1,1,'A-0040-X',100,'Bic','diamante verde');

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz',5.0,1,2,'A-0010-W',100,'Mirado','1/2 a 2');--LÁPICES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz',5.5,1,2,'A-0020-W',100,'Bic','Sólo del 2');
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz',12.0,1,2,'A-0030-W',100,'HB','Dibujo');

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Colores',59,1,3,'A-0010-V',100,'Bic','Evolution-12pzas');--COLORES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Colores',89,1,3,'A-0020-V',100,'Bic','Evolution-24pzas');--COLORES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Colores',65,1,3,'A-0030-V',100,'Faber Castell','Faber-12pzas');--COLORES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Colores',65,1,3,'A-0040-V',100,'Faber Castell','Faber-24pzas');--COLORES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Colores',79,1,3,'A-0050-V',100,'Norma','Norma-12pzas');--COLORES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Colores',109,1,3,'A-0060-V',100,'Norma','Norma-24pzas');--COLORES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Colores',22,1,3,'A-0070-V',100,'Mapita','Mapita-12pzas');--COLORES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Colores',33.50,1,3,'A-0080-V',100,'Mapita','Mapita-24pzas');--COLORES

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',29,1,2,'A-0010-U',100,'Escribe','Escribe_Prof-100-C/CH');--Cuadernos --PROFESIONALES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',29,1,2,'A-0020-U',100,'Escribe','Escribe_Prof-100-C/GDE');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',29,1,2,'A-0030-U',100,'Escribe','Escribe_Prof-100-C/BCO');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',29,1,2,'A-0040-U',100,'Escribe','Escribe_Prof-100-C/RAYA');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',19,1,2,'A-0050-U',100,'Monky','Monky_Prof-100-C/CH');--Cuadernos --PROFESIONALES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',19,1,2,'A-0060-U',100,'Monky','Monky_Prof-100-C/GDE');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',19,1,2,'A-0070-U',100,'Monky','Monky_Prof-100-C/BCO');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',19,1,2,'A-0080-U',100,'Monky','Monky_Prof-100-C/RAYA');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',33,1,2,'A-0090-U',100,'Estrella','Estrella_Prof-100-C/CH');--Cuadernos --PROFESIONALES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',33,1,2,'A-0100-U',100,'Estrella','Estrella_Prof-100-C/GDE');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',33,1,2,'A-0110-U',100,'Estrella','Estrella_Prof-100-C/BCO');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',33,1,2,'A-0120-U',100,'Estrella','Estrella_Prof-100-C/RAYA');--Cuadernos

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',19,1,2,'A-0130-U',100,'Escribe','Escribe_Fran-100-C/CH');--Cuadernos --FRANCESA
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',19,1,2,'A-0140-U',100,'Escribe','Escribe_Fran-100-C/GDE');--Cuadernos 
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',19,1,2,'A-0150-U',100,'Escribe','Escribe_Fran-100-C/BCO');--Cuadernos 
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',19,1,2,'A-0160-U',100,'Escribe','Escribe_Fran-100-C/RAYA');--Cuadernos 
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',15,1,2,'A-0170-U',100,'Monky','Monky_Fran-100-C/CH');--Cuadernos --FRANCESA
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',15,1,2,'A-0180-U',100,'Monky','Monky_Fran-100-C/GDE');--Cuadernos 
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',15,1,2,'A-0190-U',100,'Monky','Monky_Fran-100-C/BCO');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',15,1,2,'A-0200-U',100,'Monky','Monky_Fran-100-C/RAYA');--Cuadernos 
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',17.50,1,2,'A-0210-U',100,'Estrella','Estrella_Fran-100-C/CH');--Cuadernos --FRANCESA
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',17.50,1,2,'A-0220-U',100,'Estrella','Estrella_Fran-100-C/GDE');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',17.50,1,2,'A-0230-U',100,'Estrella','Estrella_Fran-100-C/BCO');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',17.50,1,2,'A-0240-U',100,'Estrella','Estrella_Fran-100-C/RAYA');--Cuadernos

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',14,1,2,'A-0250-U',100,'Escribe','Escribe_Ital-100-C/CH');--Cuadernos --ITALIANA
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',14,1,2,'A-0260-U',100,'Escribe','Escribe_Ital-100-C/GDE');--Cuadernos 
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',14,1,2,'A-0270-U',100,'Escribe','Escribe_Ital-100-C/BCO');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',14,1,2,'A-0280-U',100,'Escribe','Escribe_Ital-100-C/RAYA');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',12,1,2,'A-0290-U',100,'MONKY','Monky_Ital-100-C/CH');--Cuadernos --ITALIANA
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',12,1,2,'A-0300-U',100,'MONKY','Monky_Ital-100-C/GDE');--Cuadernos 
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',12,1,2,'A-0310-U',100,'MONKY','Monky_Ital-100-C/BCO');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',12,1,2,'A-0320-U',100,'MONKY','Monky_Ital-100-C/RAYA');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',16.5,1,2,'A-0330-U',100,'Estrella','Estrella_Ital-100-C/CH');--Cuadernos--ITALIANA
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',16.5,1,2,'A-0340-U',100,'Estrella','Estrella_Ital-100-C/GDE');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',16.5,1,2,'A-0350-U',100,'Estrella','Estrella_Ital-100-C/BCO');--Cuadernos
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cuaderno',16.5,1,2,'A-0360-U',100,'Estrella','Estrella_Ital-100-C/RAYA');--Cuadernos

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cartulina',5.0,1,7,'A-0010-T',50,'NA','Cartulina_BCA');--Cartulina_BCA
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cartulina',6.5,1,7,'A-0020-T',50,'NA','Cartulina_PASTEL');--Cartulina_PASTEL
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cartulina',8.0,1,7,'A-0030-T',50,'NA','Cartulina_NEGRA');--Cartulina_NEGRA
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelBOND',3.0,1,7,'A-0040-T',50,'NA','Bond_C_CH');--PAPEL_BOND_CH
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelBOND',3.0,1,7,'A-0050-T',50,'NA','Bond_C_GDE');--PAPEL_BOND_GDE
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelBOND',3.0,1,7,'A-0060-T',50,'NA','Bond_C_RAYA');--PAPEL_BOND_RAYA
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelBOND',3.0,1,7,'A-0070-T',50,'NA','Bond_C_BCO');--PAPEL_BOND_BCO
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelLustre',4.0,1,7,'A-0080-T',50,'NA','Lustre_colores');--LUSTRE_COLORES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelMetalico',8.0,1,7,'A-0090-T',50,'NA','Papel_metalico_colores');--Papel_metalico_colores
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelAmerica',7.0,1,7,'A-0100-T',50,'NA','Lustre_colores');--LUSTRE_COLORES
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelCascaron',8.0,1,7,'A-0110-T',50,'NA','Papel_cascaron_1/8');--Cascaron 1/8
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelCascaron',16.0,1,7,'A-0120-T',50,'NA','Papel_cascaron_1/4');--Cascaron 1/4
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelCascaron',22.0,1,7,'A-0130-T',50,'NA','Papel_cascaron_1/2');--Cascaron 1/2
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelCascaron',29.0,1,7,'A-0140-T',50,'NA','Papel_cascaron_Entero');--Cascaron Entero
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelCrepe',4.5,1,7,'A-0150-T',50,'NA','Papel_crepe_colores');--Papel_crepe
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelChina',2.0,1,7,'A-0160-T',50,'NA','Papel_china_colores');--Papel_china
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('PapelCraf',12.0,1,7,'A-0170-T',50,'NA','Papel_craf');--Papel_craf

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Juegos_Gemetría',49.0,1,7,'A-0010-S',25,'Barrilito','Compas_regla_transportador_escuadras');--Juego de Geometria _ barrilito
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Juegos_Gemetría',59.0,1,7,'A-0020-S',25,'Maped','Compas_regla_transportador_escuadras');--Juego de Geometria _ maped
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Juegos_Gemetría',19.0,1,7,'A-0030-S',25,'NA','Compas_regla_transportador_escuadras');--Juego de Geometria _marca_libre

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Saca_puntas',8.0,1,5,'A-0040-S',100,'Barrilito','Sacapuntas_sin_contenedor');--sacapuntas_sin_contenedor
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Saca_puntas',14.0,1,5,'A-0050-S',100,'Barrilito','Sacapuntas_con_contenedor');--sacapuntas_con_contenedor
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Saca_puntas',3.0,1,5,'A-0060-S',100,'NA','Sacapuntas_sin_contenedor');--sacapuntas_sin_contenedor_marca_libre
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Saca_puntas_electronico',120.0,1,5,'A-0070-S',100,'Maped','Sacapuntas_electronico_oficina');--sacapuntas_sin_contenedor_carca_libre

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Tijeras_escolares',12.0,1,5,'A-0080-S',100,'Barrilito','Tijeras_escolares');--tijeras_escolares
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Tijeras_oficina',24.0,1,5,'A-0090-S',100,'Barrilito','Tijeras_oficina');--tijeras_oficina

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz_Adhesivo',13.0,1,5,'A-0100-S',100,'Prit','Prit_chico');--Lapiz_Adhesivo
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz_Adhesivo',21.0,1,5,'A-0110-S',80,'Prit','Prit_mediano');--
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz_Adhesivo',31.0,1,5,'A-0120-S',80,'Prit','Prit_grande');--
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz_Adhesivo',9.0,1,5,'A-0130-S',100,'Dixon','Dixon_chico');--Lapiz_Adhesivo
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz_Adhesivo',14.0,1,5,'A-0140-S',100,'Dixon','Dixon_mediano');--
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz_Adhesivo',21,1,5,'A-0150-S',100,'Dixon','Dixon_grande');--
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz_Adhesivo',7.0,1,5,'A-0160-S',100,'foca','foca_chico');--Lapiz_Adhesivo
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz_Adhesivo',12.0,1,5,'A-0170-S',100,'foca','foca_mediano');--
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Lapiz_Adhesivo',17.0,1,5,'A-0180-S',28,'foca','foca_grande');--
	----==============================================================================================================================
	--TABLA 4 PRODUCTOS, CATEGORIA 2: ARTICULOS DE REGALOS 
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Papel_Envoltura',7.0,2,7,'A-0010-R',50,'Dipak','Papel_fantasia_para_envolver');--Papel para envolver
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Moño',1.50,2,7,'A-0020-R',50,'Dipak','Moño_chico');--MOÑOS_CHICO
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Moño',3.50,2,7,'A-0030-R',50,'Dipak','Moño_mediano');--MOÑOS_MEDIANO
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Moño',7.0,2,7,'A-0040-R',50,'Dipak','Moño_grande');--MOÑOS_GRANDE
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Moño',7.0,2,7,'A-0050-R',50,'Dipak','Moño_grande');--MOÑOS_GRANDE

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Cartera',420.00,2,7,'A-0060-R',12,'Tommy','Carteras_diseños_diferentes');--Cartera
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Chocolates',90.00,2,7,'A-0070-R',12,'Turini','Chocolates_forma_corazon_8pzas');--CHOCOLATES_8PZAS_TURINI
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Chocolates',120.00,2,7,'A-0080-R',12,'Ferrero','Ferrero_8pzas');--CHOCOLATES_8PZAS_FERRERO
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Chocolates',290.00,2,7,'A-0090-R',11,'Ferrero','Ferrero_36pzas');--CHOCOLATES_36PZAS_FERRERO
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Chocolates',28.00,2,7,'A-0100-R',12,'Kinder Sorpresa','Huevo_kinder_1pza');--CHOCOLATE_KINDER_SORPRESA
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Monedero',160.00,2,7,'A-0110-R',12,'Mujeres Lindas','Monedero_para_mujer');--MONEDERO_PARA_MUJER
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Oso_Peluche',135.00,2,7,'A-0120-R',8,'Pequeños detalles','Oso_peluche');--Oso Peluche
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Carro_control_remoto',399.00,2,7,'A-0130-R',8,'GPTOYS','Carro_control_remoto');--Carro_control_remoto
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Carro_control_remoto',399.00,2,7,'A-0140-R',8,'GPTOYS','Carro_control_remoto');--Carro_control_remoto

	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Caja_regalo_corazon',40.00,2,7,'A-0150-R',16,'NA','Caja_regalo_50x14cm');--caja_forma_corazon
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Caja_regalo_cubo',30.00,2,7,'A-0160-R',16,'NA','Caja_regalo_mediana_40x40x40cm');--caja_mediana_cubo
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Bolsa_regalo',11.00,2,7,'A-0170-R',16,'NA','Bolsa_regalo_chica');--bolsa_regalo_chica
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Bolsa_regalo_m',17.00,2,7,'A-0180-R',16,'NA','Bolsa_regalo_mediana');--bolsa_regalo_mediana
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Bolsa_regalo_g',25.00,2,7,'A-0190-R',16,'NA','Bolsa_regalo_grande');--bolsa_regalo_mediana
	----==============================================================================================================================
	--TABLA 4 PRODUCTOS, CATEGORIA 3: SERVICIO DE IMPRESIONES 
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Impresion_bn',1.00,3,8,'A-0010-Q',1000000,'NA','impresión_color');--bolsa_regalo_mediana
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Impresion_color',5.00,3,8,'A-0020-Q',1000000,'NA','impresión_sin_color');--bolsa_regalo_mediana
	----==============================================================================================================================
	--TABLA 4 PRODUCTOS, CATEGORIA 4: SERVICIO DE RECARGAS 
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Recarga_celular_30',30.00,4,4,'A-0030-Q',1000000,'NA','Recarga_30');--Recarga de 30
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Recarga_celular_50',50.00,4,4,'A-0040-Q',1000000,'NA','Recarga_50');--Recarga de 50
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Recarga_celular_100',100.00,4,4,'A-0050-Q',1000000,'NA','Recarga_100');--Recarga de 100
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Recarga_celular_150',150.00,4,4,'A-0060-Q',1000000,'NA','Recarga_150');--Recarga de 150
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Recarga_celular_200',200.00,4,4,'A-0070-Q',1000000,'NA','Recarga_200');--Recarga de 200
	INSERT INTO PRODUCTOS(nombre_producto,precio_unitario,id_categoria,id_proveedor,codigo_barras,unidades_stock,marca,descripcion)
	VALUES('Recarga_celular_500',500.00,4,4,'A-0080-Q',1000000,'NA','Recarga_200');--Recarga de 500
	----==============================================================================================================================
	--SELECT * FROM PRODUCTOS
	--TABLA 5 CLIENTES(ATRIBUTO DOMICILIO COMO Estado|C.P.|Col.|Calle y No.|nombre)
	INSERT INTO CLIENTES(razon_social,domicilio,nombre)
	VALUES('ALBERTO ISRAEL CRUZ GALVAN','CDMX,08400,Granjas_Mexico,Canela_193','Alberto_Cruz'); --id_cliente=1
	INSERT INTO CLIENTES(razon_social,domicilio,nombre)
	VALUES('VICTOR ROSALES VELAZQUEZ','CDMX,04600,Pedregal_de_Sta_Ursula,Ursula_626','Victor_Rosales');--id_cliente=2
	INSERT INTO CLIENTES(razon_social,domicilio,nombre)
	VALUES('LUIS ALFONSO BRAVO FLORES','CDMX,06800,Obrera,5_de_febrero_87','Luis_Bravo');--id_cliente=3
	INSERT INTO CLIENTES(razon_social,domicilio,nombre)
	VALUES('ARMANDO NAVARRO OSORIO','CDMX,06800,Cuauhtemoc,Jose_Joaquin_Arriaga_92','Armando_Osorio');--id_cliente=4 --sin correo
	INSERT INTO CLIENTES(razon_social,domicilio,nombre)
	VALUES('ROBERTO ALEJANDRO GONZALEZ LOPEZ','CDMX,15660,Venustiano_Carranza,Cuitlahuac_40','Roberto_Gonzalez');--id_cliente=5
	INSERT INTO CLIENTES(razon_social,domicilio,nombre)
	VALUES('ANGELICA NAKAYAMA CERVANTES','CDMX,11800,Miguel_Hidalgo,AV_José_Marti_187','Angelica_Nakayama');--id_cliente=6
	INSERT INTO CLIENTES(razon_social,domicilio,nombre)
	VALUES('FERNANDO ARREOLA RUIZ','CDMX,14010,Parques_del_Pedregal,Calle_Alborada_55','Fernando_Arreola');--id_cliente=7
	--SELECT * FROM CLIENTES
	----==============================================================================================================================
	--TABLA 6 EMAIL_CLIENTES
	INSERT INTO EMAIL_CLIENTES(id_cliente,email)
	VALUES(1,'albertoicg01@gmail.com');
	INSERT INTO EMAIL_CLIENTES(id_cliente,email)
	VALUES(1,'albertoicg01@outlook.com');
	INSERT INTO EMAIL_CLIENTES(id_cliente,email)
	VALUES(2,'victordaniel.rosalesv@gmail.com');
	INSERT INTO EMAIL_CLIENTES(id_cliente,email)
	VALUES(3,'watanuki0291@gmail.com');
	INSERT INTO EMAIL_CLIENTES(id_cliente,email)
	VALUES(5,'Commodorealexander@gmail.com');
	INSERT INTO EMAIL_CLIENTES(id_cliente,email)
	VALUES(6,'annkym@fi-b.unam.mx');
	INSERT INTO EMAIL_CLIENTES(id_cliente,email)
	VALUES(7,'ferarreola.unam.bd@gmail.com');
	--SELECT * FROM EMAIL_CLIENTES
	--==============================================================================================================================
	--TABLA 7 VENTAS
	--07_05_2020

	INSERT INTO VENTAS(id_venta,id_cliente,fecha_venta)
	VALUES('VENT-001',1,'20200507');--Compra_Alberto_Cruz
	INSERT INTO VENTAS(id_venta,id_cliente,fecha_venta)
	VALUES('VENT-002',2,'20200507');--Compra_Luis_Bravo
	INSERT INTO VENTAS(id_venta,id_cliente,fecha_venta)
	VALUES('VENT-003',3,'20200507');--Compra_Alejandro_Gonzalez
	INSERT INTO VENTAS(id_venta,id_cliente,fecha_venta)
	VALUES('VENT-004',4,'20200507');--Compra_Fernando_Arreola
	INSERT INTO VENTAS(id_venta,id_cliente,fecha_venta)
	VALUES('VENT-005',5,'20200507');--Compra_Fernando_Arreola
	--SELECT * FROM VENTAS
	--==============================================================================================================================
	INSERT INTO VENTA_DETALLES(id_venta,id_producto,precio_unitario,cantidad)
	VALUES('VENT-001',17,89,1); --COMPRÓ COLORES EVOLUTION MARCA BIC DE 89.00 
	INSERT INTO VENTA_DETALLES(id_venta,id_producto,precio_unitario,cantidad)
	VALUES('VENT-002',1,4.5,1); --COMPRÓ UNA PUMA BIC NEGRO DE 4.50
	INSERT INTO VENTA_DETALLES(id_venta,id_producto,precio_unitario,cantidad)
	VALUES('VENT-003',1,4.50,10);--COMPRÓ 10 PLUMAS BIC NEGRO DE 4.50
	INSERT INTO VENTA_DETALLES(id_venta,id_producto,precio_unitario,cantidad)
	VALUES('VENT-004',116,30.0,2);--COMPRÓ 2 RECARGAS DE 30.00 
	INSERT INTO VENTA_DETALLES(id_venta,id_producto,precio_unitario,cantidad)
	VALUES('VENT-005',95,7.0,5);--COMPRÓ 5 PAPELES PARA ENVOLVER DE 7.00 
	--SELECT * FROM VENTA_DETALLES
$$;