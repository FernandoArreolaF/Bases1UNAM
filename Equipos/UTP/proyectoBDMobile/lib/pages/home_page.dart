import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              message: 'Añade un Cliente',
              icon: Icons.person_add,
              onTap: () {
                Navigator.of(context).pushNamed('/AddClient');
              },
            ),
            Card(
              message: 'Crea una Venta',
              icon: Icons.shopping_bag,
              onTap: () {
                Navigator.of(context).pushNamed('/AddSale');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String message;
  final IconData icon;
  final Function onTap;
  const Card({
    Key key,
    this.message,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        child: InkWell(
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            color: Colors.blue[50],
            child: Row(
              children: [
                Text(
                  this.message,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[700]),
                ),
                Icon(
                  this.icon,
                  color: Colors.blue,
                  size: 50,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
          onTap: this.onTap,
        ),
      ),
    );
  }
}
