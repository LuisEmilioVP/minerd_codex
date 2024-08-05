import 'package:flutter/material.dart';
import 'about_screen.dart'; // Asegúrate de tener la ruta correcta a tu archivo

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Información del Técnico',
      theme: ThemeData(
        primaryColor: Color(0xFF0F539C),
      ),
      home: AboutScreen(),
    );
  }
}
