import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Week8Page extends StatefulWidget {
  const Week8Page({Key? key}) : super(key: key);

  @override
  State<Week8Page> createState() => _Week8PageState();
}

class _Week8PageState extends State<Week8Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Week 8 Page"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
                label: "Animation",
                callback: () {
                  Navigator.pushNamed(context, "animation_screen");
                }),
            MyButton(
                label: "Different DPI",
                callback: () {
                  Navigator.pushNamed(context, "icon_density_screen");
                }),
            MyButton(
                label: "Responsive & Orientation",
                callback: () {
                  Navigator.pushNamed(context, "responsive_screen");
                }),
            MyButton(
                label: "Localization",
                callback: () {
                  Navigator.pushNamed(context, "localization_screen");
                }),
            MyButton(
                label: "Action Sheet & Popover ",
                callback: () {
                  Navigator.pushNamed(context, "action_sheet_and_popover_screen");
                }),
          ],
        ),
      ),
    );
  }
}
