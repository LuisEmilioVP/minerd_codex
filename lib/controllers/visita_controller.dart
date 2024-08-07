import 'package:flutter/material.dart';
import '../services/visitas/visita_service.dart';
import '../models/visita_model.dart';

class VisitaController extends ChangeNotifier {
  final VisitaService _visitaService = VisitaService();
  List<Visita> _visitas = [];
  bool _loading = false;
  String? _errorMessage;
  String? _successMessage;
  Visita? _detalleVisita;

  List<Visita> get visitas => _visitas;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  Visita? get detalleVisita => _detalleVisita;

  Future<void> fetchVisitas(String token) async {
    _loading = true;
    notifyListeners();

    try {
      _visitas = await _visitaService.fetchVisitas(token);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> registrarVisita(Visita visita, String token) async {
    _loading = true;
    notifyListeners();

    try {
      final result = await _visitaService.registrarVisita(visita, token);

      if (result['exito']) {
        _successMessage = result['mensaje'];
        _errorMessage = null;
      } else {
        _errorMessage = result['mensaje'];
        _successMessage = null;
      }
    } catch (e) {
      _errorMessage = 'Registro fallido: $e';
      _successMessage = null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDetalleVisita(String token, String situacionId) async {
    _loading = true;
    notifyListeners();

    try {
      _detalleVisita =
          await _visitaService.getDetalleVisita(token, situacionId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error al cargar detalle: $e';
      _detalleVisita = null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
