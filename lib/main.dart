import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/video_controller.dart';
import 'views/video_listScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoController(),
      child: MaterialApp(
        home: VideoListScreen(),
      ),
    );
  }
}
