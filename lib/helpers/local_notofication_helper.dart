import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:training_app/views/week_9&10_screens/screen.dart';

class LocalNotificationHelper {
  LocalNotificationHelper._();
  static final LocalNotificationHelper localNotificationHelper = LocalNotificationHelper._();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initLocalNotificationSettings(BuildContext context) {
    var initializationSettingsAndroid = const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOs = const DarwinInitializationSettings();

    var initSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      String? payload = notificationResponse.payload;

      if (payload == "First") {
        print("Entered into First Screen Sucessfully..");
        Navigator.push(
            context as BuildContext,
            MaterialPageRoute(
              builder: (context) => Screen(title: payload!),
            ));

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("First Page")));
      } else if (payload == "Second") {
        print("Entered into Second Screen Sucessfully..");

        Navigator.push(
            context as BuildContext,
            MaterialPageRoute(
              builder: (context) => Screen(title: payload!),
            ));

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Second Page")));
      } else if (payload == "Third") {
        print("Entered into Third Screen Sucessfully..");

        Navigator.push(
            context as BuildContext,
            MaterialPageRoute(
              builder: (context) => Screen(title: payload!),
            ));

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Third Page")));
      }
      print("else");
    });
  }

  Future<void> showSimpleNotification({required String payload}) async {
    var android = const AndroidNotificationDetails(
      'id',
      'channel ',
      icon: "mipmap/launcher_icon",
      channelDescription: 'description',
      priority: Priority.high,
      importance: Importance.max,
    );

    var iOS = const DarwinNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.show(0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: payload);
  }

  Future<void> showScheduledNotification() async {
    var scheduledNotificationDateTime = DateTime.now().add(const Duration(seconds: 5));

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      icon: 'mipmap/launcher_icon',
      priority: Priority.high,
      importance: Importance.max,
      largeIcon: DrawableResourceAndroidBitmap('mipmap/launcher_icon'),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    // await flutterLocalNotificationsPlugin.zonedSchedule(0, "Notification Title", "This is the Notification Body!",
    //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), platformChannelSpecifics,
    //     androidAllowWhileIdle: true,
    //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);

    await flutterLocalNotificationsPlugin.schedule(
        0, 'scheduled title', 'scheduled body', scheduledNotificationDateTime, platformChannelSpecifics);
  }

  Future<void> showPeriodicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      channelDescription: 'repeating description',
      priority: Priority.high,
      importance: Importance.max,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.periodicallyShow(
        0, 'repeating title', 'repeating body', RepeatInterval.everyMinute, notificationDetails,
        androidAllowWhileIdle: true);
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("mipmap/launcher_icon"),
      largeIcon: DrawableResourceAndroidBitmap("mipmap/launcher_icon"),
      contentTitle: 'flutter devs',
      summaryText: 'summaryText',
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'big text channel id',
      'big text channel name',
      channelDescription: 'big text channel description',
      styleInformation: bigPictureStyleInformation,
      priority: Priority.high,
      importance: Importance.max,
    );

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: null);

    await flutterLocalNotificationsPlugin.show(0, 'big text title', 'silent body', platformChannelSpecifics,
        payload: "big image notifications");
  }

  Future<void> showMediaStyleNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      channelDescription: 'media channel description',
      color: Colors.red,
      enableLights: true,
      largeIcon: DrawableResourceAndroidBitmap("mipmap/launcher_icon"),
      styleInformation: MediaStyleInformation(),
      priority: Priority.high,
      importance: Importance.max,
    );

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: null);

    await flutterLocalNotificationsPlugin.show(0, 'notification title', 'notification body', platformChannelSpecifics);
  }
}
