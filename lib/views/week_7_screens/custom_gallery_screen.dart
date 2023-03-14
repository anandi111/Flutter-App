import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/image_helper.dart';
import 'package:training_app/helpers/video_helper.dart';
import 'package:training_app/modals/thumbnail.dart';
import 'package:training_app/views/week_7_screens/image_pagination_screen.dart';
import 'package:training_app/views/week_7_screens/video_pagination_screen.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CustomGalleryScreen extends StatefulWidget {
  const CustomGalleryScreen({Key? key}) : super(key: key);

  @override
  State<CustomGalleryScreen> createState() => _CustomGalleryScreenState();
}

class _CustomGalleryScreenState extends State<CustomGalleryScreen> {
  Future<List<ThumbNailModal>> getThumbNailList({required List<Map<String, dynamic>> list}) async {
    List<ThumbNailModal> thumbNailList = [];

    for (int i = 0; i < list.length; i++) {
      Uint8List? thumbNailPic = await VideoThumbnail.thumbnailData(
        video: list[i]["path"],
        maxWidth: 128,
        quality: 25,
      );
      thumbNailList.add(ThumbNailModal(list: thumbNailPic as Uint8List));
    }

    return thumbNailList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Custom Gallery"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Photos", icon: Icon(Icons.photo)),
              Tab(text: "Videos", icon: Icon(Icons.video_camera_back)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: ImageDBHelper.imageDBHelper.fetchAllData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  );
                } else if (snapshot.hasData) {
                  List<Map<String, dynamic>> list = snapshot.data as List<Map<String, dynamic>>;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: list.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1 / 1,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ImagePaginationScreen(list: list, index: (list.length - 1) - index)));
                          },
                          onLongPress: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    height: 220,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          "Delete note",
                                          style:
                                              TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                                        ),
                                        const Text(
                                          "Delete 1 item?",
                                          style: TextStyle(fontSize: 20, color: Colors.black),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(50),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () async {
                                                  await ImageDBHelper.imageDBHelper
                                                      .deleteData(path: list[(list.length - 1) - index]["path"]);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(50),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }).then((value) => setState(() {}));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: FileImage(File(list[(list.length - 1) - index]["path"])),
                                    fit: BoxFit.cover)),
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
            FutureBuilder(
              future: VideoDBHelper.videoDBHelper.fetchAllData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  );
                } else if (snapshot.hasData) {
                  List<Map<String, dynamic>> list = snapshot.data as List<Map<String, dynamic>>;

                  return FutureBuilder(
                    future: getThumbNailList(list: list),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString(),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        );
                      } else if (snapshot.hasData) {
                        List<ThumbNailModal> tnList = snapshot.data as List<ThumbNailModal>;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            itemCount: list.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 2 / 1.5,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => VideoPaginationScreen(
                                          list: [list[(list.length - 1) - index]], index: (list.length - 1) - index)));
                                },
                                onLongPress: () {
                                  showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return Container(
                                          height: 220,
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                "Delete note",
                                                style: TextStyle(
                                                    fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                                              ),
                                              const Text(
                                                "Delete 1 item?",
                                                style: TextStyle(fontSize: 20, color: Colors.black),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey.withOpacity(0.2),
                                                          borderRadius: BorderRadius.circular(50),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        await VideoDBHelper.videoDBHelper
                                                            .deleteData(path: list[(list.length - 1) - index]["path"]);
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.circular(50),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      }).then((value) => setState(() {}));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      image: DecorationImage(
                                        image: MemoryImage(tnList[(list.length - 1) - index].list),
                                        fit: BoxFit.cover,
                                      )),
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
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
