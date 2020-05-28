
package modelo;

import java.util.List;
//Dentro del metódo crud usaremos todas las variables para dar mantenimiento
public interface CRUD {
    public List listar();
    public int add(Object[] o); // es un arreglo
    public int actualizar(Object[] o);
    public void eliminar(int id);
}
