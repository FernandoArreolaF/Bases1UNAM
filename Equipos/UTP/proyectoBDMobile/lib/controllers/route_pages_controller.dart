import 'package:flutter/material.dart';
import 'package:proyecto_BD_Mobile/pages/a%C3%B1adir_producto_venta_page.dart';
import 'package:proyecto_BD_Mobile/pages/nueva_venta.dart';
import 'package:proyecto_BD_Mobile/pages/nuevo_cliente_page.dart';

//Pages Widgets
import 'package:proyecto_BD_Mobile/pages/home_page.dart';

///Metodo que almacena las rutas de la App
class RoutePagesController {
  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      '/HomePage': (context) => MyHomePage(title: 'Papeleria',),
      '/AddClient': (context) => AddClientPage(),
      '/AddSale': (context) => AddSalePage(),
      '/AddProduct': (context) => AddProductPage(),
    };
  }
}
