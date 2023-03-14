import 'dart:io';
import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:video_player/video_player.dart';

class PreviewScreen extends StatefulWidget {
  XFile file;
  bool isImage;
  PreviewScreen({Key? key, required this.file, required this.isImage}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    if (widget.isImage != true) {
      videoPlayerController = VideoPlayerController.file(File(widget.file.path))
        ..initialize().then((value) => print("video initialized"));

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
      )..play();
    }
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController!.dispose().then((value) => null);
    chewieController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Preview"),
      body: Center(
        child: (widget.isImage == true) ? Image.file(File(widget.file.path)) : Chewie(controller: chewieController!),
      ),
    );
  }
}
