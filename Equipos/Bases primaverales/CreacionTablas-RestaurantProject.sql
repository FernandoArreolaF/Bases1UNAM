-- Database: tablas_prueba

-- DROP DATABASE tablas_prueba;

--CREATE DATABASE tablas_prueba
    --WITH 
   -- OWNER = postgres
    --ENCODING = 'UTF8'
    --LC_COLLATE = 'Spanish_Mexico.1252'
    --LC_CTYPE = 'Spanish_Mexico.1252'
    --TABLESPACE = pg_default
    --CONNECTION LIMIT = -1;
	-- Database: script_tablas
    --\c "BDRestaurante"


---Creación de tablas 
---tabla empleado 
CREATE TABLE public."empleado" (num_empleado integer NOT NULL, nombre character varying(60) NOT NULL, ap_paterno character varying(60) NOT NULL, ap_materno character varying(60), rfc character varying(13) NOT NULL, fec_nacimiento date NOT NULL, edad smallint NOT NULL, calle character varying(50) NOT NULL, numero smallint NOT NULL, colonia character varying(50) NOT NULL, cp integer NOT NULL, estado character varying(35) NOT NULL, foto bytea  NULL, sueldo numeric(10, 2) NOT NULL, CONSTRAINT empleado_num_empleado_pk PRIMARY KEY (num_empleado));

--Tabla tipo empleado 
CREATE TABLE public."tipo_empleado"(tipo_cocinero boolean NOT NULL,tipo_administrativo boolean NOT NULL,tipo_mesero boolean NOT NULL,num_empleado integer NOT NULL);

--Tabla telefono 
CREATE TABLE public."telefono" (telefono numeric(10,0) NOT NULL, num_empleado integer NOT NULL);

--Tabla dependiente 
CREATE TABLE public."dependiente"(curp character varying(18) NOT NULL,nombre_dep character varying(60) NOT NULL,ap_paterno_dep character varying(60) NOT NULL,ap_materno character varying(60),parentesco_dep character varying(50) NOT NULL,num_empleado integer NOT NULL);

---Tabla administrativo 
CREATE TABLE public."administrativo"(rol character varying(60) NOT NULL,num_empleado integer NOT NULL);

--Tabla cocinero 
CREATE TABLE public."cocinero"(especializacion character varying(100) NOT NULL,num_empleado integer NOT NULL);

--Tabla mesero 
CREATE TABLE public."mesero"(hr_inicio time without time zone NOT NULL,hr_fin time without time zone NOT NULL,num_empleado integer NOT NULL);

---tabla categoria 

CREATE TABLE public."categoria"(id_categoria integer NOT NULL,nombre_categoria character varying(60) NOT NULL,descripcion_categoria character varying(100) NOT NULL,PRIMARY KEY(id_categoria));

---tabla platillo y bebida 
CREATE TABLE public."platilloybebida"(id_platilloybebida integer NOT NULL,nombre_platilloybebida character varying(100) NOT NULL,descripcion character varying(100) NOT NULL,precio_platilloybebida numeric(10,2) NOT NULL,receta character varying(300) NOT NULL,disponibilidad boolean NOT NULL, cantidad_vendido smallint NOT NULL, es_platillo boolean NOT NULL, es_bebida boolean NOT NULL, id_categoria integer NOT NULL,PRIMARY KEY (id_platilloybebida));

---Tabla prepara 
CREATE TABLE public."prepara"(num_empleado integer NOT NULL,id_platilloybebida INTEGER NOT NULL);

---tabla orden
CREATE TABLE public."orden"(id_orden character varying(7) NOT NULL,fec_orden date NOT NULL,precio_total_orden numeric(7, 2) NOT NULL,num_empleado integer NOT NULL,PRIMARY KEY (id_orden));

---tabla cliente 
CREATE TABLE public."cliente"(id_cliente character varying(10) NOT NULL,nombre_cliente character varying(60) NOT NULL,ap_paterno character varying(60) NOT NULL,ap_materno character varying(60),id_orden character varying(7) NOT NULL,PRIMARY KEY (id_cliente));

--tabla factura 
CREATE TABLE public."factura"(rfc character varying(13) NOT NULL,razon_social character varying(50) NOT NULL,calle character varying(50) NOT NULL,colonia character varying(50) NOT NULL,cp smallint NOT NULL,estado character varying(35) NOT NULL,email character varying(150) NOT NULL,fec_nacimiento date NOT NULL,id_cliente character varying(10) NOT NULL,PRIMARY KEY (rfc));

--tabla corresponde 
CREATE TABLE public."corresponde"(id_platilloybebida integer NOT NULL, id_orden character varying(7) NOT NULL,cant_platillo smallint NOT NULL,cant_bebida smallint NOT NULL, precio_total_bebida numeric(10, 2) NOT NULL,precio_total_platillo numeric(10, 2) NOT NULL, PRIMARY KEY(id_platilloybebida, id_orden));

---Agregando restricciones a las tablas -----
--Restricción orden 

ALTER TABLE orden ADD CONSTRAINT orden_num_empleado_fk FOREIGN KEY (num_empleado) REFERENCES public."empleado" (num_empleado) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
--Restricción telefono 
ALTER TABLE telefono ADD CONSTRAINT telefono_num_empleado_fk FOREIGN KEY (num_empleado)REFERENCES public."empleado" (num_empleado)ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
ALTER TABLE telefono ADD CONSTRAINT telefono_tel_num_empleado_pk PRIMARY KEY (telefono, num_empleado);

--Restricción tipo_empleado
ALTER TABLE tipo_empleado ADD CONSTRAINT tipo_empleado_num_empleado_fk FOREIGN KEY (num_empleado)REFERENCES public."empleado" (num_empleado)ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
ALTER TABLE tipo_empleado ADD CONSTRAINT tipo_empleado_id_pk PRIMARY KEY (tipo_cocinero, tipo_administrativo, tipo_mesero, num_empleado);

--Restricción dependiente 
ALTER TABLE dependiente ADD CONSTRAINT dependiente_num_empleado_fk FOREIGN KEY (num_empleado) REFERENCES public."empleado" (num_empleado) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;

---Restricción administrativo 
ALTER TABLE administrativo ADD CONSTRAINT administrativo_num_empleado_fk FOREIGN KEY (num_empleado) REFERENCES public."empleado" (num_empleado) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
ALTER TABLE administrativo ADD CONSTRAINT administrativo_id_pk PRIMARY KEY (num_empleado);

--Restricción cocinero 
ALTER TABLE cocinero ADD CONSTRAINT cocinero_num_empleado_fk FOREIGN KEY (num_empleado) REFERENCES public."empleado" (num_empleado) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;

ALTER TABLE cocinero ADD CONSTRAINT cocinero_id_pk PRIMARY KEY (num_empleado);

--Restricción mesero 
ALTER TABLE mesero ADD CONSTRAINT mesero_num_empleado_fk FOREIGN KEY (num_empleado) REFERENCES public."empleado" (num_empleado) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;

ALTER TABLE mesero ADD CONSTRAINT mesero_id_pk PRIMARY KEY (num_empleado);

--Restricción corresponde 
ALTER TABLE corresponde ADD CONSTRAINT corresponde_id_platilloybebida_fk FOREIGN KEY (id_platilloybebida) REFERENCES public."platilloybebida" (id_platilloybebida) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;

ALTER TABLE corresponde ADD CONSTRAINT corresponde_id_orden_fk FOREIGN KEY (id_orden) REFERENCES public."orden" (id_orden) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;

---Restricción prepara 

ALTER TABLE prepara ADD CONSTRAINT prepara_num_empleado_fk FOREIGN KEY (num_empleado) REFERENCES public."empleado" (num_empleado) 
ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;

ALTER TABLE prepara ADD CONSTRAINT prepara_id_platilloybebida_fk FOREIGN KEY (id_platilloybebida) REFERENCES public."platilloybebida" (id_platilloybebida) 
ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
ALTER TABLE prepara ADD CONSTRAINT prepara_id_pk PRIMARY KEY (num_empleado, id_platilloybebida);

---Restricción platilloybebida 
ALTER TABLE platilloybebida  ADD CONSTRAINT platilloybebida_id_categoria_fk FOREIGN KEY (id_categoria) REFERENCES public."categoria" (id_categoria) 
ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
--agregando precio platillo ybebida
--ALTER TABLE platilloybebida add column precio_platilloybebida numeric(10,2);
--Restricción cliente 
ALTER TABLE cliente ADD CONSTRAINT cliente_id_orden_fk FOREIGN KEY (id_orden) REFERENCES public."orden" (id_orden) 
ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
--Restricción factura 
ALTER TABLE factura ADD CONSTRAINT factura_id_cliente_fk FOREIGN KEY (id_cliente) REFERENCES public."cliente" (id_cliente) 
ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
