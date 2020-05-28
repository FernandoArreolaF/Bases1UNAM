package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class INDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    int r=0;
    
      public int actualizarStock(int cant, int idp){
       String sql="update p set Stock=? where IDI=?"; // Consultamos el del producto
       try {
           con=cn.Conectar(); // La clase conexion
           ps=con.prepareStatement(sql);
           ps.setInt(1, cant);
           ps.setInt(2, idp);
           ps.executeUpdate();
       } catch (Exception e) {
       }
       return r;
   }
    
     public Inv listarID(int id){
        Inv p=new Inv();
        String sql="select * from inventario where CB=?";
        try {
            con=cn.Conectar();// Conectamos la base
            ps=con.prepareStatement(sql);// Consultamos con la base de datos
            ps.setInt(1, id);// 1 es la columna de nuestra base datos producto
            rs=ps.executeQuery();
            while (rs.next()) { //Recorremos toda la tabla
                p.setIdc(rs.getInt(1));
                p.setCod(rs.getInt(2));
                p.setIp(rs.getInt(3));
                
                p.setPc(rs.getDouble(4));
                p.setPl(rs.getDouble(5));
               
                p.setFecha(rs.getString(6));
                p.setStock(rs.getInt(7));
                
            }
        } catch (Exception e) {
        }
        return p;//retornamos al objeto producto
    }
    
    public String NroSerieVentas(){
        String serie="";
        String sql="select max(NumeroSerie) from ventas";
        try {
            con=cn.Conectar();// Conectamos
            ps=con.prepareStatement(sql);//Consulta sql
            rs=ps.executeQuery();
            while (rs.next()) {//Recorremos la tabla
                serie=rs.getString(1); //Hacemos referecia a la columna 1 que es  el id de venta
            }
        } catch (Exception e) {
        }
        return serie;
    }
    //Metodo para generar el id ventas
    public String IdVentas(){
        String idv="";
        String sql="select max(IdVentas) from ventas";// Max es para saber el maximo que tenemos en IdVentas
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);
            rs=ps.executeQuery();// Consultamos la base de datos
            while (rs.next()) {
                idv=rs.getString(1);//idventas en la posicion 1
            }
        } catch (Exception e) {
        }
        return idv;//Retornamos el id ventas
    }
    public int GuardarVentas(Inv v){       
        String sql="insert into inventario(CB, IdPro,PreCom,PreVen,Fecha,Stock)values(?,?,?,?,?,?)";
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);//Lo conectamos con la consulta sql
            ps.setInt(1, v.getCod());
            ps.setInt(2, v.getIp());
            ps.setDouble(3, v.getPc());
            ps.setDouble(4, v.getPl());
            ps.setString(5, v.getFecha());
            ps.setInt(6, v.getStock());
            r=ps.executeUpdate();
            
        } catch (Exception e) {
        }
         return r;//Retornamos la respuesta
    }
    //Metodo para guardar detalle ventas
    public int GuardarDetalleVentas(DetalleVentas dv){
        String sql="insert into detalle_ventas(IdVentas,IdProducto,Cantidad,PrecioVenta)values(?,?,?,?)";
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);//Otenemos los datos de la base
            ps.setInt(1, dv.getIdVentas());
            ps.setInt(2, dv.getIdProducto());
            ps.setInt(3, dv.getCantidad());
            ps.setDouble(4, dv.getPreVenta());
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return r;//Retornamos la respuesta
    }
    
    public void eliminar(int id) {
         String sql="delete from inventario where IDI=?";//Recibimos todo el objeto
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
}


