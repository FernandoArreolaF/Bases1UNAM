-- 1. Tabla PROOVEDOR
CREATE TABLE PROOVEDOR (
    idProovedor SERIAL PRIMARY KEY,
    primNombre VARCHAR(50) NOT NULL,
    segNombre VARCHAR(50) NULL,
    apPat VARCHAR(50) NOT NULL,
    apMat VARCHAR(50) NULL,
    estado VARCHAR(50) NOT NULL,
    colonia VARCHAR(50) NOT NULL,
    calle VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    cp INT NOT NULL,
    razonSocial VARCHAR(250)
);

-- 2. Tabla TELEFONO_PROOVEDOR
CREATE TABLE TELEFONO_PROOVEDOR (
    idProovedor INT,
    telefono VARCHAR(20),
    PRIMARY KEY (idProovedor, telefono),
    CONSTRAINT fk_tel_prov FOREIGN KEY (idProovedor) 
        REFERENCES PROOVEDOR(idProovedor) ON DELETE CASCADE
);

-- 3. Tabla PRODUCTO
CREATE TABLE PRODUCTO (
    codigoBarras VARCHAR(50) PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150),
    marca VARCHAR(50) NOT NULL,
    foto VARCHAR(255),
    stock INT DEFAULT 0,
    fechaCompra DATE NOT NULL,
    precioCompra DECIMAL(10, 2) NOT NULL,
    precioVenta DECIMAL(10, 2) NOT NULL
);

-- 4. Tabla PROVEE_PRODUCTO (Relación entre Proveedor y Producto)
CREATE TABLE PROVEE_PRODUCTO (
    idProovedor INT,
    codigoBarras VARCHAR(50),
    PRIMARY KEY (idProovedor, codigoBarras),
    CONSTRAINT fk_provee_prov FOREIGN KEY (idProovedor) 
        REFERENCES PROOVEDOR(idProovedor) ON DELETE RESTRICT,
    CONSTRAINT fk_provee_prod FOREIGN KEY (codigoBarras) 
        REFERENCES PRODUCTO(codigoBarras) ON DELETE RESTRICT
);

-- 5. Tabla CLIENTE
CREATE TABLE CLIENTE (
    rfc VARCHAR(13) PRIMARY KEY,
    primNombre VARCHAR(50) NOT NULL,
    segNombre VARCHAR(50) NULL,
    apPat VARCHAR(50) NOT NULL,
    apMat VARCHAR(50) NULL,
    estado VARCHAR(50) NOT NULL,
    colonia VARCHAR(50) NOT NULL,
    calle VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    cp INT NOT NULL
);

-- 6. Tabla EMAIL_CLIENTE
CREATE TABLE EMAIL_CLIENTE (
    rfc VARCHAR(13),
    email VARCHAR(50),
    PRIMARY KEY (rfc, email),
    CONSTRAINT fk_email_cte FOREIGN KEY (rfc) 
        REFERENCES CLIENTE(rfc) ON DELETE CASCADE
);

-- 7. Tabla VENTA
CREATE TABLE VENTA (
    numVenta SERIAL PRIMARY KEY,
    rfc VARCHAR(13) NOT NULL,
    fechaVenta DATE DEFAULT CURRENT_DATE,
    totalPago DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_venta_cte FOREIGN KEY (rfc) 
        REFERENCES CLIENTE(rfc) ON DELETE RESTRICT
);

-- 8. Tabla CONTIENE_PRODUCTO (Relación entre Venta y Producto)
CREATE TABLE CONTIENE_PRODUCTO (
    codigoBarras VARCHAR(50),
    numVenta INT,
    cantidad INT NOT NULL,
    importe DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (codigoBarras, numVenta),
    CONSTRAINT fk_contiene_prod FOREIGN KEY (codigoBarras) 
        REFERENCES PRODUCTO(codigoBarras) ON DELETE RESTRICT,
    CONSTRAINT fk_contiene_venta FOREIGN KEY (numVenta) 
        REFERENCES VENTA(numVenta) ON DELETE CASCADE
);