import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:video_player/video_player.dart';

class VideoPickerScreen extends StatefulWidget {
  const VideoPickerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPickerScreen> createState() => _VideoPickerScreenState();
}

class _VideoPickerScreenState extends State<VideoPickerScreen> {
  VideoPlayerController? videoPlayerController;
  final ImagePicker _picker = ImagePicker();
  XFile? video;

  void initState() {
    super.initState();
    videoPlayerController?.addListener(() {
      print("hello");
      videoPlayerController?.position.whenComplete(() => setState(() {
            print("hello");
          }));
    });
  }

  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Video Picker"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              (video != null)
                  ? Column(
                      children: [
                        AspectRatio(
                            aspectRatio: videoPlayerController!.value.aspectRatio,
                            child: VideoPlayer(videoPlayerController!)),
                        const SizedBox(
                          height: 10,
                        ),
                        VideoProgressIndicator(
                          videoPlayerController!,
                          allowScrubbing: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (videoPlayerController!.value.isPlaying == true) {
                                  videoPlayerController?.pause();
                                } else {
                                  videoPlayerController?.play();
                                }
                              });
                            },
                            icon: (videoPlayerController!.value.isPlaying)
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow))
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  label: "Take Video",
                  callback: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Select Your Image",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // Pick an image
                                      video = await _picker.pickVideo(source: ImageSource.camera);

                                      if (video != null) {
                                        setState(() {
                                          videoPlayerController = VideoPlayerController.file(File(video!.path));
                                          videoPlayerController!.initialize().then((value) => setState(() {}));
                                          videoPlayerController!.play();
                                        });
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.camera_alt, color: Colors.blue, size: 40),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Camera",
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      // Pick an image
                                      video = await _picker.pickVideo(source: ImageSource.gallery);
                                      if (video != null) {
                                        setState(() {
                                          videoPlayerController = VideoPlayerController.file(File(video!.path));
                                          videoPlayerController!.initialize().then((value) => setState(() {}));
                                          videoPlayerController!.play();
                                        });
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.photo, color: Colors.blue, size: 40),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Gallery",
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          );
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
