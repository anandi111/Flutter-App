import 'dart:io';

import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';

class ImagePaginationScreen extends StatefulWidget {
  List<Map<String, dynamic>> list;
  int index;
  ImagePaginationScreen({Key? key, required this.list, required this.index}) : super(key: key);

  @override
  State<ImagePaginationScreen> createState() => _ImagePaginationScreenState();
}

class _ImagePaginationScreenState extends State<ImagePaginationScreen> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Images"),
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: widget.list
            .map((e) => InteractiveViewer(
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.file(File(e["path"])),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
