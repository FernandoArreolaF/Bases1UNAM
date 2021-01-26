import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_BD_Mobile/database/database.dart';
import 'package:proyecto_BD_Mobile/widgets/text_field_papeleria_widget.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({Key key}) : super(key: key);

  @override
  _AddClientPageState createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  TextEditingController nombre;
  TextEditingController ap_Pat;
  TextEditingController ap_Mat;
  TextEditingController rz_Social;
  TextEditingController email;
  TextEditingController estado;
  TextEditingController colonia;
  TextEditingController calle;
  TextEditingController numero;
  TextEditingController cp;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    nombre = TextEditingController();
    ap_Pat = TextEditingController();
    ap_Mat = TextEditingController();
    rz_Social = TextEditingController();
    estado = TextEditingController();
    colonia = TextEditingController();
    calle = TextEditingController();
    numero = TextEditingController();
    cp = TextEditingController();
    email = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    nombre.dispose();
    ap_Pat.dispose();
    ap_Mat.dispose();
    rz_Social.dispose();
    estado.dispose();
    colonia.dispose();
    calle.dispose();
    numero.dispose();
    cp.dispose();
    email.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Nuevo Cliente'),
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
                    'Datos Personales',
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: 25,
                    ),
                  ),
                ),
                TextFieldPapeleria(
                  controller: nombre,
                  label: 'Nombre',
                ),
                TextFieldPapeleria(
                  controller: ap_Pat,
                  label: 'Apellido Paterno',
                ),
                TextFieldPapeleria(
                  controller: ap_Mat,
                  label: 'Apellido Materno',
                ),
                TextFieldPapeleria(
                  controller: rz_Social,
                  label: 'Razón Social',
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Datos de Contacto',
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: 25,
                    ),
                  ),
                ),
                TextFieldPapeleria(
                  controller: email,
                  label: 'Email',
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Datos de Domicilio',
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: 25,
                    ),
                  ),
                ),
                TextFieldPapeleria(
                  controller: estado,
                  label: 'Estado',
                ),
                TextFieldPapeleria(
                  controller: colonia,
                  label: 'Colonia',
                ),
                TextFieldPapeleria(
                  controller: calle,
                  label: 'Calle',
                ),
                TextFieldPapeleria(
                  controller: numero,
                  label: 'Numero',
                ),
                TextFieldPapeleria(
                  controller: cp,
                  label: 'Codigo Postal',
                ),
                RaisedButton(
                  onPressed: () async {
                    if (nombre.text != '' &&
                        ap_Pat.text != '' &&
                        ap_Mat.text != '' &&
                        rz_Social.text != '' &&
                        email.text != '' &&
                        estado.text != '' &&
                        colonia.text != '' &&
                        calle.text != '' &&
                        numero.text != '' &&
                        cp.text != '') {
                      var result = await DB.nuevoCliente(
                        nombre.text,
                        ap_Pat.text,
                        ap_Mat.text,
                        rz_Social.text,
                        email.text,
                        estado.text,
                        colonia.text,
                        calle.text,
                        numero.text,
                        cp.text,
                      );

                      showDialog(
                        context: context,
                        builder: (_) => new AlertDialog(
                          title: Text('Registro de Cliente Con Exito'),
                          content: Icon(Icons.person),
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
                    } else {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('Datos Invalidos'),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  },
                  color: Colors.blue,
                  child: Text('Crear'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
