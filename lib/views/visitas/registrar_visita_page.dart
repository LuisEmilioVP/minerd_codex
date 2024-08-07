import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../controllers/visita_controller.dart';
import '../../controllers/usuario_controller.dart';
import '../../models/visita_model.dart';

class RegistrarVisitaPage extends StatefulWidget {
  const RegistrarVisitaPage({super.key});

  @override
  createState() => _RegistrarVisitaPageState();
}

class _RegistrarVisitaPageState extends State<RegistrarVisitaPage> {
  TextEditingController cedulaDirectorController = TextEditingController();
  TextEditingController codigoCentroController = TextEditingController();
  TextEditingController motivoController = TextEditingController();
  TextEditingController comentarioController = TextEditingController();
  TextEditingController latitudController = TextEditingController();
  TextEditingController longitudController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();
  String? fotoEvidencia;
  String? notaVoz;

  final ImagePicker _picker = ImagePicker();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool isRecording = false;
  String? filePath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    try {
      await _recorder.openRecorder();
    } catch (e) {
      print('Error al inicializar el grabador: $e');
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        fotoEvidencia = pickedFile.path;
      });
    }
  }

  Future<void> _recordAudio() async {
    final permissionStatus = await Permission.microphone.request();
    if (permissionStatus.isGranted) {
      if (isRecording) {
        await _recorder.stopRecorder();
        setState(() {
          isRecording = false;
          notaVoz = filePath;
        });
      } else {
        final directory = await getApplicationDocumentsDirectory();
        filePath =
            '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac';
        await _recorder.startRecorder(
          toFile: filePath!,
          codec: Codec.aacMP4,
        );
        setState(() {
          isRecording = true;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de micrófono denegado')),
      );
    }
  }

  void _handleSubmit() async {
    final usuarioController =
        Provider.of<UsuarioController>(context, listen: false);
    final visitaController =
        Provider.of<VisitaController>(context, listen: false);

    final token = usuarioController.user?.token;
    if (token != null) {
      final visita = Visita(
        id: '',
        fecha: fechaController.text,
        hora: horaController.text,
        motivo: motivoController.text,
        comentario: comentarioController.text,
        fotoEvidencia: fotoEvidencia ?? '',
        notaVoz: notaVoz ?? '',
        latitud: latitudController.text,
        longitud: longitudController.text,
        codigoCentro: codigoCentroController.text,
        cedulaDirector: cedulaDirectorController.text,
      );

      await visitaController.registrarVisita(visita, token);

      final successMessage = visitaController.successMessage;
      final errorMessage = visitaController.errorMessage;
      if (successMessage != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(successMessage)));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage!)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final visitaController = Provider.of<VisitaController>(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Registrar Visita'),
          backgroundColor: const Color(0xff0F539C),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: visitaController.loading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 35, top: 130),
                    child: const Text(
                      'Registrar Visita',
                      style: TextStyle(color: Colors.white, fontSize: 33),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 35, right: 35),
                            child: Column(
                              children: [
                                TextField(
                                  controller: cedulaDirectorController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Cédula del Director",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextField(
                                  controller: codigoCentroController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Código del Centro",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextField(
                                  controller: motivoController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Motivo",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextField(
                                  controller: comentarioController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Comentario",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextField(
                                  controller: latitudController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Latitud",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextField(
                                  controller: longitudController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Longitud",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextField(
                                  controller: fechaController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Fecha",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextField(
                                  controller: horaController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Hora",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                ElevatedButton(
                                  onPressed: _pickImage,
                                  child:
                                      const Text('Seleccionar Foto Evidencia'),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: _recordAudio,
                                  child: Text(isRecording
                                      ? 'Detener Grabación'
                                      : 'Grabar Nota de Voz'),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _handleSubmit,
                                  child: const Text('Registrar Visita'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
