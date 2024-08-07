import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/video_controller.dart';
import 'video_detail.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  createState() => _VideoListScreenState();
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
      'https://www.youtube.com/watch?v=66ReM0pvFLs',
      'https://www.youtube.com/watch?v=PMW8U0SPyEo',
      'https://www.youtube.com/watch?v=4cfUMCdpD_g',
    ];

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Videos'),
          backgroundColor: const Color(0xff0F539C),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body: videoController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : videoController.errorMessage.isNotEmpty
                ? Center(child: Text(videoController.errorMessage))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: videoController.videos.length,
                    itemBuilder: (context, index) {
                      final video = videoController.videos[index];
                      final String youtubeLink =
                          youtubeLinks[index % youtubeLinks.length];

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            video.titulo,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            video.descripcion,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
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
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
