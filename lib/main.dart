// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_app/src/screen/notification_screen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
 	log(message.notification!.title.toString());
  log(message.notification!.body.toString());
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Print "to" for postman
    // FirebaseMessaging.instance.getToken().then((value) {
    //   log(value!);
    // });
    return const CupertinoApp(      
      home: NotificationScreen(),
    );
  }
}