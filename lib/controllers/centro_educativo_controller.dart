import 'package:flutter/material.dart';
import '../services/centros/centro_service.dart';
import '../models/centro_educativo.dart';

class CentroEducativoController extends ChangeNotifier {
  final CentroEducativoService _service = CentroEducativoService();
  List<CentroEducativo> _centros = [];
  bool _loading = false;
  String _regional = '*';

  CentroEducativoController() {
    fetchInitialCentros();
  }

  List<CentroEducativo> get centros => _centros;
  bool get loading => _loading;
  String get regional => _regional;

  Future<void> fetchCentros({String regional = '*'}) async {
    _loading = true;
    notifyListeners();

    try {
      _centros = await _service.fetchCentros(regional: regional);
      _regional = regional;
    } catch (e) {
      print(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchInitialCentros() async {
    _loading = true;
    notifyListeners();

    try {
      _centros = await _service.fetchCentros(regional: '*');
      if (_centros.length > 10) {
        _centros = _centros.sublist(0, 10);
      }
    } catch (e) {
      print(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
