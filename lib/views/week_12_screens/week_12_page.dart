import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Week12Page extends StatefulWidget {
  const Week12Page({Key? key}) : super(key: key);

  @override
  State<Week12Page> createState() => _Week12PageState();
}

class _Week12PageState extends State<Week12Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Week 12"),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            MyButton(
                label: "Provider",
                callback: () {
                  Navigator.of(context).pushNamed("provider_screen");
                }),
            MyButton(
                label: "GetX",
                callback: () {
                  Navigator.of(context).pushNamed("getx_screen");
                }),
            MyButton(
                label: "Bloc 1",
                callback: () {
                  Navigator.of(context).pushNamed("bloc_screen");
                }),
            MyButton(
                label: "Bloc 2",
                callback: () {
                  Navigator.of(context).pushNamed("simple_bloc_screen");
                }),
            MyButton(
                label: "Redux",
                callback: () {
                  Navigator.of(context).pushNamed("redux_screen");
                }),
          ],
        ),
      ),
    );
  }
}
