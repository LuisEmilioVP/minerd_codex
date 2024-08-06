import 'package:flutter/material.dart';
import '../services/visitas/visita_service.dart';
import '../models/visita_model.dart';

class VisitaController extends ChangeNotifier {
  final VisitaService _visitaService = VisitaService();
  List<Visita> _visitas = [];
  bool _loading = false;
  String? _errorMessage;

  List<Visita> get visitas => _visitas;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;

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
}
