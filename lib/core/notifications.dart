import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  String notificationImg = 'notification_img.png';

  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const androidInitialize =
        AndroidInitializationSettings('drawable/notification_img');
    const iosInitialize = DarwinInitializationSettings();
    InitializationSettings initializationSettings =
        const InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static showReceivedMessageNotification(
      {id = 0,
      required String title,
      required String payload,
      required String body,
      required FlutterLocalNotificationsPlugin fln}) {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName');

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: const DarwinNotificationDetails());
    fln.show(id, title, body, notificationDetails);
  }
}

// static Future<void> scheduleNotification(
// {required String title,
// required String body,
// required DateTime scheduledDate,
// required int notificationId}) async {
// var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//     'channelId', 'channelName', channelDescription: 'channelDescription',
//     importance: Importance.high, priority: Priority.high);
// var iOSPlatformChannelSpecifics = IOSNotificationDetails();
// var platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//     iOS: iOSPlatformChannelSpecifics);
//
// await flutterLocalNotificationsPlugin.schedule(
// notificationId,
// title,
// body,
// scheduledDate,
// platformChannelSpecifics);
// }