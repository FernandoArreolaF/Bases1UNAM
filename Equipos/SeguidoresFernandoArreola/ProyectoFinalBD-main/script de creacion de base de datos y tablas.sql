-- Crear la tabla Empleado
CREATE TABLE Empleado (
    num_empleado SERIAL NOT NULL,  -- Número de empleado como clave primaria
    nom_empleado VARCHAR(50) NOT NULL,  -- Nombre del empleado
    apPat_empleado VARCHAR(50) NOT NULL,  -- Apellido paterno del empleado
    apMat_empleado VARCHAR(50) NULL,  -- Apellido materno del empleado
    fotografia VARCHAR(255) NOT NULL,  -- Fotografía del empleado en formato binario
    calle_empleado VARCHAR(100) NOT NULL,  -- Calle de la dirección del empleado
    numero_empleado SMALLINT NOT NULL,  -- Número de la dirección del empleado
    sueldo INT NOT NULL,  -- Sueldo del empleado
    esAdmin BOOLEAN NOT NULL,  -- Indica si el empleado es administrador
    rol VARCHAR(50) NULL,  -- Rol del empleado
    esCocinero BOOLEAN NOT NULL,  -- Indica si el empleado es cocinero
    especialidad VARCHAR(100) NULL,  -- Especialidad del empleado (si es cocinero)
    esMesero BOOLEAN NOT NULL,  -- Indica si el empleado es mesero
    horario VARCHAR(400) NULL,  -- Horario del empleado
    CONSTRAINT num_empleado_PK PRIMARY KEY (num_empleado)  -- Definición de la clave primaria
);

-- Crear la tabla Cliente
CREATE TABLE Cliente (
    id_cliente SERIAL NOT NULL,  -- ID del cliente como clave primaria
    nombre_clie VARCHAR(50) NOT NULL,  -- Nombre del cliente
    apPat_clie VARCHAR(50) NOT NULL,  -- Apellido paterno del cliente
    apMat_clie VARCHAR(50) NULL,  -- Apellido materno del cliente
    razonSocial VARCHAR(50) NOT NULL,  -- Razón social del cliente
    CONSTRAINT cliente_FK PRIMARY KEY (id_cliente)  -- Definición de la clave primaria
);

-- Crear la tabla Categoria
CREATE TABLE Categoria (
    id_categoria SERIAL NOT NULL,  -- ID de la categoría como clave primaria
    nombre_cat VARCHAR(30) NOT NULL,  -- Nombre de la categoría
    descripcion TEXT NOT NULL,  -- Descripción de la categoría
    CONSTRAINT categoria_PK PRIMARY KEY (id_categoria)  -- Definición de la clave primaria
);

-- Crear la tabla Platillo
CREATE TABLE Platillo (
    id_platillo SERIAL NOT NULL,  -- ID del platillo como clave primaria
    nombre_plat VARCHAR(30) NOT NULL,  -- Nombre del platillo
    receta TEXT NOT NULL,  -- Receta del platillo
    precio DECIMAL(10,2) NOT NULL,  -- Precio del platillo
    descripcion TEXT NOT NULL,  -- Descripción del platillo
    disponibilidad BOOLEAN NOT NULL,  -- Disponibilidad del platillo
    tipo VARCHAR(15) NOT NULL,  -- Tipo de platillo
    id_categoria INT NOT NULL,  -- ID de la categoría a la que pertenece el platillo
    CONSTRAINT platillo_PK PRIMARY KEY (id_platillo),  -- Definición de la clave primaria
    CONSTRAINT platillo_categoria_FK FOREIGN KEY (id_categoria)  -- Definición de la clave foránea
        REFERENCES Categoria (id_categoria) ON DELETE SET NULL ON UPDATE CASCADE
);



-- Crear la tabla Orden
CREATE TABLE Orden (
    folio VARCHAR(255) NOT NULL CHECK (folio LIKE 'ORD-%'),  -- Folio de la orden con restricción de formato
    fecha_orden TIMESTAMP NOT NULL,  -- Fecha de la orden
    total NUMERIC NULL,  -- Total de la orden
    num_empleado INT NOT NULL,  -- Número de empleado que realizó la orden
    CONSTRAINT folio_PK PRIMARY KEY (folio),  -- Definición de la clave primaria
    CONSTRAINT orden_empleado_FK FOREIGN KEY (num_empleado)  -- Definición de la clave foránea
        REFERENCES Empleado (num_empleado) ON DELETE CASCADE ON UPDATE RESTRICT
);

-- Crear la tabla Factura
CREATE TABLE Factura (
    id_factura SERIAL NOT NULL,  -- ID de la factura como clave primaria
    id_cliente INT NOT NULL,  -- ID del cliente asociado a la factura
    folioOrden VARCHAR(255),
    rfc VARCHAR(13) NOT NULL,
    numero_factura INT NOT NULL,  -- Número de la factura
    email VARCHAR(30) NOT NULL,  -- Email del cliente para la factura
    CONSTRAINT factura_cliente_FK FOREIGN KEY (id_cliente)  -- Definición de la clave foránea
        REFERENCES Cliente (id_cliente) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT factura_PK PRIMARY KEY (id_factura, id_cliente),  -- Clave primaria compuesta
    CONSTRAINT unique_id_factura UNIQUE (id_factura),  -- Restricción única en id_factura
    CONSTRAINT factura_orden_PK FOREIGN KEY (folioOrden) 
        REFERENCES Orden(folio) ON DELETE CASCADE ON UPDATE CASCADE 
);

-- Crear la tabla Orden_Platillo
CREATE TABLE Orden_Platillo (
    folio VARCHAR(255) NOT NULL,  -- Folio de la orden (parte de la clave primaria)
    id_platillo INT NOT NULL,  -- ID del platillo (parte de la clave primaria)
    cantidadPorProducto SMALLINT NOT NULL CHECK (cantidadPorProducto > 0),  -- Cantidad del platillo con restricción
    totalPorProducto DECIMAL(10, 2) NOT NULL,  -- Total por producto (será calculado por el trigger)
    CONSTRAINT orden_platillo_orden_FK FOREIGN KEY (folio)  -- Definición de la clave foránea
        REFERENCES Orden (folio) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT orden_platillo_platillo_FK FOREIGN KEY (id_platillo)  -- Definición de la clave foránea
        REFERENCES Platillo (id_platillo) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT orden_platillo_PK PRIMARY KEY (folio, id_platillo)  -- Clave primaria compuesta
);

-- Crear la función de trigger para actualizar totalPorProducto
CREATE OR REPLACE FUNCTION actualizar_totalPorProducto()
RETURNS TRIGGER AS $$
BEGIN
    -- Calcular totalPorProducto multiplicando la cantidad por el precio del platillo
    NEW.totalPorProducto := NEW.cantidadPorProducto * (SELECT precio FROM Platillo WHERE id_platillo = NEW.id_platillo);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger para actualizar totalPorProducto antes de inserciones y actualizaciones
CREATE TRIGGER trigger_actualizar_totalPorProducto
BEFORE INSERT OR UPDATE ON Orden_Platillo
FOR EACH ROW
EXECUTE FUNCTION actualizar_totalPorProducto();

CREATE OR REPLACE FUNCTION actualizar_totalOrden()
RETURNS TRIGGER AS $$
BEGIN
    -- Calcular total sumando el totalPorProducto
    NEW.total := (SELECT SUM(totalPorProducto) FROM Orden_Platillo WHERE folio= NEW.folio);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger para actualizar totalOrden 
CREATE TRIGGER trigger_actualizar_totalOrden
BEFORE INSERT OR UPDATE ON Orden
FOR EACH ROW
EXECUTE FUNCTION actualizar_totalOrden();


-- Crear la tabla rfc_empleado
CREATE TABLE rfc_empleado (
    rfc_empleado VARCHAR(13) NOT NULL,  -- RFC del empleado como clave primaria compuesta
    fechaNac_empleado DATE NOT NULL,  -- Fecha de nacimiento del empleado
    num_empleado INT NOT NULL,  -- Número de empleado asociado
    CONSTRAINT rfc_empleado_empleado_FK FOREIGN KEY (num_empleado)  -- Definición de la clave foránea
        REFERENCES Empleado (num_empleado) ON DELETE CASCADE ON UPDATE RESTRICT,
    CONSTRAINT rfc_empleado_PK PRIMARY KEY (rfc_empleado, num_empleado)  -- Clave primaria compuesta
);

-- Crear la tabla direccion_empleado
CREATE TABLE direccion_empleado (
    cp_empleado VARCHAR(5),  -- Código postal del empleado
    colonia_empleado VARCHAR(100),  -- Colonia del empleado
    edo_empleado VARCHAR(35),  -- Estado del empleado
    num_empleado INT NOT NULL,  -- Número de empleado asociado
    CONSTRAINT direccion_empleado_empleado_FK FOREIGN KEY (num_empleado)  -- Definición de la clave foránea
        REFERENCES Empleado (num_empleado) ON DELETE CASCADE ON UPDATE RESTRICT,
    CONSTRAINT cp_empleado_PK PRIMARY KEY (cp_empleado, num_empleado)  -- Clave primaria compuesta
);

-- Crear la tabla fecha_nacimiento_empleado
CREATE TABLE fecha_nacimiento_empleado (
    fecha_nacimiento DATE NOT NULL,  -- Fecha de nacimiento del empleado
    edad INT NOT NULL,  -- Edad del empleado
    num_empleado INT NOT NULL,  -- Número de empleado asociado
    CONSTRAINT fecha_nac_empleado_FK FOREIGN KEY (num_empleado)  -- Definición de la clave foránea
        REFERENCES Empleado (num_empleado) ON DELETE CASCADE ON UPDATE RESTRICT,
    CONSTRAINT fecha_nacimiento_PK PRIMARY KEY (fecha_nacimiento, num_empleado)  -- Clave primaria compuesta
);

-- Crear la tabla Telefono_Empleado
CREATE TABLE Telefono_Empleado (
    num_empleado INT NOT NULL,  -- Número de empleado asociado
    telefono_empleado VARCHAR(15) NOT NULL,  -- Teléfono del empleado
    CONSTRAINT tel_empleado_FK FOREIGN KEY (num_empleado)  -- Definición de la clave foránea
        REFERENCES Empleado (num_empleado) ON DELETE CASCADE ON UPDATE RESTRICT,
    CONSTRAINT telefono_empleado_PK PRIMARY KEY (telefono_empleado, num_empleado)  -- Clave primaria compuesta
);

-- Crear la tabla Dependiente
CREATE TABLE Dependiente (
    curp_D VARCHAR(18) NOT NULL,  -- CURP del dependiente como clave primaria compuesta
    num_empleado INT NOT NULL,  -- Número de empleado asociado
    nombre_dep VARCHAR(50) NOT NULL,  -- Nombre del dependiente
    apPat_dep VARCHAR(50) NOT NULL,  -- Apellido paterno del dependiente
    apMat_dep VARCHAR(50) NULL,  -- Apellido materno del dependiente
    parentesco VARCHAR(30) NOT NULL,  -- Parentesco del dependiente con el empleado
    CONSTRAINT dependiente_empleado_FK FOREIGN KEY (num_empleado)  -- Definición de la clave foránea
        REFERENCES Empleado (num_empleado) ON DELETE CASCADE ON UPDATE RESTRICT,
    CONSTRAINT dependiente_PK PRIMARY KEY (curp_D, num_empleado)  -- Clave primaria compuesta
);

-- Crear la tabla Direccion_Factura
CREATE TABLE Direccion_Factura (
    cp_factura VARCHAR(5) NOT NULL,  -- Código postal de la factura
    colonia_factura VARCHAR(100) NOT NULL,  -- Colonia de la factura
    edo_factura VARCHAR(35) NOT NULL,  -- Estado de la factura
    calle_factura VARCHAR(100) NOT NULL,  -- Calle de la factura
    id_factura INT NOT NULL,  -- ID de la factura asociada
    id_cliente INT NOT NULL,  -- ID del cliente asociado
    CONSTRAINT direccion_factura_FK FOREIGN KEY (id_factura)  -- Definición de la clave foránea
        REFERENCES Factura (id_factura) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT direccion_factura_cliente_FK FOREIGN KEY (id_cliente)  -- Definición de la clave foránea
        REFERENCES Cliente (id_cliente) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT direccion_factura_PK PRIMARY KEY (cp_factura, id_factura, id_cliente)  -- Clave primaria compuesta
);

-- Crear la tabla Fecha_Nac_Factura
CREATE TABLE Fecha_Nac_Factura (
    fecha_nacimiento DATE NOT NULL,  -- Fecha de nacimiento asociada a la factura
    id_factura INT NOT NULL,  -- ID de la factura asociada
    id_cliente INT NOT NULL,  -- ID del cliente asociado
    CONSTRAINT fecha_nac_factura_FK FOREIGN KEY (id_factura)  -- Definición de la clave foránea
        REFERENCES Factura (id_factura) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fecha_nac_cliente_FK FOREIGN KEY (id_cliente)  -- Definición de la clave foránea
        REFERENCES Cliente (id_cliente) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fecha_nac_factura_PK PRIMARY KEY (fecha_nacimiento, id_factura, id_cliente)  -- Clave primaria compuesta
);

/* INDICE HASH
La columna num_empleado se beneficia de un índice hash si hay consultas frecuentes que buscan empleados por su número de empleado. Dado que este es un campo único y se utiliza como clave primaria, las búsquedas por igualdad serían más eficientes con un índice hash.
Por ejemplo, en la consulta donde se pide filtrar cuanto ordenes y cuanto dinero a cobrado un empleado este índice será de gran ayuda ya que en el where tenemos una igualdad sencilla que usa el id del empleado, del mismo modo tenemos un join que lo involucra. */
CREATE INDEX i_num_empleado ON Empleado USING hash (num_empleado);

