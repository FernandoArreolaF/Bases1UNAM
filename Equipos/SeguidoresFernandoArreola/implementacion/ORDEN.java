import java.sql.Timestamp;
import java.util.regex.Pattern;

public class Orden {
    private String folio;
    private Timestamp fechaOrden;
    private double total;
    private int numEmpleado;

    // Constructor
    public Orden(String folio, Timestamp fechaOrden, double total, int numEmpleado) {
        if (!Pattern.matches(".*-.*", folio)) {
            throw new IllegalArgumentException("Folio debe tener el formato '%-%'");
        }
        this.folio = folio;
        this.fechaOrden = fechaOrden;
        this.total = total;
        this.numEmpleado = numEmpleado;
    }

    // Getters y setters
    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        if (!Pattern.matches(".*-.*", folio)) {
            throw new IllegalArgumentException("Folio debe tener el formato '%-%'");
        }
        this.folio = folio;
    }

    public Timestamp getFechaOrden() {
        return fechaOrden;
    }

    public void setFechaOrden(Timestamp fechaOrden) {
        this.fechaOrden = fechaOrden;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public int getNumEmpleado() {
        return numEmpleado;
    }

    public void setNumEmpleado(int numEmpleado) {
        this.numEmpleado = numEmpleado;
    }

    @Override
    public String toString() {
        return "Orden{" +
                "folio='" + folio + '\'' +
                ", fechaOrden=" + fechaOrden +
                ", total=" + total +
                ", numEmpleado=" + numEmpleado +
                '}';
    }
}
