package org.example;

import javax.swing.*;
import java.awt.*;
import java.sql.*;

public class Main extends JFrame {

    private JLabel ingresosLabel;
    private JLabel topArticulosLabel;
    private JLabel empleadosLabel;
    private JTextArea ingresosArea;
    private JTextArea topArticulosArea;
    private JTextArea empleadosArea;

    public Main() {
        setTitle("Dashboard - Papelería");
        setSize(600, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new GridLayout(3, 2, 10, 10));

        ingresosLabel = new JLabel("Ingresos del Mes:");
        topArticulosLabel = new JLabel("Top 3 Artículos Más Vendidos:");
        empleadosLabel = new JLabel("Empleados con Más Órdenes:");

        ingresosArea = new JTextArea(5, 20);
        topArticulosArea = new JTextArea(5, 20);
        empleadosArea = new JTextArea(5, 20);

        ingresosArea.setEditable(false);
        topArticulosArea.setEditable(false);
        empleadosArea.setEditable(false);

        add(ingresosLabel);
        add(new JScrollPane(ingresosArea));
        add(topArticulosLabel);
        add(new JScrollPane(topArticulosArea));
        add(empleadosLabel);
        add(new JScrollPane(empleadosArea));

        cargarDatos();

        setVisible(true);
    }

    private void cargarDatos() {
        String url = "jdbc:postgresql://localhost:5432/papeleria";
        String user = "postgres";
        String password = "postgres";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String ingresosQuery = """
                SELECT 
                    COALESCE(SUM(dv.CantidadProducto * p.PrecioCompra), 0) AS Invertido,
                    COALESCE(SUM(dv.PrecioTotalArticulo), 0) AS Ingresos,
                    COALESCE(SUM(dv.PrecioTotalArticulo), 0) - COALESCE(SUM(dv.CantidadProducto * p.PrecioCompra), 0) AS Ganancias
                FROM DetalleVenta dv
                JOIN Productos p ON dv.ProductoID = p.ProductoID
                JOIN Ventas v ON dv.VentaID = v.VentaID
                WHERE EXTRACT(MONTH FROM v.FechaVenta) = EXTRACT(MONTH FROM CURRENT_DATE)
                  AND EXTRACT(YEAR FROM v.FechaVenta) = EXTRACT(YEAR FROM CURRENT_DATE);
            """;
            try (PreparedStatement ps = conn.prepareStatement(ingresosQuery);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double invertido = rs.getDouble("Invertido");
                    double ingresos = rs.getDouble("Ingresos");
                    double ganancias = rs.getDouble("Ganancias");

                    ingresosArea.setText("Invertido: $" + invertido + "\n" +
                            "Ingresos: $" + ingresos + "\n" +
                            "Ganancias: $" + ganancias);
                }
            }

            String topArticulosQuery = """
                SELECT p.Nombre, SUM(dv.CantidadProducto) AS TotalVendidos
                FROM DetalleVenta dv
                JOIN Productos p ON dv.ProductoID = p.ProductoID
                GROUP BY p.Nombre
                ORDER BY TotalVendidos DESC
                LIMIT 3;
            """;
            try (PreparedStatement ps = conn.prepareStatement(topArticulosQuery);
                 ResultSet rs = ps.executeQuery()) {
                StringBuilder topArticulos = new StringBuilder();
                while (rs.next()) {
                    topArticulos.append(rs.getString("Nombre"))
                            .append(": ")
                            .append(rs.getInt("TotalVendidos"))
                            .append(" unidades\n");
                }
                topArticulosArea.setText(topArticulos.toString());
            }

            String empleadosQuery = """
                SELECT e.Nombre || ' ' || e.ApellidoPaterno AS Empleado, COUNT(v.VentaID) AS Ordenes
                FROM Ventas v
                JOIN Empleados e ON v.EmpleadoID = e.EmpleadoID
                GROUP BY e.Nombre, e.ApellidoPaterno
                ORDER BY Ordenes DESC
                LIMIT 3;
            """;
            try (PreparedStatement ps = conn.prepareStatement(empleadosQuery);
                 ResultSet rs = ps.executeQuery()) {
                StringBuilder topEmpleados = new StringBuilder();
                while (rs.next()) {
                    topEmpleados.append(rs.getString("Empleado"))
                            .append(": ")
                            .append(rs.getInt("Ordenes"))
                            .append(" órdenes\n");
                }
                empleadosArea.setText(topEmpleados.toString());
            }

        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error al cargar los datos: " + e.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(Main::new);
    }
}
