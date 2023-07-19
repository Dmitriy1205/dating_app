import 'package:dating_app/core/utils/navigation_key.dart';
import 'package:dating_app/ui/screens/contacts_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../ui/bloc/register_call/register_call_cubit.dart';
import '../../ui/screens/home_screen.dart';
import '../../ui/screens/video_call_screen.dart';
import '../constants.dart';

class FCMService {
  final FirebaseMessaging? messaging;

  FCMService({
    required this.messaging,
  });

  Future<void> initializeFirebase() async {
    await messaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeLocalNotifications() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@drawable/notification_img"),
      iOS: DarwinInitializationSettings(),
    );
    await localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) async {
    if (response.payload == 'message') {
      navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (context) => const ContactsScreen()));
    } else {
      BlocListener<RegisterCallCubit, RegisterCallState>(
        listener: (context, state) {
          if (state.inCallStatus == IncomingCallStatus.successIncomingCall) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => VideoCallScreen(
                  receiverId: state.callModel!.receiverId!,
                  id: state.callModel!.id,
                  isReceiver: true,
                )));
          }
        },
        child: const HomeScreen(),
      );
      // navigatorKey.currentState
      //     ?.push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  void cancelNotification() {
    localNotificationsPlugin.cancel(0);
  }

  NotificationDetails platformChannelSpecifics = const NotificationDetails(
      android: AndroidNotificationDetails(
        "channel id",
        "channel name",
        priority: Priority.high,
        importance: Importance.max,
        playSound: true,
      ),
      iOS: DarwinNotificationDetails(presentSound: true));

  Future<void> onMessage({String? title, String? body}) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await localNotificationsPlugin.show(
        0,
        title ?? message.notification!.title,
        body ?? message.notification!.body,
        platformChannelSpecifics,
        payload: message.data['type'],
      );
    });
  }

  Future<String?> getToken() async {
    String? token = await messaging!.getToken();
    return token;
  }
}
