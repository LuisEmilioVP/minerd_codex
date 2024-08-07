import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/centro_educativo_controller.dart';

class CentroEducativoPage extends StatefulWidget {
  const CentroEducativoPage({super.key});

  @override
  createState() => _CentroEducativoPageState();
}

class _CentroEducativoPageState extends State<CentroEducativoPage> {
  final TextEditingController _regionalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller =
        Provider.of<CentroEducativoController>(context, listen: false);
    controller.fetchInitialCentros();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CentroEducativoController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Centros Educativos'),
        backgroundColor: const Color(0xff0F539C),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/listarcentros.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _regionalController,
                  decoration: InputDecoration(
                    labelText: 'Buscar por regional',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.fetchCentros(
                            regional: _regionalController.text);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: controller.loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: controller.centros.length,
                        itemBuilder: (context, index) {
                          final centro = controller.centros[index];
                          return Card(
                            child: ListTile(
                              title: Text(centro.nombre),
                              subtitle: Text(
                                'Código: ${centro.codigo}\nDistrito: ${centro.distrito}\nRegional: ${centro.regional}\nMunicipio: ${centro.dDmunicipal ?? 'No definido'}',
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
