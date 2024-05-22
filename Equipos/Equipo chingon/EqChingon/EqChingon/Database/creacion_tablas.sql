--CREATE DATABASE RESTAURANTE;
-- TABLA EMPLEADO

CREATE TABLE empleado(
    num_emp            SMALLINT             NOT NULL,
    rfc_emp           VARCHAR(13)      NOT NULL,
    nombre_pila_emp   VARCHAR(150)     NOT NULL,
    ap_pat_emp        VARCHAR(150)     NOT NULL,
    ap_mat_emp         VARCHAR(150)     NOT NULL,
    fecha_nac_emp      DATE             NOT NULL,
    foto_emp           BYTEA             NULL,
    edad_emp            INT              NULL,
    estado_emp         VARCHAR(50)      NOT NULL,
    codigo_postal_emp  VARCHAR(5)       NOT NULL,
    colonia_emp       VARCHAR(80)      NOT NULL,
    calle_emp          VARCHAR(150)     NOT NULL,
    num_dom_emp       SMALLINT             NOT NULL,
    sueldo_emp         DECIMAL(8, 2)    NOT NULL,
    cocinero           BOOLEAN  NOT NULL,
    mesero             BOOLEAN  NOT NULL,
    administrativo     BOOLEAN  NOT NULL,
    CONSTRAINT empleado_PK PRIMARY KEY (num_emp)
);

-- TABLA TELEFONO

CREATE TABLE telefono_emp(
    telefono  VARCHAR(8)    NOT NULL,
    num_emp  SMALLINT    NOT NULL,
    CONSTRAINT telefono_emp_PK PRIMARY KEY (telefono),
    CONSTRAINT telefono_empleado_FK FOREIGN KEY (num_emp)
    REFERENCES empleado(num_emp) ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- TABLA ADMINISTRADOR

CREATE TABLE administrativo(
    rol VARCHAR(60)    NOT NULL,
    num_emp_administrativo  SMALLINT      NOT NULL,
    CONSTRAINT administrativo_PK PRIMARY KEY (num_emp_administrativo),
    CONSTRAINT administrativo_empleado_FK FOREIGN KEY(num_emp_administrativo)
    REFERENCES empleado(num_emp) ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- TABLA MESERO

CREATE TABLE mesero(
    horario         VARCHAR(40)    NOT NULL,
    num_emp_mesero  SMALLINT           NOT NULL,
    CONSTRAINT mesero_PK PRIMARY KEY (num_emp_mesero),
    CONSTRAINT mesero_empleado_FK FOREIGN KEY(num_emp_mesero)
    REFERENCES empleado(num_emp) ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- TABLA COCINERO

CREATE TABLE cocinero(
    especialidad      VARCHAR(40)    NOT NULL,
    num_emp_cocinero  SMALLINT           NOT NULL,
    CONSTRAINT cocinero_PK PRIMARY KEY (num_emp_cocinero),
    CONSTRAINT cocinero_empleado_FK FOREIGN KEY(num_emp_cocinero)
    REFERENCES empleado(num_emp) ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- TABLA DEPENDIENTE

CREATE TABLE dependiente(
    curp_dep     VARCHAR(18)     NOT NULL,
    num_emp          SMALLINT            NOT NULL,
    nombre_pila_dep  VARCHAR(150)    NOT NULL,
    ap_pat_dep     VARCHAR(150)    NOT NULL,
    ap_mat_dep       VARCHAR(150)    NOT NULL,
    parentesco       VARCHAR(20)     NOT NULL,
    CONSTRAINT dependiente_PK PRIMARY KEY (curp_dep, num_emp),
    CONSTRAINT dependiente_empleado_FK FOREIGN KEY (num_emp)
    REFERENCES empleado(num_emp) ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- TABLA MENU

CREATE TABLE menu(
    id_prod               SMALLINT            NOT NULL,
    nombre_prod           VARCHAR(80)      NOT NULL,
    receta_prod           TEXT             NOT NULL,
    precio_unitario_prod  DECIMAL(6, 2)    NOT NULL,
    disponibilidad_prod   BOOLEAN          NOT NULL,
    categoria   CHAR(15)          NOT NULL,
    CONSTRAINT menu_PK PRIMARY KEY (id_prod)
);

-- TABLA ENTRANTE

CREATE TABLE entrante(
   id_prod  SMALLINT    NOT NULL,
   CONSTRAINT entrante_PK PRIMARY KEY (id_prod),
   CONSTRAINT entrante_menu_FK FOREIGN KEY (id_prod)
   REFERENCES menu(id_prod) ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- TABLA PLATO PRINCIPAL

CREATE TABLE plato_principal(
   id_prod  SMALLINT    NOT NULL,
   CONSTRAINT plato_principal_PK PRIMARY KEY (id_prod),
   CONSTRAINT plato_principal_menu_FK FOREIGN KEY (id_prod)
   REFERENCES menu(id_prod) ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- TABLA POSTRE

CREATE TABLE postre(
   id_prod  SMALLINT    NOT NULL,
   CONSTRAINT postre_PK PRIMARY KEY (id_prod),
   CONSTRAINT postre_menu_FK FOREIGN KEY (id_prod)
   REFERENCES menu(id_prod) ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- TABLA BEBIDA

CREATE TABLE bebida(
   id_prod  SMALLINT    NOT NULL,
   CONSTRAINT bebida_PK PRIMARY KEY (id_prod),
   CONSTRAINT bebida_menu_FK FOREIGN KEY (id_prod)
   REFERENCES menu(id_prod) ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- TABLA ORDEN

CREATE TABLE orden(
    folio_orden             VARCHAR(8)       NOT NULL,
    total_orden         DECIMAL(8, 2)    NULL,
    fecha_orden             TIMESTAMP        NOT NULL,
    num_emp_administrativo  SMALLINT             NOT NULL,
    num_emp_mesero         SMALLINT             NOT NULL,
    CONSTRAINT orden_PK PRIMARY KEY (folio_orden),
    CONSTRAINT orden_administrativo_FK FOREIGN KEY (num_emp_administrativo)
    REFERENCES administrativo(num_emp_administrativo) ON DELETE RESTRICT
    ON UPDATE CASCADE,
    CONSTRAINT orden_mesero_FK FOREIGN KEY (num_emp_mesero)
    REFERENCES mesero(num_emp_mesero) ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- TABLA CONTIENE

CREATE TABLE contiene(
    id_prod                SMALLINT             NOT NULL,
    folio_orden           VARCHAR(8)       NOT NULL,
    cantidad_prod          SMALLINT             NOT NULL,
    precio_total_prod  DECIMAL(8, 2)         NULL,
    CONSTRAINT contiene_PK PRIMARY KEY (id_prod, folio_orden),
    CONSTRAINT contiene_menu_FK FOREIGN KEY (id_prod)
    REFERENCES menu(id_prod) ON DELETE RESTRICT
    ON UPDATE CASCADE,
    CONSTRAINT contiene_orden_FK FOREIGN KEY (folio_orden)
    REFERENCES orden(folio_orden) ON DELETE RESTRICT
    ON UPDATE CASCADE
);
-- TABLA FACTURA

CREATE TABLE factura(
    rfc_cli        VARCHAR(13)     NOT NULL,
    folio_orden        VARCHAR(8)      NOT NULL,
    nombre_pila_cli    VARCHAR(150)    NOT NULL,
    ap_pat_cli         VARCHAR(150)    NOT NULL,
    ap_mat_cli         VARCHAR(150)    NOT NULL,
    estado_cli         VARCHAR(50)     NOT NULL,
    codigo_postal_cli  VARCHAR(5)      NOT NULL,
    colonia_cli        VARCHAR(80)     NOT NULL,
    calle_cli          VARCHAR(50)     NOT NULL,
    num_dom_cli        SMALLINT            NOT NULL,
    razon_social_cli   VARCHAR(60)     NOT NULL,
    email_cli          VARCHAR(100)    NOT NULL,
    fecha_nac_cli      DATE            NOT NULL,
    CONSTRAINT factura_PK PRIMARY KEY (rfc_cli, folio_orden),
    CONSTRAINT factura_orden_FK FOREIGN KEY (folio_orden)
    REFERENCES orden(folio_orden) ON DELETE RESTRICT
    ON UPDATE CASCADE
);
