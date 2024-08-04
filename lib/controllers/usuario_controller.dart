import '../models/register_model.dart';
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import '../services/usuarios/usuario_service.dart';

class UsuarioController extends ChangeNotifier {
  final UsuarioService _usuarioService = UsuarioService();
  User? _user;
  String? _errorMessage;

  User? get user => _user;
  String? get errorMessage => _errorMessage;

  Future<void> register(UserForRegister user) async {
    try {
      final result = await _usuarioService.register(user);
      if (result['exito']) {
        _errorMessage = null;
      } else {
        _errorMessage = result['mensaje'];
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Registro fallido: $e';
      notifyListeners();
    }
  }

  Future<void> login(String cedula, String clave) async {
    try {
      final result = await _usuarioService.login(cedula, clave);

      print('Login result: $result');

      if (result['exito']) {
        _errorMessage = null;
        // Verifica si 'datos' es un objeto y tiene las propiedades necesarias
        if (result['datos'] is Map<String, dynamic>) {
          _user = User.fromJson(result['datos']);
        } else {
          _errorMessage = 'Datos no válidos';
        }
      } else {
        _errorMessage = result['mensaje'] ?? 'Error desconocido';
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Inicio de sesión fallido: $e';
      notifyListeners();
    }
  }
}
