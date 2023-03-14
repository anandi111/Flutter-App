import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';

class CrashlyticsScreen extends StatefulWidget {
  const CrashlyticsScreen({Key? key}) : super(key: key);

  @override
  State<CrashlyticsScreen> createState() => _CrashlyticsScreenState();
}

class _CrashlyticsScreenState extends State<CrashlyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Crashlytics"),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: MyButton(
            label: "Crash",
            callback: () async {
              // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
              FirebaseCrashlytics.instance.crash();
            }),
      ),
    );
  }
}
