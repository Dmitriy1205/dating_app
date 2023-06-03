import 'dart:convert';

import 'package:dating_app/core/constants.dart';
import 'package:http/http.dart' as http;

import '../../core/services/fcm_service.dart';

class NotificationRepository {
  final FCMService messaging;

  NotificationRepository({required this.messaging});

  Future<String?> getToken() async {
    return await messaging.getToken();
  }

  void cancelNotification() {
    messaging.cancelNotification();
  }

  Future<void> sendMessage({
    required String token,
    required String body,
    required String title,
    required String type,
  }) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAA9ucQhcE:APA91bHensA-2bdaoN7fP7NnWFavy48A1XBg19SqFwMx1WgBSwa5OOzcodc1vrIWOJL6EobBw2aayGjSTDIPQMqeDGDO2f3ZLButdIv0Ksf3vlehxLda5g2dgdGkx_sTyc2_riou6E6l'
          },
          body: jsonEncode({
            'notification': {
              'title': title,
              'body': body,
              "content_available": true,
              "mutable_content": true,
              "priority": "high",
              "sound": "default",
            },
            'data': {
              'type': type,
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
            'to': token,
          }));
      //     .then((response) {
      //   if (response.statusCode == 200) {
      //     print('Message sent successfully');
      //   } else {
      //     print('Message failed to send: ${response.reasonPhrase}');
      //   }
      // }).catchError((error) => print('Error sending message: $error'));
    } catch (e) {}
  }

  Future<void> sendCall({
    required String token,
    required String body,
    required String title,
    required String type,
  }) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAOoWmKl4:APA91bGNqsUFO6OQHvKuD92tiOtOeGck4BpOTBQs8NrBS9YzoxOy6VrtxpFIW6t-zklKMaLX_hYW-B6e6AKCxgP9V4zPv_6xIQ4oEEGkPPYZIEa3jXbg0xaPp0LAGb17orlpnhUayHE1'
          },
          body: jsonEncode({
            'notification': {
              'title': title,
              'body': body,
              "content_available": true,
              "mutable_content": true,
              "priority": "high",
              "sound": 'incoming_call.mp3',
            },
            'data': {
              'type': type,
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
            'to': token,
          }));
      //     .then((response) {
      //   if (response.statusCode == 200) {
      //     print('Message sent successfully');
      //   } else {
      //     print('Message failed to send: ${response.reasonPhrase}');
      //   }
      // }).catchError((error) => print('Error sending message: $error'));
    } catch (e) {}
  }
}
