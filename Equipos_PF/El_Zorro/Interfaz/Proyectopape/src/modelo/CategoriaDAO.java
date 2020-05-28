package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
//Metódo para mantenimiento dentro de nuestra base de datos
public class CategoriaDAO implements CRUD {
    
    Connection con;
    Conexion cn = new Conexion();
    PreparedStatement ps;
    ResultSet rs;
    Proveedor co=new Proveedor();
    int r=0;
    
    //Metódo para uscar al cliente
    public Categoria listarID(int id){// Necesitamos el Dni para buscar al cliente
        Categoria c=new Categoria();
       String sql="select * from categoria where IdCategoria=?";// Buscamos  en la tabla cliente el Dni
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);
            ps.setInt(1, id);
            rs=ps.executeQuery();// ejecutamos la consulta
            
            while (rs.next()) { // Para ir buscando
                
                c.setId(rs.getInt(1));
                
                c.setNombre(rs.getString(2));
                }
        } catch (Exception e) {
        }
        return c;// Retornamos al obejto
    }
    
    

    @Override
    public List listar() {
        List<Categoria> lista = new ArrayList<>();
        String sql = "select * from categoria";//Consulra para cliente
        try {
            con = cn.Conectar();
            ps = con.prepareStatement(sql);//Consulta sql
            rs = ps.executeQuery();//Ejecuta la onsulta
            
            while (rs.next()) {
                Categoria c = new Categoria();
                c.setId(rs.getInt(1));
                
                c.setNombre(rs.getString(2));
                
                lista.add(c);//los agregamos dentro de la lists con e parametro c ...clientes
            }
        } catch (Exception e) {
        }
        return lista;
        
    }

    @Override
    public int add(Object[] o) {
        int r=0;
        String sql = "insert into categoria(NomCategoria)values(?)";
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);//la consulta sql
            ps.setObject(1, o[0]);//Enviamos los datos posicion 0
            
            r=ps.executeUpdate();//actualizar
        } catch (Exception e) {
        }
        return r;
    }

    @Override
    public int actualizar(Object[] o) {
        int r=0;
       String sql="update categoria set NomCategoria=? where IdCategoria=?";
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);
            ps.setObject(1, o[0]);//ps enviamos los datos
            ps.setObject(2, o[1]); //Lleva uno mas
            
            r=ps.executeUpdate();
        } catch (Exception e) {
        }
        return r;// retorna la variable rspuesta
    }

    @Override
    public void eliminar(int id) {
         String sql="delete from categoria where IdCategoria=?";//Recibimos todo el objeto
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);
            ps.setInt(1, id);
            
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    
}
