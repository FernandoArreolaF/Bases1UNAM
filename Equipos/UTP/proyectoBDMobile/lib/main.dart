import 'package:flutter/material.dart';
import 'package:proyecto_BD_Mobile/controllers/route_pages_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: RoutePagesController.getRoutes(context),
      initialRoute: '/HomePage',
    );
  }
}
