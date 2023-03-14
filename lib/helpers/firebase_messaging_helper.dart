import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  if (message.notification != null) {
    var android = AndroidNotificationDetails(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      icon: "mipmap/launcher_icon",
      channelDescription: 'description',
      priority: Priority.high,
      importance: Importance.max,
    );

    var iOS = const DarwinNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: iOS);

    await FlutterLocalNotificationsPlugin().show(
      0,
      message.notification!.title,
      message.notification!.body,
      platform,
    );
  }
}

class FireBaseMessagingHelper {
  FireBaseMessagingHelper._();
  static final FireBaseMessagingHelper fireBaseMessagingHelper = FireBaseMessagingHelper._();

  Future<void> initializeNotification() async {
    final token = await FirebaseMessaging.instance.getToken();

    print(token);

    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen(backgroundMessageHandler);
    }
  }
}
