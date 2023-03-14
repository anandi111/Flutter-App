import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:training_app/utils/appbar.dart';

class RecordScreen extends StatefulWidget {
  List<Map<String, dynamic>> list = [];
  int index;
  RecordScreen({Key? key, required this.list, required this.index}) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
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
    audioPlayer.play(DeviceFileSource(widget.list[widget.index]["path"].toString())).then((value) {
      // totalDurationFunction();
      // currentDurationFunction();
      index = widget.index;
      setState(() {});
    });

    // audioPlayer.onPlayerComplete.listen((event) {
    //   if (totalDuration!.inSeconds.round() == currentDuration!.inSeconds.round()) {
    //     if (index + 1 == widget.list.length) {
    //       index++;
    //
    //       audioPlayer.play(DeviceFileSource(widget.list[widget.index]["path"].toString())).then((value) {
    //         totalDurationFunction();
    //         currentDuration = const Duration(seconds: 0);
    //       });
    //
    //       setState(() {});
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.list[index]["path"].toString().split("/").last.split(".").first),
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
                InkWell(
                  onTap: () async {
                    if (index != 0) {
                      index--;

                      audioPlayer.play(DeviceFileSource(widget.list[index]["path"].toString())).then((value) {
                        totalDurationFunction();
                        currentDuration = const Duration(seconds: 0);
                      });

                      setState(() {});
                    }
                  },
                  child: const Icon(CupertinoIcons.backward_end_fill),
                ),
                InkWell(
                  onTap: () {
                    audioPlayer
                        .seek(Duration(seconds: currentDuration!.inSeconds - 10))
                        .then((value) => setState(() {}));
                  },
                  child: const Icon(CupertinoIcons.gobackward_10),
                ),
                InkWell(
                  onTap: () {
                    if (isPause) {
                      audioPlayer.pause();
                      setState(() {
                        isPause = false;
                      });
                    } else {
                      audioPlayer.play(
                        DeviceFileSource(widget.list[index]["path"].toString()),
                        position: Duration(seconds: currentDuration!.inSeconds),
                      );
                      setState(() {
                        isPause = true;
                      });
                    }
                  },
                  child: Icon(
                    (isPause == false) ? Icons.play_circle_rounded : Icons.pause_circle_filled,
                  ),
                ),
                InkWell(
                  onTap: () {
                    audioPlayer
                        .seek(Duration(seconds: currentDuration!.inSeconds + 10))
                        .then((value) => setState(() {}));
                  },
                  child: const Icon(CupertinoIcons.goforward_10),
                ),
                InkWell(
                  onTap: () async {
                    if (index + 1 != widget.list.length) {
                      index++;

                      audioPlayer.play(DeviceFileSource(widget.list[index]["path"].toString())).then((value) {
                        totalDurationFunction();
                        currentDuration = const Duration(seconds: 0);
                      });

                      setState(() {});
                    }
                  },
                  child: const Icon(CupertinoIcons.forward_end_fill),
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
          ],
        ),
      ),
    );
  }
}
