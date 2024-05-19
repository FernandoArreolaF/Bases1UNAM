import java.util.HashMap;
import java.util.Map;
import java.sql.Timestamp;
import java.util.regex.Pattern;
import java.util.Scanner;


public class Main {
    public static void main(String[] args) {
        Map<String, Orden> tablaOrden = new HashMap<>();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            mostrarMenu();

            int opcion = scanner.nextInt();
            scanner.nextLine(); // Consumir el salto de línea

            switch (opcion) {
                case 1:
                    insertarOrden(tablaOrden, scanner);
                    break;
                case 2:
                    seleccionarOrdenes(tablaOrden);
                    break;
                case 3:
                    actualizarOrden(tablaOrden, scanner);
                    break;
                case 4:
                    eliminarOrden(tablaOrden, scanner);
                    break;
                case 5:
                    System.out.println("Saliendo del programa...");
                    return;
                default:
                    System.out.println("Opción no válida.");
            }
        }
    }

    private static void mostrarMenu() {
        System.out.println("\nMenú:");
        System.out.println("1. Insertar orden");
        System.out.println("2. Seleccionar órdenes");
        System.out.println("3. Actualizar orden");
        System.out.println("4. Eliminar orden");
        System.out.println("5. Salir");
        System.out.print("Ingrese una opción: ");
    }

    private static void insertarOrden(Map<String, Orden> tablaOrden, Scanner scanner) {
        System.out.print("Ingrese el folio de la orden: ");
        String folio = scanner.nextLine();

        System.out.print("Ingrese la fecha de la orden (YYYY-MM-DD HH:mm:ss): ");
        Timestamp fechaOrden = Timestamp.valueOf(scanner.nextLine());

        System.out.print("Ingrese el total de la orden: ");
        double total = scanner.nextDouble();

        System.out.print("Ingrese el número de empleado: ");
        int numEmpleado = scanner.nextInt();
        scanner.nextLine(); // Consumir el salto de línea

        Orden orden = new Orden(folio, fechaOrden, total, numEmpleado);
        Transaccion transaccionInsertar = new Transaccion(tablaOrden, orden, "INSERT");
        Thread hiloInsertar = new Thread(transaccionInsertar);
        hiloInsertar.start();

        try {
            hiloInsertar.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    private static void seleccionarOrdenes(Map<String, Orden> tablaOrden) {
        if (tablaOrden.isEmpty()) {
            System.out.println("No hay órdenes registradas.");
            return;
        }

        System.out.println("\nOrdenes:");
        for (Orden orden : tablaOrden.values()) {
            System.out.println(orden);
        }
    }

    private static void actualizarOrden(Map<String, Orden> tablaOrden, Scanner scanner) {
        System.out.print("Ingrese el folio de la orden a actualizar: ");
        String folio = scanner.nextLine();

        if (!tablaOrden.containsKey(folio)) {
            System.out.println("Error: Orden no existe.");
            return;
        }

        Orden orden = tablaOrden.get(folio);

        System.out.print("Ingrese el nuevo total de la orden: ");
        double nuevoTotal = scanner.nextDouble();
        scanner.nextLine();

        orden.setTotal(nuevoTotal);

        Transaccion transaccionActualizar = new Transaccion(tablaOrden, orden, "UPDATE");
        Thread hiloActualizar = new Thread(transaccionActualizar);
        hiloActualizar.start();

        try {
            hiloActualizar.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    private static void eliminarOrden(Map<String, Orden> tablaOrden, Scanner scanner) {
        System.out.print("Ingrese el folio de la orden a eliminar: ");
        String folio = scanner.nextLine();

        if (!tablaOrden.containsKey(folio)) {
            System.out.println("Error: Orden no existe.");
            return;
        }

        Orden orden = tablaOrden.get(folio);

        Transaccion transaccionEliminar = new Transaccion(tablaOrden, orden, "DELETE");
        Thread hiloEliminar = new Thread(transaccionEliminar);
        hiloEliminar.start();

        try {
            hiloEliminar.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
