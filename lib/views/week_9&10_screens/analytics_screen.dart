import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Analytics"),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            MyButton(
                label: "Test Event",
                callback: () async {
                  await FirebaseAnalytics.instance
                      .logEvent(
                        name: "Test_Event",
                        parameters: {"test_event": "Test"},
                      )
                      .then((value) => debugPrint("Successfully..."))
                      .onError((error, stackTrace) => debugPrint(error.toString()));
                }),
            MyButton(
                label: "Unique Event",
                callback: () async {
                  await FirebaseAnalytics.instance.setUserProperty(name: 'user1', value: 'unique_user_id');

                  await FirebaseAnalytics.instance.logEvent(name: 'Unique_Event');
                }),
            // MyButton(
            //     label: "Screen Event",
            //     callback: () async {
            //       await FirebaseAnalytics.instance.logScreenView(screenName: "firebase_analytics_screen");
            //     }),
          ],
        ),
      ),
    );
  }
}
