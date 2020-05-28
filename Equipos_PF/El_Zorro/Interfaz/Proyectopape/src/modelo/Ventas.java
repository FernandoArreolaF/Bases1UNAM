
package modelo;

public class Ventas {
    int vn;
    int cl;
    int vendedor;
    String feha;
    
    //Constructor vacio.
    public Ventas() {
    }

    public Ventas(int vn, int cl, int vendedor, String feha) {
        this.vn = vn;
        this.cl = cl;
        this.vendedor = vendedor;
        this.feha = feha;
    }

    public int getVn() {
        return vn;
    }

    public void setVn(int vn) {
        this.vn = vn;
    }

    public int getCl() {
        return cl;
    }

    public void setCl(int cl) {
        this.cl = cl;
    }

    public int getVendedor() {
        return vendedor;
    }

    public void setVendedor(int vendedor) {
        this.vendedor = vendedor;
    }

    public String getFeha() {
        return feha;
    }

    public void setFeha(String feha) {
        this.feha = feha;
    }
    
}
