import 'package:flutter/material.dart';
import 'package:visita_detalle/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailScreen extends StatefulWidget {
  final Video video;
  final String youtubeLink;

  VideoDetailScreen({required this.video, required this.youtubeLink});

  @override
  _VideoDetailScreenState createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.youtubeLink)!,
      flags: YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.titulo),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.video.descripcion, style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Fecha: ${widget.video.fecha}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text('Link: ${widget.video.link}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              YoutubePlayer(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }
}
