import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_app/modals/VideoDetail.dart';
import 'package:video_player/video_player.dart';

import '../../utils/appbar.dart';

class SeperateVideoPlayerScreen extends StatefulWidget {
  int index = 0;
  List<VideoDetail> videoDetail;
  SeperateVideoPlayerScreen({Key? key, required this.videoDetail, required this.index}) : super(key: key);

  @override
  State<SeperateVideoPlayerScreen> createState() => _SeperateVideoPlayerScreenState();
}

class _SeperateVideoPlayerScreenState extends State<SeperateVideoPlayerScreen> {
  late VideoPlayerController videoPlayerController;
  int currentValue = 0;
  int totalDuration = 0;
  IconData fullScreenIcon = Icons.fullscreen_exit;
  int index = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      index = widget.index;

      videoPlayerController = VideoPlayerController.file(File(widget.videoDetail[widget.index].path))
        ..initialize().then((value) => setState(() {}))
        ..play()
        ..setLooping(true);
      setState(() {});

      videoPlayerController.addListener(() {
        setState(() {});
      });

      /* videoPlayerController.addListener(() {
        // print(videoPlayerController.value.duration);
        // print(videoPlayerController.value.position);

        if (videoPlayerController.value.duration == videoPlayerController.value.position) {
          videoPlayerController = VideoPlayerController.file(File(widget.videoDetail[widget.index++].path))
            ..initialize().then((value) => setState(() {}))
            ..play();
          setState(() {});
        }

        // print(videoPlayerController.value.position);
      });*/
    });

    super.initState();
  }

  disposeVideo() async {
    await videoPlayerController.dispose();
    videoPlayerController.removeListener(() {});
  }

  @override
  void dispose() {
    disposeVideo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.videoDetail[index].name,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: (videoPlayerController.value.isInitialized)
                  ? VideoPlayer(videoPlayerController)
                  : const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        if (videoPlayerController.value.volume == 0) {
                          videoPlayerController.setVolume(10);
                        } else {
                          videoPlayerController.setVolume(0);
                        }

                        setState(() {});
                      },
                      child: Icon((videoPlayerController.value.volume == 0)
                          ? CupertinoIcons.speaker_slash
                          : CupertinoIcons.speaker)),
                  InkWell(
                      onTap: () async {
                        if (index != 0) {
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                            index--;
                            await videoPlayerController.dispose();
                            videoPlayerController =
                                await VideoPlayerController.file(File(widget.videoDetail[index].path))
                                  ..initialize().then((value) => setState(() {
                                        videoPlayerController.play();
                                        videoPlayerController.setLooping(true);
                                      }));
                            videoPlayerController.addListener(() {
                              setState(() {});
                            });
                          });
                          setState(() {});
                        } else {
                          print(
                              "comes......................................................................................");
                        }
                      },
                      child: const Icon(CupertinoIcons.backward_end_fill)),
                  InkWell(
                      onTap: () {
                        videoPlayerController
                            .seekTo(Duration(seconds: videoPlayerController.value.position.inSeconds - 10));

                        setState(() {});
                      },
                      child: const Icon(CupertinoIcons.gobackward_10)),
                  InkWell(
                      onTap: () {
                        setState(() {
                          if (videoPlayerController.value.isPlaying) {
                            videoPlayerController.pause();
                          } else {
                            videoPlayerController.play();
                          }
                        });
                      },
                      child: Icon((videoPlayerController.value.isPlaying == true) ? Icons.pause : Icons.play_arrow)),
                  InkWell(
                      onTap: () {
                        videoPlayerController
                            .seekTo(Duration(seconds: videoPlayerController.value.position.inSeconds + 10));

                        setState(() {});
                      },
                      child: const Icon(CupertinoIcons.goforward_10)),
                  InkWell(
                      onTap: () async {
                        if (index + 1 == widget.videoDetail.length) {
                          print(
                              "comes..................................................async async ....................................");
                        } else {
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                            index++;

                            await videoPlayerController.dispose();
                            videoPlayerController =
                                await VideoPlayerController.file(File(widget.videoDetail[index].path))
                                  ..initialize().then((value) => setState(() {
                                        videoPlayerController.play();
                                        videoPlayerController.setLooping(true);
                                      }));
                            videoPlayerController.addListener(() {
                              setState(() {});
                            });
                          });
                          setState(() {});
                        }
                      },
                      child: const Icon(CupertinoIcons.forward_end_fill)),
                  InkWell(
                      onTap: () async {
                        (fullScreenIcon == Icons.fullscreen)
                            ? await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
                            : await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

                        if (fullScreenIcon == Icons.fullscreen) {
                          fullScreenIcon = Icons.fullscreen_exit;
                        } else {
                          fullScreenIcon = Icons.fullscreen;
                        }

                        setState(() {});
                      },
                      child: Icon(fullScreenIcon)),
                ],
              ),
            ),
          ),
          VideoProgressIndicator(
            videoPlayerController,
            allowScrubbing: true,
          ),
          /*Slider(
              value: value,
              onChanged: (sliderVal){

              }
          )*/
        ],
      ),
    );
  }
}

// getHash() {
//   String item = "#jjnsn #hjxns #hey yes";
//   int firstIndex = 0;
//   int secondindex = 0;
//   int hashCount = 0;
//
//   print("#".allMatches(item).length);
//
//   print("============================");
//   print("============================");
//   print("============================");
//
//   firstIndex = item.length;
//
//   print("first Length: ${item.length}");
//
//   item = item.replaceAll("#", "");
//
//   secondindex = item.length;
//
//   print("Before Length: ${item.length}");
//
//   hashCount = firstIndex - secondindex;
//
//   print("Hash Count: $hashCount");
//
//   print("============================");
//   print("============================");
//   print("============================");
// }
