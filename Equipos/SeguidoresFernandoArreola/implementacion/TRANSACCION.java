import java.util.Map;

// Clase Transaccion
public class Transaccion implements Runnable {
    private Map<String, Orden> tablaOrden;
    private Orden orden;
    private String operacion;

    public Transaccion(Map<String, Orden> tablaOrden, Orden orden, String operacion) {
        this.tablaOrden = tablaOrden;
        this.orden = orden;
        this.operacion = operacion;
    }

    @Override
    public void run() {
        synchronized (tablaOrden) {
            switch (operacion) {
                case "INSERT":
                    insertarOrden();
                    break;
                case "UPDATE":
                    actualizarOrden();
                    break;
                case "DELETE":
                    eliminarOrden();
                    break;
            }
        }
    }

    private void insertarOrden() {
        if (tablaOrden.containsKey(orden.getFolio())) {
            System.out.println("Error: Folio ya existe");
            return;
        }
        if (!verificarEmpleado(orden.getNumEmpleado())) {
            System.out.println("Error: Empleado no existe");
            return;
        }
        tablaOrden.put(orden.getFolio(), orden);
        System.out.println("Orden insertada: " + orden.getFolio());
    }

    private void actualizarOrden() {
        if (!tablaOrden.containsKey(orden.getFolio())) {
            System.out.println("Error: Folio no existe");
            return;
        }
        if (!verificarEmpleado(orden.getNumEmpleado())) {
            System.out.println("Error: Empleado no existe");
            return;
        }
        tablaOrden.put(orden.getFolio(), orden);
        System.out.println("Orden actualizada: " + orden.getFolio());
    }

    private void eliminarOrden() {
        if (!tablaOrden.containsKey(orden.getFolio())) {
            System.out.println("Error: Folio no existe");
            return;
        }
        tablaOrden.remove(orden.getFolio());
        System.out.println("Orden eliminada: " + orden.getFolio());
    }

    private boolean verificarEmpleado(int numEmpleado) {
        return true; // Aquí asumimos que siempre existe
    }
}
