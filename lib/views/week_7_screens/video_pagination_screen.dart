import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:video_player/video_player.dart';

class VideoPaginationScreen extends StatefulWidget {
  List<Map<String, dynamic>> list;
  int index;
  VideoPaginationScreen({Key? key, required this.list, required this.index}) : super(key: key);

  @override
  State<VideoPaginationScreen> createState() => _VideoPaginationScreenState();
}

class _VideoPaginationScreenState extends State<VideoPaginationScreen> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Video"),
      body: PageView(
        controller: pageController,
        children: widget.list
            .map((e) => VideoPreviewPage(
                  path: e["path"],
                ))
            .toList(),
      ),
    );
  }
}

class VideoPreviewPage extends StatefulWidget {
  String path;
  VideoPreviewPage({Key? key, required this.path}) : super(key: key);

  @override
  State<VideoPreviewPage> createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  initVideo() async {
    videoPlayerController = VideoPlayerController.file(File(widget.path));
    await videoPlayerController.initialize().then((value) => setState(() {}));
  }

  @override
  void initState() {
    initVideo();
    super.initState();
  }

  disposeVideo() async {
    await videoPlayerController.dispose();
  }

  @override
  void dispose() {
    disposeVideo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: ChewieController(
        videoPlayerController: videoPlayerController,
      ),
    );
  }
}
