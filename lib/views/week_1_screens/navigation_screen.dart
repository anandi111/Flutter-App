import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Navigation"),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(
                label: "Go to Page 1",
                callback: () {
                  Navigator.pushNamed(context, "page_1");
                }),
            MyButton(
                label: "Go to Page 2",
                callback: () {
                  Navigator.pushNamed(context, "page_2");
                }),
            MyButton(
                label: "Go to Page 3",
                callback: () {
                  Navigator.pushNamed(context, "page_3");
                }),
            MyButton(
                label: "Go to Page 4",
                callback: () {
                  Navigator.pushNamed(context, "page_4");
                }),
          ],
        ),
      ),
    );
  }
}
