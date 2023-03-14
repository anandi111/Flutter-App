import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:training_app/helpers/record_db_helper.dart';
import 'package:training_app/utils/appbar.dart';

class SoundRecordingScreen extends StatefulWidget {
  const SoundRecordingScreen({Key? key}) : super(key: key);

  @override
  State<SoundRecordingScreen> createState() => _SoundRecordingScreenState();
}

class _SoundRecordingScreenState extends State<SoundRecordingScreen> {
  String? storageName;
  FlutterSoundRecorder? flutterSoundRecorder = FlutterSoundRecorder();
  AudioPlayer audioPlayer = AudioPlayer();

  initFlutterSoundRecorder() async {
    await flutterSoundRecorder?.openRecorder();

    flutterSoundRecorder?.setSubscriptionDuration(const Duration(seconds: 1));
    setState(() {});
  }

  disposeFlutterSoundRecorder() async {
    await flutterSoundRecorder?.closeRecorder();
  }

  record() async {
    await Permission.microphone.request();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    storageName = DateTime.now().toString();

    storageName = storageName!.replaceAll("-", "").replaceAll(" ", "").replaceAll(":", "").replaceAll(".", "");

    await flutterSoundRecorder?.openRecorder();
    await flutterSoundRecorder
        ?.startRecorder(
          toFile: "$tempPath/Record$storageName.aac",
        )
        .then((value) => setState(() {}));

    await RecordDBHelper.recordDBHelper.insertData(path: "$tempPath/Record$storageName.aac");

    // print("${tempPath}");
    // print(flutterSoundRecorder?.isRecording);
  }

  pause() async {
    await flutterSoundRecorder?.pauseRecorder().then((value) => setState(() {}));
  }

  resume() async {
    await flutterSoundRecorder?.resumeRecorder().then((value) => setState(() {}));
  }

  stop() async {
    await flutterSoundRecorder?.stopRecorder().then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Recording sucessfully done............"))));

    setState(() {});
    // print(flutterSoundRecorder?.isStopped);
  }

  @override
  initState() {
    super.initState();
    initFlutterSoundRecorder();
  }

  @override
  dispose() {
    super.dispose();
    disposeFlutterSoundRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Sound Recording"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.of(context).pushNamed("record_display_screen");
        },
        child: const Icon(Icons.menu),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.mic_none,
              size: 200,
              color: Colors.indigo,
            ),
            StreamBuilder<RecordingDisposition>(
              stream: flutterSoundRecorder?.onProgress,
              builder: (context, snapshot) {
                Duration duration = snapshot.hasData ? snapshot.data!.duration : Duration.zero;

                return Text(
                    "${duration.inHours.remainder(12).toString()} : ${duration.inMinutes.remainder(60).toString()} : ${duration.inSeconds.remainder(60).toString()}",
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600));
              },
            ),
            const SizedBox(
              height: 30,
            ),
            (flutterSoundRecorder?.isRecording == true)
                ? IconButton(
                    onPressed: () {
                      stop();
                    },
                    iconSize: 50,
                    icon: const Icon(
                      Icons.square,
                      color: Colors.red,
                    ))
                : IconButton(
                    onPressed: () {
                      record();
                    },
                    iconSize: 50,
                    icon: const Icon(
                      Icons.album_rounded,
                      color: Colors.red,
                    )),
            /* IconButton(
                onPressed: () {
                  pause();
                },
                iconSize: 50,
                icon: const Icon(
                  Icons.pause,
                  color: Colors.red,
                )),
            IconButton(
                onPressed: () {
                  resume();
                },
                iconSize: 50,
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.red,
                ))*/
            // const SizedBox(
            //   height: 10,
            // ),
            // IconButton(
            //     onPressed: () async {
            //       Directory tempDir = await getTemporaryDirectory();
            //       String tempPath = tempDir.path;
            //
            //       print(storageName);
            //
            //       await audioPlayer.play(DeviceFileSource("$tempPath/Record$storageName.aac"));
            //
            //       // String? url = await flutterSoundRecorder!.getRecordURL(path: "${DateTime.now()}.aac");
            //
            //       // await RecordDBHelper.recordDBHelper.insertData(path: url!).then((value) =>
            //       //     ScaffoldMessenger.of(context)
            //       //         .showSnackBar(const SnackBar(content: Text("Recording saves sucessfully"))));
            //
            //       // print(url);
            //
            //       // await audioPlayer.play(DeviceFileSource(url));
            //
            //       /*audioPlayer.onDurationChanged.listen((Duration d) {
            //         print('Max duration: $d');
            //         // setState(() => duration = d);
            //       });
            //
            //       audioPlayer.onPositionChanged.listen((Duration p) => {
            //             print('Current position: $p')
            //             // setState(() => position = p);
            //           });*/
            //
            //       setState(() {});
            //     },
            //     iconSize: 50,
            //     icon: const Icon(
            //       Icons.folder,
            //     )),
          ],
        ),
      ),
    );
  }
}
