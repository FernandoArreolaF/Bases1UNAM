import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_BD_Mobile/models/cliente.dart';
import 'package:proyecto_BD_Mobile/models/domicilio_cliente.dart';
import 'package:proyecto_BD_Mobile/models/producto.dart';
import 'package:proyecto_BD_Mobile/util/moneyToDouble.dart';

class DB {
  static int current_id_cliente;
  static String current_id_venta;
  static Cliente current_cliente = Cliente(nombre: '', ap_pat: '', ap_mat: '');
  static List<Producto> list_venta_productos = List();

  static Future<Domiclio_Cliente> nuevoCliente(
    String nombre,
    String ap_pat,
    String ap_mat,
    String rz_social,
    String email,
    String estado,
    String colonia,
    String calle,
    String numero,
    String cp,
  ) async {
    Future.delayed(Duration(seconds: 1));
    var url = 'http://10.0.2.2:3000/cliente/domicilio';
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'nombre': nombre,
          'ap_pat': ap_pat,
          'ap_mat': ap_mat,
          'razon_social': rz_social,
          'email': email,
          'estado': estado,
          'colonia': colonia,
          'calle': calle,
          'numero': numero,
          'cp': cp,
        },
      ),
    );
    var resJson = json.decode(response.body);
    var dom_clt = Domiclio_Cliente(
      id_cliente: resJson['id_cliente'],
      id_domicilio: resJson['id_domicilio'],
      id_domiclio_cliente: resJson['id_domiclio_cliente'],
    );
    DB.current_id_cliente = dom_clt.id_cliente;
    return dom_clt;
  }

  static Future<List<Producto>> getProductos() async {
    await Future.delayed(Duration(seconds: 1));
    List<Producto> list_productos = List();
    var url = 'http://10.0.2.2:3000/producto';

    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var resJson = json.decode(response.body);
    for (int index = 0; index < resJson.length; index++) {
      Map<String, dynamic> productoJson = resJson[index];
      list_productos.add(Producto.fromJson(productoJson));
    }
    return list_productos;
  }

  static bool addListVenta(Producto producto) {
    for (int index = 0; index < list_venta_productos.length; index++) {
      if (list_venta_productos[index].cantidad == 0) {
        list_venta_productos.removeAt(index);
      }
    }
    if (list_venta_productos.length < 3) {
      DB.list_venta_productos.add(producto);
      return true;
    }
    return false;
  }

  static clearListVenta() {
    DB.list_venta_productos.clear();
  }

  static cambiaCantidad({String nombre, int cantidad}) {
    for (int index = 0; index < list_venta_productos.length; index++) {
      if (list_venta_productos[index].nombre == nombre) {
        list_venta_productos[index].cantidad = cantidad;
      }
    }
  }

  static String total_venta() {
    double total = 0;
    for (int index = 0; index < list_venta_productos.length; index++) {
      total += moneyToDouble(list_venta_productos[index].precio_venta) *
          list_venta_productos[index].cantidad;
    }
    return "\$ " + total.toString();
  }

  static Future<bool> getCliente(
      String nombre, String ap_pat, String ap_mat) async {
    var url = 'http://10.0.2.2:3000/cliente/getID';

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'nombre': nombre,
          'ap_pat': ap_pat,
          'ap_mat': ap_mat,
        },
      ),
    );
    var resJson = json.decode(response.body);
    if (resJson.length > 0) {
      DB.current_id_cliente = resJson[0]['id_cliente'];
      return true;
    }
    return false;
  }

  static Future<bool> createVenta() async {
    var url = 'http://10.0.2.2:3000/venta/new';

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, int>{
          'id_cliente': DB.current_id_cliente,
        },
      ),
    );
    var resJson = json.decode(response.body);
    if (resJson.length > 0) {
      DB.current_id_venta = resJson[0]['id_venta'];
      return true;
    }
    return false;
  }

  static Future<bool> createCompras() async {
    var url = 'http://10.0.2.2:3000/compra';

    for (Producto prod in DB.list_venta_productos) {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'id_venta': DB.current_id_venta,
            'cant_art': prod.cantidad,
            'codigo_barras': prod.codigo_barras,
          },
        ),
      );
      DB.clearListVenta();
      DB.current_cliente.nombre = '';
      DB.current_cliente.ap_pat = '';
      DB.current_cliente.ap_mat = '';
      DB.current_id_venta = '';
    }

    return true;
  }
}
