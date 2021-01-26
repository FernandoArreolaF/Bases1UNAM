import 'package:flutter/material.dart';
import 'package:proyecto_BD_Mobile/database/database.dart';
import 'package:proyecto_BD_Mobile/models/producto.dart';
import 'package:proyecto_BD_Mobile/widgets/producto_papeleria_widget.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añade un Producto'),
      ),
      body: FutureBuilder(
        future: DB.getProductos(),
        builder: (context, AsyncSnapshot<List<Producto>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Producto_Papeleria(
                      nombre: snapshot.data[index].nombre,
                      precio_Venta: snapshot.data[index].precio_venta,
                      onTap: () {
                        DB.addListVenta(snapshot.data[index]);
                      });
                },
              ),
            );
          }
        },
      ),
    );
  }
}
