
package modelo;

public class Registro {
    
    int reg;
    int idv;
    Double sub;
    Double iva;
    Double total;
    
    public Registro() {
    }

    public Registro(int reg, int idv, Double sub, Double iva, Double total) {
        this.reg = reg;
        this.idv = idv;
        this.sub = sub;
        this.iva = iva;
        this.total = total;
    }

    public int getReg() {
        return reg;
    }

    public void setReg(int reg) {
        this.reg = reg;
    }

    public int getIdv() {
        return idv;
    }

    public void setIdv(int idv) {
        this.idv = idv;
    }

    public Double getSub() {
        return sub;
    }

    public void setSub(Double sub) {
        this.sub = sub;
    }

    public Double getIva() {
        return iva;
    }

    public void setIva(Double iva) {
        this.iva = iva;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }
    
}
