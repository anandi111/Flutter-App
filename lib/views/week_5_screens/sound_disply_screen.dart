import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:training_app/modals/music.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/views/week_5_screens/sound_screen.dart';

class SoundDisplayScreen extends StatefulWidget {
  const SoundDisplayScreen({Key? key}) : super(key: key);

  @override
  State<SoundDisplayScreen> createState() => _SoundDisplayScreenState();
}

class _SoundDisplayScreenState extends State<SoundDisplayScreen> {
  List<Music> musicFileList = [];

  getSingleFile({required AssetEntity file}) async {
    File f = await file.file as File;

    return f;
  }

  getAllPath() async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(type: RequestType.audio);

      final List<AssetEntity> entities = await paths[0].getAssetListPaged(
        page: 0,
        size: 80,
      );

      print(entities.length);

      for (int i = 0; i < entities.length; i++) {
        File file = await getSingleFile(file: entities[i]);

        musicFileList.add(Music(
            songName: entities[i].title ?? "Music",
            artist: entities[i].createDateTime.toString() ?? "Unknown",
            file: file));
      }

      print("FileList: ${musicFileList.length}");

      setState(() {});
    }
    return musicFileList;
  }

  @override
  void initState() {
    super.initState();
    getAllPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Sound Player"),
      body: FutureBuilder(
        future: getAllPath(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: musicFileList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SoundScreen(musicList: musicFileList, index: index),
                          ));
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        tileColor: Colors.indigo,
                        leading: const Icon(
                          Icons.music_note_outlined,
                          size: 30,
                        ),
                        title: Text(musicFileList[index].songName!),
                        subtitle: Text(musicFileList[index].artist!),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
