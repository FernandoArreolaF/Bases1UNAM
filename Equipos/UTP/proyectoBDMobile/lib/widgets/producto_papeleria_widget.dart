import 'package:flutter/material.dart';
import 'package:proyecto_BD_Mobile/database/database.dart';
import 'package:proyecto_BD_Mobile/util/moneyToDouble.dart';
import 'package:proyecto_BD_Mobile/widgets/text_field_papeleria_widget.dart';

class Producto_Papeleria extends StatefulWidget {
  final String nombre;
  final String precio_Venta;
  String cantidad;
  final void Function() onTap;

  Producto_Papeleria(
      {Key key, this.nombre, this.precio_Venta, this.onTap, this.cantidad})
      : super(key: key);

  @override
  _Producto_PapeleriaState createState() => _Producto_PapeleriaState();
}

class _Producto_PapeleriaState extends State<Producto_Papeleria> {
  TextEditingController cantidad;

  @override
  void initState() {
    this.cantidad = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    this.cantidad.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            height: 60,
            color: Colors.blue[100],
            child: Row(
              children: [
                Icon(Icons.image),
                Container(
                  width: (MediaQuery.of(context).size.width / 2),
                  child: Text(
                    this.widget.nombre,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  child: Text(
                    this.widget.cantidad == null
                        ? this.widget.precio_Venta
                        : this.widget.cantidad,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => new AlertDialog(
              title: Text('Seleciona la cantidad'),
              content: TextFieldPapeleria(
                controller: this.cantidad,
                label: 'Cantidad',
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    if (cantidad.text != '0' &&
                        cantidad.text != '' &&
                        cantidad.text != null) {
                      widget.onTap();
                      DB.cambiaCantidad(
                        nombre: widget.nombre,
                        cantidad: int.parse(this.cantidad.text),
                      );
                      Navigator.of(context).pop();
                      Navigator.of(context).popAndPushNamed('/AddSale');
                    } else {}
                  },
                )
              ],
            ),
          );
        });
  }
}

class Producto_Papeleria_Desglose extends StatefulWidget {
  final String nombre;
  final String precio_Venta;
  String cantidad;
  final void Function() onTap;

  Producto_Papeleria_Desglose(
      {Key key, this.nombre, this.precio_Venta, this.onTap, this.cantidad})
      : super(key: key);

  @override
  _Producto_Papeleria_DesgloseState createState() =>
      _Producto_Papeleria_DesgloseState();
}

class _Producto_Papeleria_DesgloseState
    extends State<Producto_Papeleria_Desglose> {
  TextEditingController cantidad;

  @override
  void initState() {
    this.cantidad = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    this.cantidad.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            //height:   100,
            color: Colors.blue[100],
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width / 2),
                      child: Text(
                        this.widget.nombre,
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      child: Text(
                        this.widget.cantidad == null
                            ? this.widget.precio_Venta
                            : this.widget.cantidad,
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(),
                    Container(
                      width: (MediaQuery.of(context).size.width / 2),
                      child: Text(
                        'Precio Articulo: ',
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      child: Text(
                        this.widget.precio_Venta,
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(),
                    Container(
                      width: (MediaQuery.of(context).size.width / 2),
                      child: Text(
                        'Total Articulo: ',
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      child: Text(
                        "\$ " + (moneyToDouble(this.widget.precio_Venta)*int.parse(this.widget.cantidad)).toString(),
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => new AlertDialog(
              title: Text('Seleciona la cantidad'),
              content: TextFieldPapeleria(
                controller: this.cantidad,
                label: 'Cantidad',
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    if (cantidad.text != '0' &&
                        cantidad.text != '' &&
                        cantidad.text != null) {
                      widget.onTap();
                      DB.cambiaCantidad(
                        nombre: widget.nombre,
                        cantidad: int.parse(this.cantidad.text),
                      );
                      Navigator.of(context).pop();
                      Navigator.of(context).popAndPushNamed('/AddSale');
                    } else {}
                  },
                )
              ],
            ),
          );
        });
  }
}
