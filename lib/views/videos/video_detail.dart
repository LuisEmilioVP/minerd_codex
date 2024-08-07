import 'package:flutter/material.dart';
import '../../models/video_models.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailScreen extends StatefulWidget {
  final Video video;
  final String youtubeLink;

  const VideoDetailScreen(
      {required this.video, required this.youtubeLink, super.key});

  @override
  createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.youtubeLink)!,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/register.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Dettalle del Video'),
          backgroundColor: const Color(0xff0F539C),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.descripcion,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Fecha: ${widget.video.fecha}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Link: ${widget.video.link}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  YoutubePlayer(controller: _controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
