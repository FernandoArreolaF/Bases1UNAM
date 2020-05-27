package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
//Metódo para mantenimiento dentro de nuestra base de datos
public class listar implements CRUD {
     
    Connection con;
     
    Conexion cn = new Conexion();
    PreparedStatement ps;
    ResultSet rs;
    Cliente co=new Cliente();
    int r=0;
    
    //Metódo para uscar al cliente
    public Cliente listarID(String dni){// Necesitamos el Dni para buscar al cliente
        Cliente c=new Cliente();
       String sql="select * from cliente where Dni=?";// Buscamos  en la tabla cliente el Dni
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);
            ps.setString(1, dni);
           
            rs=ps.executeQuery();// ejecutamos la consulta
            while (rs.next()) { // Para ir buscando
                
                c.setId(rs.getInt(1));
                c.setDni(rs.getInt(2));
                c.setRs(rs.getString(3));
                c.setNombres(rs.getString(4));
                c.setEdocliente(rs.getString(5));
                c.setColcliente(rs.getString(6));
                c.setCallecliente(rs.getString(7));
                c.setCp(rs.getString(8));
                c.setEmail(rs.getString(9));
                
            }
        } catch (Exception e) {
        }
        return c;// Retornamos al obejto
    }
    
    public Vendedor listarIDs(int id){// Necesitamos el Dni para buscar al cliente
        Vendedor c=new Vendedor();
       String sql="select * from vendedor where IdVendedor=?";// Buscamos  en la tabla cliente el Dni
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);
            ps.setInt(1, id);
           
            rs=ps.executeQuery();// ejecutamos la consulta
            while (rs.next()) { // Para ir buscando
                
                c.setId(rs.getInt(1));
                c.setDni(rs.getString(2));
                c.setNom(rs.getString(3));
                c.setTel(rs.getString(4));
                c.setEstado(rs.getString(5));
                c.setUser(rs.getString(6));
                
                
            }
        } catch (Exception e) {
        }
        return c;// Retornamos al obejto
    }
    
    
    
    
    //Metodo para generar el id vendedor
    public String IdCliente(){
        String idv="";
        String sql="select max(IdCliente) from cliente";// Max es para saber el maximo que tenemos en IdClientes
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
    
    
    
    //Metodos de Mantenimiento CRUD
    @Override
    public List listar() {
        List<Cliente> lista = new ArrayList<>();
        String sql = "select * from cliente";//Consulra para cliente
        try {
            con = cn.Conectar();
            ps = con.prepareStatement(sql);//Consulta sql
            rs = ps.executeQuery();//Ejecuta la onsulta
            while (rs.next()) {
                Cliente c = new Cliente();
                c.setId(rs.getInt(1));
                c.setDni(rs.getInt(2));
                c.setRs(rs.getString(3));
                c.setNombres(rs.getString(4));
                c.setEdocliente(rs.getString(5));
                c.setColcliente(rs.getString(6));
                c.setCallecliente(rs.getString(7));
                c.setCp(rs.getString(8));
                c.setEmail(rs.getString(9));
                lista.add(c);//los agregamos dentro de la lists con e parametro c ...clientes
            }
        } catch (Exception e) {
        }
        return lista;
    }
    
   //Metodo para guardar detalle ventas
    public int GuardarDetalleEmail(Email dv){
        String sql="insert into email(Email,IdCliente)values(?,?)";
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);//Otenemos los datos de la base
            ps.setString(1, dv.getEmail());
            ps.setInt(2, dv.getId());
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return r;//Retornamos la respuesta
    }

    @Override
    public int add(Object[] o) {   //[] es un arreglo
        int r=0;
        String sql = "insert into cliente(Dni,Rs,Nombres,EdoCliente,ColCliente,CalleCliente,CpCliente,EmailCliente)values(?,?,?,?,?,?,?,?)";
        //String sql = "insert into producto(IdCategoria,IdProv,Marca,Descripcion,Precio)values(?,?,?,?,?)";
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);//la consulta sql
            ps.setObject(1, o[0]);//Enviamos los datos posicion 0
            ps.setObject(2, o[1]);
            ps.setObject(3, o[2]);
            ps.setObject(4, o[3]);
            ps.setObject(5, o[4]);
            ps.setObject(6, o[5]);
            ps.setObject(7, o[6]);
            ps.setObject(8, o[7]);
            r=ps.executeUpdate();//actualizar
        } catch (Exception e) {
        }
        return r;
    }

    @Override
    public int actualizar(Object[] o) {
        int r=0;
       String sql="update cliente set Dni=?,Rs=?,Nombres=?,EdoCliente=?,ColCliente=?,CalleCliente=?,CpCliente=?,EmailCliente=? where IdCliente=?";//IdCliente=? ,que cliente borraremos
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);
            ps.setObject(1, o[0]);//ps enviamos los datos
            ps.setObject(2, o[1]);
            ps.setObject(3, o[2]);
            ps.setObject(4, o[3]);
            ps.setObject(5, o[4]);
            ps.setObject(6, o[5]);
            ps.setObject(7, o[6]);
            ps.setObject(8, o[7]);
            ps.setObject(9, o[8]);
            r=ps.executeUpdate();
        } catch (Exception e) {
        }
        return r;// retorna la variable rspuesta
    }

    @Override
    public void eliminar(int id) {
        String sql="delete from cliente where IdCliente=?";//Recibimos todo el objeto
        try {
            con=cn.Conectar();
            ps=con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

}
