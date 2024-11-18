-- ========================================
-- Creación de la vista 'VistaFactura'
-- Esta vista consolida la información necesaria para generar facturas,
-- ========================================

CREATE VIEW VistaFactura AS
SELECT
    -- Datos de la venta
    v.VentaID,                  -- ID único de la venta
    v.Folio,                    -- Folio o número de referencia de la venta
    v.FechaVenta,               -- Fecha en que se realizó la venta
    v.CantidadTotalPagar,       -- Cantidad total a pagar por la venta

    -- Información del empleado que realizó la venta
    e.Nombre AS EmpleadoNombre,             -- Nombre del empleado
    e.ApellidoPaterno AS EmpleadoApellido,  -- Apellido paterno del empleado

    -- Información del cliente
    c.ClienteID,                -- ID único del cliente
    c.Nombre AS ClienteNombre,              -- Nombre del cliente
    c.ApellidoPaterno AS ClienteApellido,   -- Apellido paterno del cliente
    c.RFC AS ClienteRFC,                    -- Registro Federal de Contribuyentes del cliente

    -- Domicilio del cliente
    c.Domicilio_Calle,          -- Calle del domicilio del cliente
    c.Domicilio_Numero,         -- Número exterior del domicilio
    c.Domicilio_Colonia,        -- Colonia del domicilio
    c.Domicilio_CodigoPostal,   -- Código postal del domicilio

    -- Información del producto vendido
    p.ProductoID,               -- ID único del producto
    p.Nombre AS ProductoNombre,             -- Nombre del producto
    p.CodigoBarras,                         -- Código de barras del producto

    -- Detalles de la venta
    dv.CantidadProducto,        -- Cantidad de unidades vendidas del producto
    dv.PrecioTotalArticulo      -- Precio total por el artículo (cantidad * precio unitario)
FROM
    Ventas v
    INNER JOIN Empleados e ON v.EmpleadoID = e.EmpleadoID     -- Relaciona la venta con el empleado
    INNER JOIN DetalleVenta dv ON v.VentaID = dv.VentaID      -- Relaciona la venta con sus detalles
    INNER JOIN Productos p ON dv.ProductoID = p.ProductoID    -- Relaciona los detalles con los productos
    INNER JOIN Clientes c ON dv.ClienteID = c.ClienteID;      -- Relaciona los detalles con los clientes



-- ========================================
-- Ejemplo de consulta utilizando la vista 'VistaFactura'
-- Esta consulta obtiene la información de la factura para la venta con VentaID = 1
SELECT * FROM VistaFactura WHERE VentaID = 1;
-- ========================================
