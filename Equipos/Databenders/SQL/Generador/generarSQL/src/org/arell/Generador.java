package org.arell;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Generador {
    private final Random random = new Random();

    public List<String> generarSentencias(int cantidadPorTipo) {
        List<String> sentencias = new ArrayList<>();

        for (int i = 1; i <= cantidadPorTipo; i++) {
            sentencias.add(generarInsertPais(i));
            sentencias.add(generarInsertEstado(i));
            sentencias.add(generarInsertProveedor(i));
            sentencias.add(generarInsertEmpleado(i));
            sentencias.add(generarInsertCliente(i));
            sentencias.add(generarInsertCategoria(i));
            sentencias.add(generarInsertProducto(i));
            sentencias.add(generarInsertVenta(i));
        }

        return sentencias;
    }

    private String generarInsertPais(int id) {
        return String.format("INSERT INTO Paises (Nombre) VALUES ('Pais_%d');", id);
    }

    private String generarInsertEstado(int id) {
        int paisId = random.nextInt(100) + 1;
        return String.format("INSERT INTO Estados (Nombre, PaisID) VALUES ('Estado_%d', %d);", id, paisId);
    }

    private String generarInsertProveedor(int id) {
        String rfc = "RFC" + random.nextInt(100000);
        String calle = "Calle_" + id;
        String numero = String.valueOf(random.nextInt(1000));
        String colonia = "Colonia_" + id;
        String codigoPostal = String.format("%05d", random.nextInt(99999));
        int estadoId = random.nextInt(100) + 1;
        return String.format(
                "INSERT INTO Proveedores (RazonSocial, Domicilio_Calle, Domicilio_Numero, Domicilio_Colonia, Domicilio_CodigoPostal, Domicilio_EstadoID, Nombre, RFC) VALUES ('Proveedor_%d', '%s', '%s', '%s', '%s', %d, 'Nombre_%d', '%s');",
                id, calle, numero, colonia, codigoPostal, estadoId, id, rfc);
    }

    private String generarInsertEmpleado(int id) {
        String fechaNacimiento = generarFecha(1970, 2000);
        String fechaIngreso = generarFecha(2010, 2023);
        return String.format(
                "INSERT INTO Empleados (Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, FechaIngreso) VALUES ('Empleado_%d', 'ApellidoP_%d', 'ApellidoM_%d', '%s', '%s');",
                id, id, id, fechaNacimiento, fechaIngreso);
    }

    private String generarInsertCliente(int id) {
        String calle = "Calle_" + id;
        String numero = String.valueOf(random.nextInt(1000));
        String colonia = "Colonia_" + id;
        String codigoPostal = String.format("%05d", random.nextInt(99999));
        int estadoId = random.nextInt(100) + 1;
        String email = "cliente" + id + "@mail.com";
        String rfc = "RFC" + random.nextInt(100000);
        return String.format(
                "INSERT INTO Clientes (Nombre, ApellidoPaterno, ApellidoMaterno, Domicilio_Calle, Domicilio_Numero, Domicilio_Colonia, Domicilio_CodigoPostal, Domicilio_EstadoID, Email, RFC) VALUES ('Cliente_%d', 'ApellidoP_%d', 'ApellidoM_%d', '%s', '%s', '%s', '%s', %d, '%s', '%s');",
                id, id, id, calle, numero, colonia, codigoPostal, estadoId, email, rfc);
    }

    private String generarInsertCategoria(int id) {
        return String.format("INSERT INTO Categorias (Nombre, Descripcion) VALUES ('Categoria_%d', 'Descripcion categoria %d');", id, id);
    }

    private String generarInsertProducto(int id) {
        double precioCompra = 50 + random.nextDouble() * 100;
        double precioVenta = precioCompra + random.nextDouble() * 50;
        int stock = random.nextInt(500);
        int cantidadStock = random.nextInt(50);
        int categoriaId = random.nextInt(100) + 1;
        int proveedorId = random.nextInt(100) + 1;
        return String.format(
                "INSERT INTO Productos (CodigoBarras, Nombre, PrecioCompra, PrecioVenta, Stock, CantidadStock, CategoriaID, ProveedorID) VALUES ('CB%d', 'Producto_%d', %.2f, %.2f, %d, %d, %d, %d);",
                random.nextInt(100000), id, precioCompra, precioVenta, stock, cantidadStock, categoriaId, proveedorId);
    }

    private String generarInsertVenta(int id) {
        String folio = "FOLIO" + id;
        String fechaVenta = generarFecha(2020, 2023);
        double cantidadTotalPagar = random.nextDouble() * 5000 + 100;
        int empleadoId = random.nextInt(100) + 1;
        return String.format(
                "INSERT INTO Ventas (Folio, FechaVenta, CantidadTotalPagar, EmpleadoID) VALUES ('%s', '%s', %.2f, %d);",
                folio, fechaVenta, cantidadTotalPagar, empleadoId);
    }

    private String generarFecha(int anioInicio, int anioFin) {
        int anio = anioInicio + random.nextInt(anioFin - anioInicio + 1);
        int mes = 1 + random.nextInt(12);
        int dia = 1 + random.nextInt(28);
        return String.format("%04d-%02d-%02d", anio, mes, dia);
    }
}
