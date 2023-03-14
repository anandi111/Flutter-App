import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:photo_view/photo_view.dart';

class GestureScreen extends StatefulWidget {
  const GestureScreen({Key? key}) : super(key: key);

  @override
  State<GestureScreen> createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  Axis dragDirection = Axis.horizontal;
  PageController pageController = PageController(initialPage: 0);
  List pictureList = [
    "assets/henry-be-lc7xcWebECc-unsplash.jpg",
    "assets/janko-ferlic-sfL_QOnmy00-unsplash.jpg",
    "assets/kiwihug-2ndhRgIbpno-unsplash.jpg",
    "assets/patrick-tomasso-Oaqk7qqNh_c-unsplash.jpg",
    "assets/priscilla-du-preez-aSKW9w1DAdo-unsplash.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "Gestures",
        ),
        body: GestureDetector(
          onHorizontalDragUpdate: (val) {
            setState(() {
              dragDirection = Axis.horizontal;
            });
          },
          onVerticalDragUpdate: (val) {
            setState(() {
              dragDirection = Axis.vertical;
            });
          },
          child: Material(
            color: CupertinoColors.darkBackgroundGray,
            child: PhotoViewGallery(
                // enableRotation: true,
                enableRotation: true,
                gaplessPlayback: true,
                allowImplicitScrolling: true,
                scrollDirection: dragDirection,
                pageController: pageController,
                pageOptions: pictureList
                    .map(
                      (e) => PhotoViewGalleryPageOptions(
                          imageProvider: AssetImage(e)),
                    )
                    .toList()),
          ),
        ));
  }
}
