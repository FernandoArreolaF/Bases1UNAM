
package modelo;

public class RV {
     
    int cod;
    int id;
    int ip;
    Double pv;
    int can;
    double tot;
    
    public RV() {
    }

    public RV(int cod, int id, int ip, Double pv, int can, double tot) {
        this.cod = cod;
        this.id = id;
        this.ip = ip;
        this.pv = pv;
        this.can = can;
        this.tot = tot;
    }

    public int getCod() {
        return cod;
    }

    public void setCod(int cod) {
        this.cod = cod;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIp() {
        return ip;
    }

    public void setIp(int ip) {
        this.ip = ip;
    }

    public Double getPv() {
        return pv;
    }

    public void setPv(Double pv) {
        this.pv = pv;
    }

    public int getCan() {
        return can;
    }

    public void setCan(int can) {
        this.can = can;
    }

    public double getTot() {
        return tot;
    }

    public void setTot(double tot) {
        this.tot = tot;
    }
    

    
}
