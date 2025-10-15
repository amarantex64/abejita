import 'package:flutter/material.dart';

class NewClientDialog extends StatelessWidget {
  const NewClientDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nuevo cliente")),
      body: Center(child: Text("Hola mundo")),
    );
  }
}