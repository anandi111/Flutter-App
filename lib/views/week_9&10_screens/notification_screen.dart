import 'package:flutter/material.dart';
import 'package:training_app/helpers/local_notofication_helper.dart';
import 'package:training_app/utils/buttons.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

GlobalKey<ScaffoldState>? scaffoldKey;

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    LocalNotificationHelper.localNotificationHelper.initLocalNotificationSettings(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            MyButton(
                label: "First Screen Simple Notification",
                callback: () async {
                  await LocalNotificationHelper.localNotificationHelper.showSimpleNotification(payload: "First");
                }),
            MyButton(
                label: "Second Screen Simple Notification",
                callback: () async {
                  await LocalNotificationHelper.localNotificationHelper.showSimpleNotification(payload: "Second");
                }),
            MyButton(
                label: "Third Screen Simple Notification",
                callback: () async {
                  await LocalNotificationHelper.localNotificationHelper.showSimpleNotification(payload: "Third");
                }),
            MyButton(
                label: "Schedule Notification",
                callback: () async {
                  await LocalNotificationHelper.localNotificationHelper.showScheduledNotification();
                }),
            MyButton(
                label: "Periodic Notification",
                callback: () async {
                  await LocalNotificationHelper.localNotificationHelper.showPeriodicNotification();
                }),
            MyButton(
                label: "Big Picture Notification",
                callback: () async {
                  await LocalNotificationHelper.localNotificationHelper.showBigPictureNotification();
                }),
            MyButton(
                label: "Media Style Notification",
                callback: () async {
                  await LocalNotificationHelper.localNotificationHelper.showMediaStyleNotification();
                }),
          ],
        ),
      ),
    );
  }
}
