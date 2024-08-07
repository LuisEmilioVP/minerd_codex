import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/video_models.dart';

class VideoService {
  Future<List<Video>> fetchVideos() async {
    final response =
        await http.post(Uri.parse('https://adamix.net/minerd/def/videos.php'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['exito']) {
        final List<dynamic> data = jsonResponse['datos'];
        return data.map((item) => Video.fromJson(item)).toList();
      } else {
        throw Exception(jsonResponse['mensaje']);
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
