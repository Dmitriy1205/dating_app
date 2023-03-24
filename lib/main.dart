import 'package:dating_app/core/service_locator.dart' as sl;
import 'package:dating_app/ui/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Notifications.scheduleNotification(
  //     title: 'My Notification Title',
  //     body: 'This is the notification body',
  //     scheduledDate: DateTime.now().add(Duration(seconds: 10)),
  //     notificationId: 0);
  await sl.boot();
  await sl.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}
