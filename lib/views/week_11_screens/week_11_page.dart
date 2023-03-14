import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Week11Page extends StatefulWidget {
  const Week11Page({Key? key}) : super(key: key);

  @override
  State<Week11Page> createState() => _Week11PageState();
}

class _Week11PageState extends State<Week11Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Week 11"),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            MyButton(
                label: "Slivers",
                callback: () {
                  Navigator.of(context).pushNamed("sliver_screen");
                }),
            MyButton(
                label: "Files",
                callback: () {
                  Navigator.of(context).pushNamed("file_screen");
                }),
            MyButton(
                label: "Method Channel",
                callback: () {
                  Navigator.of(context).pushNamed("method_channel_screen");
                }),
            MyButton(
                label: "Method Channel - Connection",
                callback: () {
                  Navigator.of(context).pushNamed("connection_screen");
                }),
          ],
        ),
      ),
    );
  }
}
