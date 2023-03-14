import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Week9Page extends StatelessWidget {
  const Week9Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Week 9 & 10"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
                label: "Authentication",
                callback: () async {
                  final prefs = await SharedPreferences.getInstance();

                  bool? isWelcome = prefs.getBool('isWelcome');

                  if (isWelcome == true) {
                    Navigator.of(context).pushNamed("welcome_page");
                  } else {
                    Navigator.of(context).pushNamed("login_page");
                  }
                }),
            MyButton(
                label: "RealTime Database",
                callback: () {
                  Navigator.of(context).pushNamed("realtime_database_screen");
                }),
            MyButton(
                label: "FirebaseStore Database",
                callback: () {
                  Navigator.of(context).pushNamed("firebase_database_screen");
                }),
            MyButton(
                label: "Analytics",
                callback: () {
                  Navigator.of(context).pushNamed("analytics_screen");
                }),
            MyButton(
                label: "Crashlytics",
                callback: () {
                  Navigator.of(context).pushNamed("crashlytics_screen");
                }),
            MyButton(
                label: "Dynamic Links",
                callback: () {
                  Navigator.of(context).pushNamed("dynamic_link_screen");
                }),
            MyButton(
                label: "Notification",
                callback: () {
                  Navigator.of(context).pushNamed("notification_screen");
                }),
          ],
        ),
      ),
    );
  }
}
