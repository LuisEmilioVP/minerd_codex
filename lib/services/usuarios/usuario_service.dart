import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/register_model.dart';

class UsuarioService {
  final String baseUrl = 'https://adamix.net/minerd/def';

  Future<Map<String, dynamic>> register(UserForRegister user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/registro.php'),
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Registro fallido');
    }
  }

  Future<Map<String, dynamic>> login(String cedula, String clave) async {
    final response = await http.post(
      Uri.parse('$baseUrl/iniciar_sesion.php'),
      body: {
        'cedula': cedula,
        'clave': clave,
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Verifica que el cuerpo de la respuesta no esté vacío
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Respuesta vacía');
      }
    } else {
      throw Exception('Fallo al conectar con la API');
    }
  }
}
