
package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class VendedorDAO {
    
    //Creamos las variables
    PreparedStatement ps;
    ResultSet rs;    
    
    Conexion acceso=new Conexion();
    Connection con;
    
    public EntidadVendedor ValidarVendedor(String dni,String user){//recibe de parametro dni y user
        EntidadVendedor ev=new EntidadVendedor();
        //"SELECT * FROM vendedor WHERE Dni LIKE? and User LIKE?"
        String sql="select * from vendedor where Dni=? and User=?";//"select * from vendedor where Dni=? and User=?"
        //Dni y User deben las mismas letras a la base datos
        try {
           con=acceso.Conectar();
           ps=con.prepareStatement(sql);//dentro de aqui va nuestra consulta sql
           ps.setString(1, dni);// Ejecutos los parametros que nos envian
           ps.setString(2, user);
           rs=ps.executeQuery();//ejecutamos la consulta
            
            while (rs.next()) {//Buscara dentro de nuestra base de datos
                ev.setId(rs.getInt(1));//ev ..entidad vendedor (1) columna
                ev.setDni(rs.getString(2));//Ponemos todos los datos de la tabla vendedor
                ev.setNom(rs.getString(3));
                ev.setTel(rs.getString(4));
                ev.setEstado(rs.getString(5));
                ev.setUser(rs.getString(6));
            }
        } catch (Exception e) {
        }
        return ev;//retornamos la entidad vendedor
    }
    public Vendedor listarIDs(int id){
        Vendedor p=new Vendedor();
        String sql="select * from vendedor where IdVendedor=?";
        try {
            con=acceso.Conectar();// Conectamos la base
            ps=con.prepareStatement(sql);// Consultamos con la base de datos
            ps.setInt(1, id);// 1 es la columna de nuestra base datos producto
            rs=ps.executeQuery();
            while (rs.next()) { //Recorremos toda la tabla
                
                p.setId(rs.getInt(1));
                p.setDni(rs.getString(2));
                p.setNom(rs.getString(3));
                p.setTel(rs.getString(4));
                p.setEstado(rs.getString(5));
                p.setUser(rs.getString(6));
            }
        } catch (Exception e) {
        }
        return p;//retornamos al objeto producto
    }
    
    
     public Vendedor listarVendedorId(String dni) {
        Vendedor v=new Vendedor();
        String sql = "select * from vendedor where Dni=" + dni;
        try {
            con = acceso.Conectar();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                v.setId(rs.getInt(1));
                v.setDni(rs.getString(2));
                v.setNom(rs.getString(3));
                v.setTel(rs.getString(4));
                v.setEstado(rs.getString(5));
                v.setUser(rs.getString(6));
            }
        } catch (Exception e) {
        }
        return v;
    }
    //********CRUD - Principal**************

    public List listarVendedor() {
        String sql = "select * from vendedor";
        List<Vendedor> listaVendedor = new ArrayList<>();
        try {
            con = acceso.Conectar();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Vendedor ven = new Vendedor();
                ven.setId(rs.getInt(1));
                ven.setDni(rs.getString(2));
                ven.setNom(rs.getString(3));
                ven.setTel(rs.getString(4));
                ven.setEstado(rs.getString(5));
                ven.setUser(rs.getString(6));
                listaVendedor.add(ven);
            }
        } catch (Exception e) {
        }
        return listaVendedor;
    }

    public int agregar(Vendedor v) {
        int r=0;
        String sql = "insert into vendedor(Dni,Nombres,Telefono,Estado,User)values(?,?,?,?,?)";
        try {
            con = acceso.Conectar();
            ps = con.prepareStatement(sql);
            ps.setString(1, v.getDni());
            ps.setString(2, v.getNom());
            ps.setString(3, v.getTel());
            ps.setString(4, v.getEstado());
            ps.setString(5, v.getUser());
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return r;
    }

    public int actualizar(Vendedor v) {
        int r=0;
        String sql = "update vendedor set Dni=?, Nombres=?,Telefono=?,Estado=? Where IdVendedor=?";
        try {
            con = acceso.Conectar();
            ps = con.prepareStatement(sql);
            ps.setString(1, v.getDni());
            ps.setString(2, v.getNom());
            ps.setString(3, v.getTel());
            ps.setString(4, v.getEstado());
            ps.setInt(5, v.getId());
            r = ps.executeUpdate();
            if (r == 1) {
                r = 1;
            } else {
                r = 0;
            }
        } catch (Exception e) {
            System.err.println("" + e);
        }
        return r;
    }

    public int delete(int id) {
        int r=0;
        String sql = "delete from vendedor where IdVendedor=?";
        try {
            con = acceso.Conectar();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return r;
    }
}
