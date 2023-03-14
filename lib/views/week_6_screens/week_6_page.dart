import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class Week6Page extends StatefulWidget {
  const Week6Page({Key? key}) : super(key: key);

  @override
  State<Week6Page> createState() => _Week6PageState();
}

class _Week6PageState extends State<Week6Page> {
  // AnimationController animationController;
  //
  // @override
  // void initState() {
  //   animationController.
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Week 6 Page"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
                label: "Share",
                callback: () {
                  Navigator.of(context).pushNamed("share_screen");
                }),
            MyButton(
                label: "Google Ads",
                callback: () {
                  Navigator.of(context).pushNamed("google_ads_screen");
                }),
            MyButton(
                label: "Facebook Ads",
                callback: () {
                  Navigator.of(context).pushNamed("facebook_ads_screen");
                }),
          ],
        ),
      ),
    );
  }
}
