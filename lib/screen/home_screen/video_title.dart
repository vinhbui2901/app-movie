import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:video_player/video_player.dart';

class VideoTitle extends StatefulWidget {
  final Movie movie;
  const VideoTitle({Key? key, required this.movie}) : super(key: key);

  @override
  State<VideoTitle> createState() => _VideoTitleState();
}

class _VideoTitleState extends State<VideoTitle> {
  VideoPlayerController? controller;
  String dataUrlVideo = '';
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(dataUrlVideo)
      ..initialize().then((_) {
        setState(() {
          controller!.play();
        });
      });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
