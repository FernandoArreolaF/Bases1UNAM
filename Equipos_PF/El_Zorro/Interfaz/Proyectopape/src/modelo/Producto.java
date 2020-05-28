
package modelo;

public class Producto {
    
    int id;
    int idc;
    int ip;
    String marca;
    String descripcion;
    Double precio;
    //Constructor vacio.
    public Producto() {
    }

    public Producto(int id, int idc, int ip, String marca, String descripcion, Double precio) {
        this.id = id;
        this.idc = idc;
        this.ip = ip;
        this.marca = marca;
        this.descripcion = descripcion;
        this.precio = precio;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdc() {
        return idc;
    }

    public void setIdc(int idc) {
        this.idc = idc;
    }

    public int getIp() {
        return ip;
    }

    public void setIp(int ip) {
        this.ip = ip;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }
    
    

   
    
}
