import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/centro_educativo.dart';

class CentroEducativoService {
  static const String _baseUrl = 'https://adamix.net/minerd/minerd/centros.php';

  Future<List<CentroEducativo>> fetchCentros({String regional = '*'}) async {
    final response = await http.get(Uri.parse('$_baseUrl?regional=$regional'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['exito']) {
        final List<dynamic> data = jsonResponse['datos'];
        return data.map((item) => CentroEducativo.fromJson(item)).toList();
      } else {
        throw Exception(jsonResponse['mensaje']);
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
