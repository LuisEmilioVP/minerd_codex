import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/visita_controller.dart';
import '../../controllers/usuario_controller.dart';
import 'registrar_visita_page.dart';
import 'detalle_visita_page.dart';

class MisVisitasPage extends StatefulWidget {
  const MisVisitasPage({super.key});

  @override
  createState() => _MisVisitasPageState();
}

class _MisVisitasPageState extends State<MisVisitasPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token =
          Provider.of<UsuarioController>(context, listen: false).user?.token;
      if (token != null) {
        Provider.of<VisitaController>(context, listen: false)
            .fetchVisitas(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final visitaController = Provider.of<VisitaController>(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg-body.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Mis Visitas',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff0F539C),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: visitaController.loading
            ? const Center(child: CircularProgressIndicator())
            : visitaController.errorMessage != null
                ? Center(child: Text(visitaController.errorMessage!))
                : visitaController.visitas.isEmpty
                    ? const Center(child: Text('No hay visitas registradas'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: visitaController.visitas.length,
                        itemBuilder: (context, index) {
                          final visita = visitaController.visitas[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                                title: Text(
                                  visita.motivo,
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    'Fecha: ${visita.fecha}\nCodigo de Centro: ${visita.codigoCentro}\nComentario: ${visita.comentario}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetalleVisitaPage(
                                        situacionId: visita.id,
                                      ),
                                    ),
                                  );
                                }),
                          );
                        },
                      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegistrarVisitaPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: const Color(0xff0F539C),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
