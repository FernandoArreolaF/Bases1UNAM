CREATE INDEX codigoBarras on inventario(codigoBarras);


CREATE OR REPLACE VIEW view_compra_prod AS
SELECT codigobarras AS codigo, 
precioprod AS precio, marca,
descripcionprod AS descripcion,
tipoproducto AS categorias,
stock as inventario FROM producto 
INNER JOIN inventario USING (codigobarras)
INNER JOIN tipoproducto USING(idTipoProd);

CREATE OR REPLACE VIEW view_compra_impr AS
SELECT idImpresion AS id,
TamañoHoja AS tamaño,
TipoImpresion AS impresion,
PrecioServ AS precio,
DescripcionServ AS descripcion
FROM impresion;

CREATE OR REPLACE VIEW view_compra_reca AS
SELECT idRecarga AS id,
Compañia, PrecioRecarga AS precio,
DescripcionServ AS descripcion
FROM recarga;

CREATE OR REPLACE VIEW view_inventario AS
SELECT codigoBarras AS codigo,
precioCompra AS precio_compra, precioprod AS precio_Venta,
(precioprod-precioCompra) AS utilidad,fechaCompra AS fecha_compra,stock AS inventario,
descripcionprod as descripcion
FROM inventario
INNER JOIN producto USING (codigoBarras);

CREATE OR REPLACE VIEW view_proveedor AS
SELECT RazonSocial AS Razon_Social, NombreProv AS nombre,
EstadoProv AS Estado, ColoniaProv AS colonia,
CalleProv AS Calle, CPProv AS Codigo_postal,
NumeroProv AS numero, Telefono FROM proveedor
INNER JOIN telefono USING (RazonSocial);

CREATE OR REPLACE VIEW view_cliente AS
SELECT RFC, NombreCliente AS nombre, EstadoCliente AS Estado,
ColoniaCliente as cliente, CalleCliente AS Calle, CPCliente AS Codigo_postal,
NumeroCliente as numero, email FROM cliente
INNER JOIN email USING (RFC);

CREATE OR REPLACE VIEW view_compra AS
SELECT ('VENT-00'||NoVenta) as venta,
fechaVenta as fecha, cantidadArticulo as cantidad,
precioArticulo as precio,total,
(Compañia||'-'||PrecioRecarga) as recarga ,
(TamañoHoja||'-'||TipoImpresion) as impresion,
(descripcionprod||'-'||marca) as producto
FROM consumo as c
LEFT JOIN impresion as i ON c.idImpresion = i.idImpresion
LEFT JOIN producto as p ON c.codigoBarras = p.codigoBarras
LEFT JOIN recarga as r ON c.idRecarga = r.idRecarga;


CREATE OR REPLACE FUNCTION consumo_trigger_func()
RETURNS trigger AS
$$
    DECLARE
        inv_stock int;
    BEGIN
        SELECT INTO inv_stock stock FROM inventario WHERE codigoBarras = NEW.CodigoBarras;
        IF (inv_stock - NEW.CantidadArticulo <= 0)  THEN
            RAISE EXCEPTION 'No es posible realizar la compra. Sin suficientes articulos en inventario';
        ELSE
            IF (inv_stock - NEW.CantidadArticulo < 3) THEN
                RAISE NOTICE 'Quedan menos de tres articulos en inventario';
            END IF;
            UPDATE inventario set stock=(inventario.stock - NEW.CantidadArticulo) 
            WHERE codigoBarras=NEW.codigoBarras; 
        END IF;
    RETURN NULL;
    END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER consumo_trigger
AFTER INSERT ON consumo
FOR EACH ROW
EXECUTE PROCEDURE consumo_trigger_func();

SELECT * FROM view_compra_impr;
SELECT * FROM view_compra_prod;
SELECT * FROM view_compra_reca;
SELECT * FROM view_inventario;
SELECT * FROM view_proveedor ORDER BY Razon_Social;
SELECT * FROM view_cliente ORDER BY RFC;
SELECT * FROM view_compra;


