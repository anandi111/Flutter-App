import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import '../../utils/buttons.dart';

class Week3Page extends StatefulWidget {
  const Week3Page({Key? key}) : super(key: key);

  @override
  State<Week3Page> createState() => _Week3PageState();
}

class _Week3PageState extends State<Week3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Week 3"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            MyButton(
                label: "12. Gestures",
                callback: () {
                  Navigator.pushNamed(context, "gesture_screen");
                }),
            MyButton(
                label: "12.1. Image Picker",
                callback: () {
                  Navigator.pushNamed(context, "image_picker_screen");
                }),
            MyButton(
                label: "12.2. Video Picker",
                callback: () {
                  Navigator.pushNamed(context, "video_picker_screen");
                }),
            MyButton(
                label: "12.3. Drag and Drop Functionality",
                callback: () {
                  Navigator.pushNamed(context, "drag_drop_functionality_screen");
                }),
            MyButton(
                label: "13. DataBase",
                callback: () {
                  Navigator.pushNamed(context, "database_screen");
                }),
            MyButton(
                label: "14. API Calling",
                callback: () {
                  Navigator.pushNamed(context, "api_calling_screen");
                }),
            MyButton(
                label: "14.1 CRUD API Calling",
                callback: () {
                  Navigator.pushNamed(context, "crud_api_calling_screen");
                }),
          ],
        ),
      ),
    );
  }
}
