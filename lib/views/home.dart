import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/usuario_controller.dart';
import '../models/user_model.dart';
import 'pages/creadores.dart';
import 'pages/perfil.dart';
import 'visitas/visitas_page.dart';
import 'visitas/registrar_visita_page.dart';
import 'pages/listar_centros.dart';
import 'pages/horoscope_screen.dart';
import 'videos/video_list.dart';
import 'noticia/news_list.dart';
import 'weather_screen.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isCollapsed = true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final usuarioController = Provider.of<UsuarioController>(context);
    final user = usuarioController.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minerd Codex'),
        backgroundColor: const Color(0xff0F539C),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            setState(() {
              isCollapsed = !isCollapsed;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Usuario'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Nombre: ${user?.nombre ?? ''}'),
                      Text('Apellido: ${user?.apellido ?? ''}'),
                      Text('Correo: ${user?.correo ?? ''}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cerrar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyLogin()),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 8),
                          Text('Cerrar Sesión'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg-body.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff0F539C), width: 4),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/banner.png',
                      fit: BoxFit.cover,
                    ),
                    const Center(
                      child: Text(
                        "Bienvenido a Minerd Codex",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          backgroundColor: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.3, // Position content below image
              left: 0,
              right: 0,
              bottom: 0,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Card(
                  child: Text(
                    'Educar a la juventud es sembrar el futuro con esperanza y conocimiento, forjando mentes capaces de transformar el mundo con sabiduría y valentía.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff48494a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Positioned(
              left: isCollapsed ? -250 : 0,
              top: 0,
              bottom: 0,
              child: navigationDrawer(user),
            ),
          ],
        ),
      ),
    );
  }

  Widget navigationDrawer(User? user) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xff0F539C),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  if (!isCollapsed)
                    const Stack(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/user.png'),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  if (!isCollapsed) ...[
                    Text(
                      'Nombre: ${user?.nombre ?? ''}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Apellido: ${user?.apellido ?? ''}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Correo: ${user?.correo ?? ''}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ],
              ),
            ),
            if (!isCollapsed)
              Column(
                children: [
                  buildMenuItem(Icons.person, 'Perfil', 0),
                  buildMenuItem(Icons.school, 'Centro Educativos', 1),
                  buildMenuItem(Icons.assignment, 'Visitas', 2),
                  buildMenuItem(Icons.report, 'Reportes Visitas', 3),
                  buildMenuItem(Icons.newspaper, 'Noticias', 4),
                  buildMenuItem(Icons.video_library, 'Videos', 5),
                  buildMenuItem(Icons.group, 'Creadores', 6),
                  const Divider(),
                  buildMenuItem(Icons.stars, 'Horóscopo', 7),
                  buildMenuItem(Icons.wb_sunny, 'Clima', 8),
                  const Divider(),
                  buildMenuItem(Icons.logout, 'Cerrar Sesión', 9),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon,
          color:
              selectedIndex == index ? const Color(0xff66A1DE) : Colors.black),
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onTap: () {
        setState(() {
          selectedIndex = index;
          isCollapsed = true;
        });
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Perfil()));
            break;
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CentroEducativoPage()));
            break;
          case 2:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MisVisitasPage()));
            break;
          case 3:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrarVisitaPage()));
            break;
          case 4:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewsListScreen()));
            break;
          case 5:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VideoListScreen()));
            break;
          case 6:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GroupScreen()));
            break;
          case 7:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HoroscopeScreen()));
          case 8:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WeatherScreen()));
            break;
          case 9:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MyLogin()));
            break;
        }
      },
    );
  }
}
