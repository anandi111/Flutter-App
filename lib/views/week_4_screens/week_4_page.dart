import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Week4Page extends StatefulWidget {
  const Week4Page({Key? key}) : super(key: key);

  @override
  State<Week4Page> createState() => _Week4PageState();
}

class _Week4PageState extends State<Week4Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Week 4"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
                label: "15. Lazy Loading",
                callback: () {
                  Navigator.pushNamed(context, "lazy_loading_screen");
                }),
            MyButton(
                label: "16. Map Integration",
                callback: () {
                  Navigator.pushNamed(context, "map_integration_screen");
                }),
            MyButton(
                label: "16.1. InAppWebView",
                callback: () {
                  Navigator.pushNamed(context, "inapp_webview_screen");
                }),
            MyButton(
                label: "17. Sent Email, Call, SMS",
                callback: () {
                  Navigator.pushNamed(context, "sent_call_sms_email_screen");
                }),
          ],
        ),
      ),
    );
  }
}
