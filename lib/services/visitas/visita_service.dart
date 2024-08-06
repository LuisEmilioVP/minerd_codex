import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/visita_model.dart';

class VisitaService {
  final String baseUrl = 'https://adamix.net/minerd/def';

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
}
