
# Caso de estudio: Mueblería
## Analisis de Requerimiento

Consiste en el diseño de una base de datos. Una mueblería quiere digitalizar su forma de operar para evitar tener sus registros de forma física y tener una vista completa de la información de todas sus sucursales, por lo que se plantea el siguiente requerimiento:

## Identificación de Entidades, Atributos y Relaciones. 
Se debe almacenar el `código de barras`, `nombre`, el `precio de venta`, el `precio de compra`, `stock` y `fotografía` de cada ```artículo```, clasificándolos teniendo en cuenta que un artículo sólo pertenece a una ```categoría```. Un artículo puede ser surtido por más de un `proveedor`, manteniendo ```registro de la fecha en la que se comenzó a surtir cada artículo``` y datos como el `rfc`, `razón social`, `dirección`, `teléfono` y `cuenta para pago`. De las `ventas` debe tenerse registro de su `folio`, `fecha`, `monto total`, `monto por artículo`, `cantidad total de artículos`, `cantidad por artículo`, `quién concretó la venta` y `quién la cobró`. Para `facturación` y `programas de lealtad` debe tenerse `registro de datos de clientes`, tales como `rfc`, `nombre`, `razón social`, `dirección`, `email` y `teléfono`. Debe tenerse una visibilidad completa de los `empleados` y el `rol que desempeñan`, por lo que debe asignarse un `número de empleado (irrepetible)` y tener `registro de datos` como el `supervisor directo`, `rfc`, `curp`, `nombre`, `teléfonos`, `dirección`, `email`, su `fecha de ingreso` y `tipo de empleado` (debe ser `cajero`, `vendedor`, `administrativo`, `seguridad` o `limpieza`; `sólo puede ser un tipo`). Respecto a las `sucursales`, debe tenerse conocimiento de su `ubicación`, `teléfono`, `año de fundación` y debe considerarse que un empleado sólo trabaja en una sucursal.

### Entidades y Atributos
    - Artículo:
        Atributos:
            - Código de barras
            - nombre
            - precio de venta
            - precio de compra
            - stock
            - fotografía
            - Categoría
    
    - Proveedor
        - Hist. Proveedor (Registro de la fecha en la que se comenzó a surtir cada artículo)
        Atributos:
            - rfc
            - razón social
            - dirección
            - teléfono
            - cuenta para pago
    
    - Ventas
        Atributos:
            - folio
            - fecha
            - monto total
            - monto por artículo
            - cantidad total de artículos
            - cantidad por artículo
            - quién concreto la venta (empleado_id fk)
            - quién cobró la venta (cliente_id fk)
            
    - Clientes-Ventas (Intersección entre ambos conjuntos)
            - facturación
            - programas de lealtad
    
    - Clientes
        Atributos:
            - rfc
            - nombre
            - razón social
            - dirección
            - email
            - teléfono* (específica sólo 1)
    
    - Empleados
        Atributos:
            - rol que desempeñan
            - tipo de empleado (cajero, vendedor, administrativo, seguridad, limpieza. Sólo uno*)
            - número de empleado (irrepetible)
            - registro de datos*
            - supervisor directo (Opcional en caso de no tener)
            - rfc
            - curp
            - nombre
            - teléfonos
            - dirección
            - email
            - fecha de ingreso
            
    - Sucursales:
        Atributos:
            - ubicación
            - teléfono (1)
            - año de fundación 
        
### Relaciones

    - Artículo-Categoría (1:1): "un artículo sólo pertenece a una categoría"
    - Artículo-Proveedor (1:m ó m:m): "Un artículo puede ser surtido por más de un proveedor"
    - Artículo-Ventas (1:m ó m:m): "Uno o muchos artículos pueden realizar muchas ventas"
    - Clientes-Ventas (1:m ó m:m): "Uno o muchos clientes pueden realizar muchas compras (ventas)"
    - Empleado-Sucursal (1:1): "un empleado sólo trabaja en una sucursal"

#### Adicionalmente, deben cumplirse los siguientes puntos: 

    - Cada que se agregue un artículo a una venta, debe actualizarse los totales (por artículo,
      venta y cantidad de artículos), así como validar que el artículo esté disponible.
    
    - Crear al menos, un índice, del tipo que se prefiera y donde se prefiera.
    
    - Justificar el porqué de la elección en ambos aspectos.
    
    - Lista de artículos no disponibles o con stock < 3. Si el artículo no está disponible, debe aparecer el
      mensaje ”No disponible”.
    
    - De manera automática se genere una vista que contenga información necesaria para asemejarse a un ticket
      de venta, incluyendo un folio para facturación (caracteres aleatorios).
    
    - Al iniciar una venta, debe validarse que el vendedor y el cajero, pertenezcan a la misma sucursal, 
      en caso de que no sea   así, debe mostrarse un mensaje de error.

    - Dado el nombre de un empleado, obtener toda la jerarquía organizacional

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)