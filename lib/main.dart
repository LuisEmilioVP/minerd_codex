import 'views/home.dart';
import 'views/login.dart';
import 'views/register.dart';
import 'views/pages/perfil.dart';
import 'views/visitas/visitas_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/pages/change_password.dart';
import 'views/pages/recover_password.dart';
import 'views/pages/listar_centros.dart';
import 'views/videos/video_list.dart';
import 'views/noticia/news_list.dart';
import 'views/pages/horoscope_screen.dart';
import 'controllers/usuario_controller.dart';
import 'controllers/visita_controller.dart';
import 'controllers/video_controller.dart';
import 'controllers/centro_educativo_controller.dart';
import 'services/horoscopo/horoscope_provider.dart';
import 'services/noticia/news_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsuarioController()),
        ChangeNotifierProvider(create: (context) => VisitaController()),
        ChangeNotifierProvider(
            create: (context) => CentroEducativoController()),
        ChangeNotifierProvider(create: (context) => VideoController()),
        ChangeNotifierProvider(create: (context) => HoroscopeProvider()),
        ChangeNotifierProvider(create: (context) => NewsProvider()),
      ],
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
          '/recover_password': (context) => const RecoverPasswordPage(),
          '/change_password': (context) => const ChangePasswordPage(),
          '/perfil': (context) => const Perfil(),
          '/listar_centros': (context) => const CentroEducativoPage(),
          '/mis_visitas': (context) => const MisVisitasPage(),
          '/video_list': (context) => const VideoListScreen(),
          '/horoscope_screen': (context) => const HoroscopeScreen(),
          '/news_list': (context) => const NewsListScreen(),
        },
      ),
    );
  }
}
