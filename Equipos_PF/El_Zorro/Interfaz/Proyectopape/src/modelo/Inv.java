
package modelo;

public class Inv {
     
    int idc;
    int cod;
    int ip;
    Double pc;
    Double pl;
    String fecha;
    int stock;
    public Inv() {
    }

    public Inv(int idc, int cod, int ip, Double pc, Double pl, String fecha, int stock) {
        this.idc = idc;
        this.cod = cod;
        this.ip = ip;
        this.pc = pc;
        this.pl = pl;
        this.fecha = fecha;
        this.stock = stock;
    }

    public int getIdc() {
        return idc;
    }

    public void setIdc(int idc) {
        this.idc = idc;
    }

    public int getCod() {
        return cod;
    }

    public void setCod(int cod) {
        this.cod = cod;
    }

    public int getIp() {
        return ip;
    }

    public void setIp(int ip) {
        this.ip = ip;
    }

    public Double getPc() {
        return pc;
    }

    public void setPc(Double pc) {
        this.pc = pc;
    }

    public Double getPl() {
        return pl;
    }

    public void setPl(Double pl) {
        this.pl = pl;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    
    
}
