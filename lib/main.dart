import 'package:flutter/material.dart';
import 'group_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Información del Grupo',
      theme: ThemeData(
        primaryColor: Color(0xFF0F539C),
      ),
      home: GroupScreen(),
    );
  }
}
