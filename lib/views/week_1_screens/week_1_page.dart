import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class Week1Page extends StatelessWidget {
  const Week1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Week 1',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            MyButton(
                label: "1. What is Flutter",
                callback: () {
                  Navigator.pushNamed(context, "flutter_intro_screen");
                }),
            MyButton(
                label: "2. Install Flutter",
                callback: () {
                  launchUrl(Uri.parse(
                      "https://docs.flutter.dev/get-started/install"));
                }),
            MyButton(
                label: "4. Dart Programming",
                callback: () {
                  Navigator.pushNamed(context, "dart_programming_screen");
                }),
            MyButton(
                label: "5. Debugging App",
                callback: () {
                  launchUrl(
                      Uri.parse("https://docs.flutter.dev/testing/debugging"));
                }),
            MyButton(
                label: "6. Life cycle/Activity",
                callback: () {
                  Navigator.pushNamed(context, "life_cycle_screen");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("InitState")));
                }),
            MyButton(
                label: "7. Navigation",
                callback: () {
                  Navigator.pushNamed(context, "navigation_screen");
                }),
            MyButton(
                label: "8. Pass Data between View Controllers",
                callback: () {
                  Navigator.pushNamed(context, "pass_data_screen");
                }),
          ],
        ),
      ),
    );
  }
}
