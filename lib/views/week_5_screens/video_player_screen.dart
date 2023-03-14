import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:training_app/modals/VideoDetail.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/views/week_5_screens/seperate_video_player_screen.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

List<VideoDetail> videoList = [];

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  List<VideoDetail> passVideoList = [];

  getAllVideo() async {
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(type: RequestType.video);

    final List<AssetEntity> entities = await paths.first.getAssetListPaged(
      page: 1,
      size: 80,
    );

    for (int i = 0; i < entities.length; i++) {
      File? file = await entities[i].file;
      Uint8List? thumbNail = await entities[i].thumbnailData;

      VideoDetail video = VideoDetail(
          name: entities[i].title.toString(),
          path: file!.path,
          height: entities[i].height,
          width: entities[i].width,
          totalDuration: entities[i].videoDuration,
          thumbNail: thumbNail as Uint8List,
          createDateTime: entities[i].createDateTime);

      passVideoList.add(video);
    }

    setState(() {});
  }

  getPermission() async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllVideo();
    });
    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Video Player"),
      body: (passVideoList.isNotEmpty)
          ? ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => SeperateVideoPlayerScreen(index: index, videoDetail: passVideoList),
                    ))
                        .then((value) async {
                      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                    });
                  },
                  child: ThumbNailDisplay(
                    videoDetail: passVideoList[index],
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class ThumbNailDisplay extends StatefulWidget {
  VideoDetail videoDetail;
  ThumbNailDisplay({
    Key? key,
    required this.videoDetail,
  }) : super(key: key);

  @override
  State<ThumbNailDisplay> createState() => _ThumbNailDisplayState();
}

class _ThumbNailDisplayState extends State<ThumbNailDisplay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (widget.videoDetail != null)
            ? Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.memory(
                    widget.videoDetail.thumbNail,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: CupertinoColors.darkBackgroundGray),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(widget.videoDetail.totalDuration.toString().split(".").first),
                      ),
                    ),
                  )
                ],
              )
            : Container(height: 300, child: const Center(child: CircularProgressIndicator())),
        Container(
          height: 60,
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.videoDetail.name ?? "unknown",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text(widget.videoDetail.createDateTime.toString() ?? "No time is available"),
              ],
            ),
          ),
        )
      ],
    );
  }
}
