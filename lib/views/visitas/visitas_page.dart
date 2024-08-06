import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/visita_controller.dart';
import '../../controllers/usuario_controller.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Visitas'),
      ),
      body: visitaController.loading
          ? const Center(child: CircularProgressIndicator())
          : visitaController.errorMessage != null
              ? Center(child: Text(visitaController.errorMessage!))
              : visitaController.visitas.isEmpty
                  ? const Center(child: Text('No hay visitas registradas'))
                  : ListView.builder(
                      itemCount: visitaController.visitas.length,
                      itemBuilder: (context, index) {
                        final visita = visitaController.visitas[index];
                        return Card(
                          child: ListTile(
                            title: Text(visita.motivo),
                            subtitle: Text(
                                'Fecha: ${visita.fecha}\nComentario: ${visita.comentario}'),
                          ),
                        );
                      },
                    ),
    );
  }
}
