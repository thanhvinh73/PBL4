import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'dart:core';

import '../../shared/utils/app_colors.dart';

class VideoViewScreen extends StatefulWidget {
  final String assetUrl;
  const VideoViewScreen({Key? key, required this.assetUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoViewScreenState();
  }
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  late VideoPlayerController _videoPlayerController;

  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();

    _chewieController?.dispose();
    // CommonHelper.setStatusBarStyle(const StatusBarStyle(
    //     statusBarColor: AppColors.white,
    //     statusBarBrightness: Brightness.light,
    //     statusBarIconBrightness: Brightness.light,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //     systemNavigationBarColor: AppColors.white));
    super.dispose();
  }

  Future<void> initializePlayer() async {
    // _videoPlayerController = VideoPlayerController.file(widget
    //         .file.url.isNotEmptyOrNull
    //     ? widget.file.url!
    //     : "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4");
    _videoPlayerController = VideoPlayerController.asset(widget.assetUrl);

    await Future.wait([_videoPlayerController.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),
    );
  }

  Future<void> toggleVideo() async {
    await _videoPlayerController.pause();
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.close)),
        actions: [
          GestureDetector(
            onTap: () async {},
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.file_download_outlined,
                size: 24,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: AppColors.black,
              child: Center(
                child: _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? Chewie(
                        controller: _chewieController!,
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
