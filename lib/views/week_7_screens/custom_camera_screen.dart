import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:training_app/helpers/image_helper.dart';
import 'package:training_app/helpers/video_helper.dart';
import 'package:training_app/main.dart';
import 'package:training_app/views/week_5_screens/preview_screen.dart';
import 'package:training_app/views/week_7_screens/custom_gallery_screen.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CustomCameraScreen extends StatefulWidget {
  const CustomCameraScreen({Key? key}) : super(key: key);

  @override
  State<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

// ignore: constant_identifier_names
enum Camera { Full, Square, Rectangle }

class _CustomCameraScreenState extends State<CustomCameraScreen> {
  late CameraController controller;
  String? initialValue;
  double height = 700;
  double width = double.infinity;
  IconData flashLightIcon = Icons.highlight_outlined;
  bool isFront = false;
  Color flashAutoColor = Colors.white;
  XFile? capturedImage;
  XFile? capturedVideo;
  bool isVideoCaptured = false;
  Uint8List? thumbNailPic;
  double zoomValue = 0;
  bool isVideo = false;
  IconData videoIcon = Icons.pause;
  final CustomTimerController customTimerController = CustomTimerController();
  final fadeInController = FadeInController();

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      cameras[0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
        body: Stack(
      children: [
        //camera...........................................................................................................
        Center(
          child: SizedBox(
              height: height,
              width: width,
              child: GestureDetector(
                  onTap: () {
                    controller.setFocusMode(FocusMode.auto);
                  },
                  child: CameraPreview(
                    controller,
                  ))),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 35,
            ),
            Container(
              // height: 50,
              // width: double.infinity,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //touch Button..............................................................................................
                  IconButton(
                      onPressed: () async {
                        if (flashLightIcon == Icons.highlight_outlined) {
                          await controller.setFlashMode(FlashMode.torch);
                          flashLightIcon = Icons.highlight;
                          setState(() {});
                        } else {
                          await controller.setFlashMode(FlashMode.off);
                          flashLightIcon = Icons.highlight_outlined;
                          setState(() {});
                        }
                      },
                      icon: Icon(flashLightIcon)),
                  //auto flash...............................................................................................
                  IconButton(
                      onPressed: () async {
                        if (flashAutoColor == Colors.white) {
                          await controller.setFlashMode(FlashMode.auto);
                          flashAutoColor = Colors.amber;
                          setState(() {});
                        } else {
                          await controller.setFlashMode(FlashMode.off);
                          flashAutoColor = Colors.white;
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        Icons.flash_auto_rounded,
                        color: flashAutoColor,
                      )),
                  //camera.....................................................................................................
                  IconButton(
                      onPressed: () {
                        if (isFront == true) {
                          controller = CameraController(
                            cameras[0],
                            ResolutionPreset.max,
                          );
                          controller.initialize().then((value) => setState(() {}));
                          isFront = false;
                        } else {
                          controller = CameraController(
                            cameras[1],
                            ResolutionPreset.max,
                          );
                          controller.initialize().then((value) => setState(() {}));
                          isFront = true;
                        }
                      },
                      icon: const Icon(CupertinoIcons.camera_rotate)),
                  //popUp Button...............................................................................................
                  PopupMenuButton(
                    child: const Icon(Icons.menu),
                    onSelected: (Camera val) {
                      setState(() {
                        initialValue = val.name;
                        if (val == Camera.Full) {
                          height = double.infinity;
                        } else if (val == Camera.Square) {
                          height = 500;
                        } else {
                          height = 700;
                        }
                      });
                    },
                    itemBuilder: (context) => Camera.values
                        .map((e) => PopupMenuItem<Camera>(
                              value: e,
                              child: Text(e.name),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            (isVideo == true)
                ? CustomTimer(
                    controller: customTimerController,
                    begin: const Duration(),
                    end: const Duration(days: 1),
                    builder: (time) {
                      return Text("${time.hours}:${time.minutes}:${time.seconds}",
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white));
                    })
                : const SizedBox(),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300,
                  child: Slider(
                      value: zoomValue,
                      thumbColor: Colors.white,
                      activeColor: Colors.white,
                      min: 0,
                      max: 10,
                      inactiveColor: Colors.grey,
                      onChanged: (val) {
                        setState(() {
                          zoomValue = val;
                          controller.setZoomLevel(val);
                        });
                      }),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5), color: CupertinoColors.darkBackgroundGray),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    double.parse(zoomValue.toStringAsFixed(2)).toString(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              // height: 60,
              // width: double.infinity,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //video button.....................................................................................
                  (isVideo == false)
                      ? GestureDetector(
                          onTap: () {
                            isVideo = true;
                            controller.startVideoRecording();
                            customTimerController.start();
                            setState(() {});
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration:
                                BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 5, color: Colors.grey)),
                            alignment: Alignment.center,
                            child: const Icon(Icons.circle, size: 40, color: Colors.red),
                          ),
                        )
                      : IconButton(
                          onPressed: () async {
                            if (controller.value.isRecordingPaused) {
                              await controller.resumeVideoRecording();
                              // videoIcon = Icons.pause;
                              customTimerController.start();
                            } else {
                              await controller.pauseVideoRecording();
                              // videoIcon = Icons.play_arrow;
                              customTimerController.pause();
                            }
                            setState(() {});
                          },
                          iconSize: 40,
                          icon: Icon(
                            (controller.value.isRecordingPaused == true) ? Icons.play_arrow : Icons.pause,
                          )),
                  //image button.....................................................................................
                  (isVideo == false)
                      ? GestureDetector(
                          onTap: () async {
                            fadeInController.fadeOut();

                            capturedImage = await controller.takePicture();

                            thumbNailPic = await capturedImage!.readAsBytes();

                            isVideoCaptured = false;

                            await ImageDBHelper.imageDBHelper.insertData(path: capturedImage!.path);

                            GallerySaver.saveImage(capturedImage!.path).then((value) => null);

                            setState(() {});
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration:
                                BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 5, color: Colors.grey)),
                            alignment: Alignment.center,
                            child: const Icon(Icons.camera, size: 45),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            isVideo = false;
                            capturedVideo = await controller.stopVideoRecording();

                            thumbNailPic = await VideoThumbnail.thumbnailData(
                              video: capturedVideo!.path,
                              maxWidth: 128,
                              quality: 25,
                            );

                            isVideoCaptured = true;

                            customTimerController.reset();

                            await VideoDBHelper.videoDBHelper.insertData(path: capturedVideo!.path);

                            GallerySaver.saveVideo(capturedVideo!.path).then((value) => null);

                            setState(() {});
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration:
                                BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 5, color: Colors.grey)),
                            alignment: Alignment.center,
                            child: const Icon(Icons.stop, size: 40, color: Colors.red),
                          ),
                        ),
                  //preview button.....................................................................................
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CustomGalleryScreen(),
                      ));

                      // if (thumbNailPic != null) {
                      //   if (isVideoCaptured == false) {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => PreviewScreen(file: capturedImage!, isImage: true),
                      //         ));
                      //   } else {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => PreviewScreen(file: capturedVideo!, isImage: false),
                      //         ));
                      //   }
                      // }
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      alignment: Alignment.center,
                      child: (thumbNailPic != null) ? Image.memory(thumbNailPic!) : const SizedBox(),
                    ),
                  ),
                  // Container(height: 60, width: 60, child: controller.buildPreview()),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ],
    ));
  }
}
