import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/usuario_controller.dart';
import 'views/home.dart';
import 'views/login.dart';
import 'views/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsuarioController(),
      child: MaterialApp(
        title: 'Mi Aplicación',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyLogin(),
        routes: {
          '/home': (context) => const Home(),
          '/login': (context) => const MyLogin(),
          '/register': (context) => const MyRegister(),
        },
      ),
    );
  }
}
