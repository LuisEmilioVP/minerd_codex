import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/usuario_controller.dart';
import '../models/user_model.dart';
import 'pages/creadores.dart';
import 'pages/perfil.dart';
import 'visitas/visitas_page.dart';
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    // Noticias recientes
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Noticias Recientes",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5, // Número de noticias recientes
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/noticia${index + 1}.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Título de la noticia ${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        'Resumen de la noticia ${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const NoticiaDetalle(),
                                              ),
                                            );
                                          },
                                          child: const Text("Leer más"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
                  buildMenuItem(Icons.info, 'Acerca de la App', 6),
                  buildMenuItem(Icons.group, 'Creadores', 7),
                  const Divider(),
                  buildMenuItem(Icons.logout, 'Cerrar Sesión', 8),
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
            // Navigator.push(context, MaterialPageRoute(builder: (context) => CentroEducativos()));
            break;
          case 2:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MisVisitasPage()));
            break;
          case 3:
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ReportesVisitas()));
            break;
          case 4:
            // Navigator.push(context, MaterialPageRoute(builder: (context) => Noticias()));
            break;
          case 5:
            // Navigator.push(context, MaterialPageRoute(builder: (context) => Videos()));
            break;
          case 6:
            // Navigator.push(context, MaterialPageRoute(builder: (context) => AcercaDe()));
            break;
          case 7:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Creadores()));
            break;
          case 8:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MyLogin()));
            break;
        }
      },
    );
  }
}

class NoticiaDetalle extends StatelessWidget {
  const NoticiaDetalle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle de la Noticia"),
      ),
      body: const Center(
        child: Text("Contenido de la noticia detallada aquí"),
      ),
    );
  }
}
