
package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Conexion {
    
    Connection con;   
    
    public Connection Conectar(){
        try {
            Class.forName("com.mysql.jdbc.Driver");//Hacemos referencia al driver
            //3306 ,el puerto por defecto
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bd_pape","root","");//123456 password de mi phadmin
        } catch (Exception e) {
        }      
        return con;
    }
    
    public void main(String[]args){
      
        Conexion c = new Conexion();
        Connection con = c.Conectar();
        
        try{
            System.out.println("con");
            con.close();
        }catch(SQLException ex){
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
}
