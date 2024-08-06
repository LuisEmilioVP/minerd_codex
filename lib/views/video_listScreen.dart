import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visita_detalle/controllers/video_controller.dart';
import 'package:visita_detalle/views/video_detailScreen.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  @override
  void initState() {
    super.initState();
    final videoController =
        Provider.of<VideoController>(context, listen: false);
    videoController.fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    final videoController = Provider.of<VideoController>(context);

    final List<String> youtubeLinks = [
      'https://www.youtube.com/watch?v=dQw4w9WgXcQ', // Primer enlace
      'https://www.youtube.com/watch?v=3JZ_D3ELwOQ', // Segundo enlace
      'https://www.youtube.com/watch?v=9bZkp7q19f0', // Tercer enlace
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: videoController.isLoading
          ? Center(child: CircularProgressIndicator())
          : videoController.errorMessage.isNotEmpty
              ? Center(child: Text(videoController.errorMessage))
              : ListView.builder(
                  itemCount: videoController.videos.length,
                  itemBuilder: (context, index) {
                    final video = videoController.videos[index];
                    final String youtubeLink =
                        youtubeLinks[index % youtubeLinks.length];

                    return ListTile(
                      title: Text(video.titulo),
                      subtitle: Text(video.descripcion),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoDetailScreen(
                              video: video,
                              youtubeLink: youtubeLink,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
