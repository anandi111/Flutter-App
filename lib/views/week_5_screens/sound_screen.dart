import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/modals/music.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:siri_wave/siri_wave.dart';

class SoundScreen extends StatefulWidget {
  SoundScreen({Key? key, required this.musicList, required this.index}) : super(key: key);
  List<Music> musicList;
  int index;

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  final controller = SiriWaveController();
  bool isPause = true;
  Duration? currentDuration;
  Duration? totalDuration;
  int index = 0;

  totalDurationFunction() async {
    totalDuration = await audioPlayer.getDuration();
  }

  currentDurationFunction() async {
    currentDuration = await audioPlayer.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.play(DeviceFileSource(widget.musicList[widget.index].file.path)).then((value) {
      // totalDurationFunction();
      // currentDurationFunction();
      index = widget.index;
      setState(() {});
    });

    audioPlayer.onPlayerComplete.listen((event) {
      if (totalDuration!.inSeconds.round() == currentDuration!.inSeconds.round()) {
        index++;

        audioPlayer.play(DeviceFileSource(widget.musicList[index].file.path)).then((value) {
          totalDurationFunction();
          currentDuration = const Duration(seconds: 0);
        });

        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.musicList[index].songName as String),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SiriWave(
                  controller: controller,
                  style: SiriWaveStyle.ios_9,
                  options: const SiriWaveOptions(
                      backgroundColor: CupertinoColors.darkBackgroundGray, width: 200, height: 200)),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    if (index != 0) {
                      index--;

                      audioPlayer.play(DeviceFileSource(widget.musicList[index].file.path)).then((value) {
                        totalDurationFunction();
                        currentDuration = const Duration(seconds: 0);
                      });

                      setState(() {});
                    }
                  },
                  icon: const Icon(CupertinoIcons.backward_end_fill),
                ),
                IconButton(
                  onPressed: () {
                    audioPlayer
                        .seek(Duration(seconds: currentDuration!.inSeconds - 10))
                        .then((value) => setState(() {}));
                  },
                  icon: const Icon(CupertinoIcons.gobackward_10),
                ),
                IconButton(
                  onPressed: () {
                    if (isPause) {
                      audioPlayer.pause();
                      setState(() {
                        isPause = false;
                      });
                    } else {
                      audioPlayer.play(
                        DeviceFileSource(widget.musicList[widget.index].file.path),
                        position: Duration(seconds: currentDuration!.inSeconds),
                      );
                      setState(() {
                        isPause = true;
                      });
                    }
                  },
                  icon: Icon(
                    (isPause == false) ? Icons.play_circle_rounded : Icons.pause_circle_filled,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    audioPlayer
                        .seek(Duration(seconds: currentDuration!.inSeconds + 10))
                        .then((value) => setState(() {}));
                  },
                  icon: const Icon(CupertinoIcons.goforward_10),
                ),
                IconButton(
                  onPressed: () async {
                    if (index + 1 != widget.musicList.length) {
                      index++;

                      audioPlayer.play(DeviceFileSource(widget.musicList[index].file.path)).then((value) {
                        totalDurationFunction();
                        currentDuration = const Duration(seconds: 0);
                      });

                      setState(() {});
                    }
                  },
                  icon: const Icon(CupertinoIcons.forward_end_fill),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: audioPlayer.onPositionChanged,
              builder: (context, snapshot) {
                currentDuration = snapshot.data as Duration?;
                totalDurationFunction();

                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ProgressBar(
                      thumbGlowColor: Colors.lightGreen.withOpacity(0.3),
                      thumbColor: Colors.lightGreen,
                      progressBarColor: Colors.lightGreen,
                      baseBarColor: Colors.grey,
                      progress: currentDuration as Duration,
                      total: totalDuration!,
                      onSeek: (val) {
                        audioPlayer.seek(val);
                        setState(() {});
                      },
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),

            IconButton(
                onPressed: () async {
                  await audioPlayer.setVolume(0);
                },
                icon: const Icon(Icons.music_off)),
            IconButton(
                onPressed: () async {
                  await audioPlayer.setVolume(1);
                },
                icon: const Icon(Icons.music_note_outlined)),
            // StreamBuilder(
            //   stream: audioPlayer.onPositionChanged,
            //   builder: (context, AsyncSnapshot snapshot) {
            //     currentDuration = snapshot.data;
            //
            //     if (snapshot.hasData) {
            //       return Column(
            //         children: [
            //           (currentDuration == totalDuration)
            //               ? const CircularProgressIndicator()
            //               : Slider(
            //                   activeColor: Colors.lightGreen,
            //                   thumbColor: Colors.lightGreen,
            //                   inactiveColor: Colors.grey,
            //                   min: 0,
            //                   max: totalDuration!.inMicroseconds.toDouble(),
            //                   value: currentDuration!.inMicroseconds.toDouble(),
            //                   onChanged: (val) {
            //                     setState(() {
            //                       currentDuration = Duration(microseconds: val.toInt());
            //                       audioPlayer
            //                           .seek(Duration(microseconds: val.toInt()))
            //                           .then((value) => setState(() {}));
            //                     });
            //                   }),
            //           const SizedBox(
            //             height: 20,
            //           ),
            //           Text(
            //             "${currentDuration.toString().split(".")[0]}/${totalDuration.toString().split(".")[0]}",
            //             style: const TextStyle(color: Colors.white),
            //           )
            //         ],
            //       );
            //     }
            //     return const CircularProgressIndicator();
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
