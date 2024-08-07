import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import '../../controllers/visita_controller.dart';
import '../../controllers/usuario_controller.dart';

class DetalleVisitaPage extends StatefulWidget {
  final String situacionId;

  const DetalleVisitaPage({required this.situacionId, super.key});

  @override
  createState() => _DetalleVisitaPageState();
}

class _DetalleVisitaPageState extends State<DetalleVisitaPage> {
  FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
  String _direccion = '';

  @override
  void initState() {
    super.initState();
    _audioPlayer.openPlayer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDetalleVisita();
    });
  }

  void _fetchDetalleVisita() async {
    final token =
        Provider.of<UsuarioController>(context, listen: false).user?.token;
    if (token != null) {
      try {
        await Provider.of<VisitaController>(context, listen: false)
            .fetchDetalleVisita(token, widget.situacionId)
            .then((_) => _obtenerDireccion());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al obtener detalles de la visita: $e')),
        );
      }
    }
  }

  void _obtenerDireccion() async {
    final visita =
        Provider.of<VisitaController>(context, listen: false).detalleVisita;
    if (visita != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          double.parse(visita.latitud),
          double.parse(visita.longitud),
        );
        if (placemarks.isNotEmpty) {
          setState(() {
            _direccion = placemarks.first.street ?? 'Dirección no encontrada';
          });
        }
      } catch (e) {
        setState(() {
          _direccion = 'Error al obtener la dirección: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visitaController = Provider.of<VisitaController>(context);
    final visita = visitaController.detalleVisita;

    if (visitaController.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (visita == null) {
      return Scaffold(
        body: Center(
            child: Text(visitaController.errorMessage ?? 'Error desconocido')),
      );
    }

    final LatLng position =
        LatLng(double.parse(visita.latitud), double.parse(visita.longitud));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Visita'),
        backgroundColor: const Color(0xFF0F539C), // Color azul
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-body.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Motivo: ${visita.motivo}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Comentario: ${visita.comentario}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Fecha: ${visita.fecha}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Hora: ${visita.hora}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Código del Centro: ${visita.codigoCentro}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Cédula del Director: ${visita.cedulaDirector}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  visita.fotoEvidencia.isNotEmpty
                      ? Image.network(visita.fotoEvidencia)
                      : const SizedBox(),
                  const SizedBox(height: 8),
                  visita.notaVoz.isNotEmpty
                      ? ElevatedButton(
                          onPressed: () async {
                            try {
                              await _audioPlayer.startPlayer(
                                  fromURI: visita.notaVoz);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Error al reproducir nota de voz: $e')),
                              );
                            }
                          },
                          child: const Text('Reproducir Nota de Voz'),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 16),
                  const Text('Ubicación:', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Container(
                    height: 300,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: position,
                        initialZoom: 15.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.your_app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: position,
                              width: 80.0,
                              height: 80.0,
                              child: const Icon(Icons.location_pin,
                                  color: Colors.red, size: 40),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Dirección: $_direccion',
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
