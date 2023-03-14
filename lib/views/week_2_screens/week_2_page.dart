import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Week2Page extends StatelessWidget {
  const Week2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Week 2',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            MyButton(
                label: "9. Widgets",
                callback: () {
                  Navigator.pushNamed(context, "widget_screen");
                }),
            MyButton(
                label: "10. Layouts\\Controls",
                callback: () {
                  Navigator.pushNamed(context, "layout_control_screen");
                }),
            MyButton(
                label: "11. Properties",
                callback: () {
                  Navigator.pushNamed(context, "properties_screen");
                }),
          ],
        ),
      ),
    );
  }
}
