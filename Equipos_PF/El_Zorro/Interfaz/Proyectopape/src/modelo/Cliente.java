
package modelo;

public class Cliente {
    int id;
    int dni;
    String rs;
    String nombres;
    String edocliente;
    String colcliente;
    String callecliente;
    String cp;
    String email;
    //Constructor vacio.
    public Cliente() {
    }
    //Constructor inicializando nuestras variables.

    
    //Agrego metodos getter and setters

    public Cliente(int id, int dni, String rs, String nombres, String edocliente, String colcliente, String callecliente, String cp, String email) {
        this.id = id;
        this.dni = dni;
        this.rs = rs;
        this.nombres = nombres;
        this.edocliente = edocliente;
        this.colcliente = colcliente;
        this.callecliente = callecliente;
        this.cp = cp;
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public String getRs() {
        return rs;
    }

    public void setRs(String rs) {
        this.rs = rs;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getEdocliente() {
        return edocliente;
    }

    public void setEdocliente(String edocliente) {
        this.edocliente = edocliente;
    }

    public String getColcliente() {
        return colcliente;
    }

    public void setColcliente(String colcliente) {
        this.colcliente = colcliente;
    }

    public String getCallecliente() {
        return callecliente;
    }

    public void setCallecliente(String callecliente) {
        this.callecliente = callecliente;
    }

    public String getCp() {
        return cp;
    }

    public void setCp(String cp) {
        this.cp = cp;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


}