import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_BD_Mobile/database/database.dart';
import 'package:proyecto_BD_Mobile/models/producto.dart';
import 'package:proyecto_BD_Mobile/widgets/producto_papeleria_widget.dart';
import 'package:proyecto_BD_Mobile/widgets/text_field_papeleria_widget.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({Key key}) : super(key: key);

  @override
  _AddSalePageState createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  TextEditingController nombre_cliente;
  TextEditingController ap_pat_cliente;
  TextEditingController ap_mat_cliente;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    nombre_cliente = TextEditingController(text: DB.current_cliente.nombre);
    ap_pat_cliente = TextEditingController(text: DB.current_cliente.ap_pat);
    ap_mat_cliente = TextEditingController(text: DB.current_cliente.ap_mat);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    nombre_cliente.dispose();
    ap_pat_cliente.dispose();
    ap_mat_cliente.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Nueva Venta'),
      ),
      body: CustomScrollView(
        //este es opcional solo para mover en algun momento las coordenadas del scroll
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Datos del Cliente',
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: 25,
                    ),
                  ),
                ),
                TextFieldPapeleria(
                  controller: nombre_cliente,
                  label: 'Nombre Cliente',
                ),
                TextFieldPapeleria(
                  controller: ap_pat_cliente,
                  label: 'Apellido Paterno',
                ),
                TextFieldPapeleria(
                  controller: ap_mat_cliente,
                  label: 'Apellido Materno',
                ),
                buildColumnProductos(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                    color: Colors.blue[100],
                    child: Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width / 2),
                          child: Text(
                            'Venta Total',
                            style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Text(
                            DB.total_venta(),
                            style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    DB.current_cliente.nombre = this.nombre_cliente.text;
                    DB.current_cliente.ap_pat = this.ap_pat_cliente.text;
                    DB.current_cliente.ap_mat = this.ap_mat_cliente.text;
                    Navigator.of(context).pushReplacementNamed('/AddProduct');
                  },
                  color: Colors.greenAccent[700],
                  child: Text('Añadir Producto'),
                ),
                RaisedButton(
                  onPressed: () async {
                    bool res_getID = await DB.getCliente(
                        this.nombre_cliente.text,
                        this.ap_pat_cliente.text,
                        this.ap_mat_cliente.text);
                    if (!res_getID) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('Datos del Cliente Invalidos'),
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      bool res_create_venta = await DB.createVenta();
                      if (!res_create_venta) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Error al crear la venta'),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        DB.createCompras();
                        showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                            title: Text('Compra realizada con Exito'),
                            content: Icon(Icons.shopping_cart),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Aceptar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .popAndPushNamed('/HomePage');
                                },
                              )
                            ],
                          ),
                        );
                      }
                    }
                  },
                  color: Colors.blue,
                  child: Text('Realizar Venta'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column buildColumnProductos() {
    List<Producto_Papeleria_Desglose> list_Widgets = List();
    for (Producto prod in DB.list_venta_productos) {
      list_Widgets.add(
        Producto_Papeleria_Desglose(
          nombre: prod.nombre,
          precio_Venta: prod.precio_venta,
          onTap: () {},
          cantidad: prod.cantidad.toString(),
        ),
      );
    }
    return Column(
      children: list_Widgets,
    );
  }
}
