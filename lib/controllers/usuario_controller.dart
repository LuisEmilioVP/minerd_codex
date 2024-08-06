import '../models/register_model.dart';
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import '../services/usuarios/usuario_service.dart';

class UsuarioController extends ChangeNotifier {
  final UsuarioService _usuarioService = UsuarioService();
  User? _user;
  String? _errorMessage;
  String? _successMessage;

  User? get user => _user;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  Future<void> register(UserForRegister user) async {
    try {
      final result = await _usuarioService.register(user);
      if (result['exito']) {
        _errorMessage = null;
        _successMessage = result['mensaje'];
      } else {
        _errorMessage = result['mensaje'];
        _successMessage = null;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Registro fallido: $e';
      _successMessage = null;
      notifyListeners();
    }
  }

  Future<void> login(String cedula, String clave) async {
    try {
      final result = await _usuarioService.login(cedula, clave);

      if (result['exito']) {
        _errorMessage = null;
        if (result['datos'] is Map<String, dynamic>) {
          _user = User.fromJson(result['datos']);
          _successMessage = result['mensaje'];
        } else {
          _errorMessage = 'Datos no válidos';
          _successMessage = null;
        }
      } else {
        _errorMessage = result['mensaje'] ?? 'Error desconocido';
        _successMessage = null;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Inicio de sesión fallido: $e';
      _successMessage = null;
      notifyListeners();
    }
  }

  Future<void> recoverPassword(String cedula, String correo) async {
    try {
      final result = await _usuarioService.recoverPassword(cedula, correo);
      if (result['exito']) {
        _errorMessage = null;
        _successMessage = result['mensaje'];
      } else {
        _errorMessage = result['mensaje'];
        _successMessage = null;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Recuperación de contraseña fallida: $e';
      _successMessage = null;
      notifyListeners();
    }
  }

  Future<void> changePassword(
      String token, String oldPassword, String newPassword) async {
    try {
      final result =
          await _usuarioService.changePassword(token, oldPassword, newPassword);
      if (result['exito']) {
        _errorMessage = null;
        _successMessage = result['mensaje'];
      } else {
        _errorMessage = result['mensaje'];
        _successMessage = null;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Cambio de contraseña fallido: $e';
      _successMessage = null;
      notifyListeners();
    }
  }
}
