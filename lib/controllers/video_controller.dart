import 'package:flutter/material.dart';
import 'package:visita_detalle/services/video_service.dart';
import 'package:visita_detalle/models/video.dart';

class VideoController extends ChangeNotifier {
  final VideoService _videoService = VideoService();
  List<Video> _videos = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Video> get videos => _videos;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchVideos() async {
    _isLoading = true;
    notifyListeners();

    try {
      print('Fetching videos...');
      _videos = await _videoService.fetchVideos();
      print('Videos fetched: ${_videos.length}');
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
      print('Error fetching videos: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
