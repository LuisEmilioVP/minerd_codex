import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/visita_model.dart';

class VisitaService {
  final String baseUrl = 'https://adamix.net/minerd/def';
  final String registerUrl = "https://adamix.net/minerd/minerd";

  Future<List<Visita>> fetchVisitas(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/situaciones.php'),
      body: {'token': token},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['exito']) {
        final List<dynamic> data = jsonResponse['datos'];
        return data.map((item) => Visita.fromJson(item)).toList();
      } else {
        throw Exception(jsonResponse['mensaje']);
      }
    } else {
      throw Exception('Fallo al conectar con la API');
    }
  }

  Future<Map<String, dynamic>> registrarVisita(
      Visita visita, String token) async {
    final response = await http.post(
      Uri.parse('$registerUrl/registrar_visita.php'),
      body: {
        ...visita.toJson(),
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Fallo al registrar la visita - API');
    }
  }

  Future<Visita> getDetalleVisita(String token, String situacionId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/situacion.php'),
      body: {
        'token': token,
        'situacion_id': situacionId,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['exito']) {
        return Visita.fromJson(data['datos']);
      } else {
        throw Exception(data['mensaje']);
      }
    } else {
      throw Exception('Fallo al conectar con la API');
    }
  }
}
