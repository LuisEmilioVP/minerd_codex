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
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Respuesta vacía');
      }
    } else {
      throw Exception('Fallo al conectar con la API');
    }
  }

  Future<Map<String, dynamic>> recoverPassword(
      String cedula, String correo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recuperar_clave.php'),
      body: {
        'cedula': cedula,
        'correo': correo,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Recuperación de contraseña fallida');
    }
  }

  Future<Map<String, dynamic>> changePassword(
      String token, String oldPassword, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cambiar_clave.php'),
      body: {
        'token': token,
        'clave_anterior': oldPassword,
        'clave_nueva': newPassword,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Cambio de contraseña fallido');
    }
  }
}
