import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  String notification_img = 'notification_img.png';

  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const androidInitialize =
        AndroidInitializationSettings('drawable/notification_img');
    final iosInitialize = DarwinInitializationSettings();
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static showReceivedMessageNotification(
      {id = 0,
      required String title,
      required String payload,
      required String body,
      required FlutterLocalNotificationsPlugin fln}) {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName');

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: DarwinNotificationDetails());
    fln.show(id, title, body, notificationDetails);
  }
}
