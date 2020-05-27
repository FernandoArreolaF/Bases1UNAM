//Provedor
package modelo;

public class Proveedor {
    int id;
    String rs;
    String nombres;
    String edo;
    String col;
    String calle;
    String cp;
    String tel;
    
  
    //Constructor vacio.
    public Proveedor() {
    }
    //Constructor inicializando nuestras variables.

    public Proveedor(int id, String rs, String nombres, String edo, String col, String calle, String cp, String tel) {
        this.id = id;
        this.rs = rs;
        this.nombres = nombres;
        this.edo = edo;
        this.col = col;
        this.calle = calle;
        this.cp = cp;
        this.tel = tel;
    }

    //Agrego metodos getter and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getEdo() {
        return edo;
    }

    public void setEdo(String edo) {
        this.edo = edo;
    }

    public String getCol() {
        return col;
    }

    public void setCol(String col) {
        this.col = col;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getCp() {
        return cp;
    }

    public void setCp(String cp) {
        this.cp = cp;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }
    
    

   
}