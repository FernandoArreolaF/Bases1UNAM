import 'package:flutter/material.dart';

class TextFieldPapeleria extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const TextFieldPapeleria({
    Key key,
    this.label,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          counterStyle: TextStyle(
            color: Colors.blue[500],
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}