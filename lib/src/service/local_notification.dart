import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    
    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        log(payload!);
      },
    );
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    _notificationsPlugin.show(
      DateTime.now().microsecond, 
      message.notification!.title, 
      message.notification!.body, 
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "com.example.push_notification_app",
          "push_notification_app",
          importance: Importance.high,
          priority: Priority.high,
        )
      ),
      payload: message.data['message'],
    );
  }
}