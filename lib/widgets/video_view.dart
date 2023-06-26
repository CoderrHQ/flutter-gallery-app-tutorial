import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({
    Key? key,
    required this.videoFile,
  }) : super(key: key);

  final Future<File?> videoFile;

  @override
  State createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final VideoPlayerController _videoPlayerController;
  late final ChewieController _chewieController;
  late final Chewie videoPlayerWidget;
  bool initialized = false;

  _initVideo() async {
    final video = await widget.videoFile;
    _videoPlayerController = VideoPlayerController.file(video!)
      ..setLooping(true)
      ..initialize().then(
        (_) => setState(() => initialized = true),
      );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );

    videoPlayerWidget = Chewie(
      controller: _chewieController,
    );
  }

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: initialized
          // If the video is initialized, display it
          ? Scaffold(
              body: Center(
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: videoPlayerWidget,
                ),
              ),
            )
          // If the video is not yet initialized, display a spinner
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
