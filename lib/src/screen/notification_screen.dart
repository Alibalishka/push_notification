import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:push_notification_app/src/service/local_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String notMsg = "Notification";
  @override
  void initState() {
    super.initState();
    
    LocalNotificationService.initialize();

    // Terminated state
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if(event != null){
        setState(() {
        notMsg = "${event.notification!.title} ${event.notification!.body} I am coming terminated state!";
      });
      }
    });

    // Foreground state
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.createanddisplaynotification(event);
      setState(() {
        notMsg = "${event.notification!.title} ${event.notification!.body} I am coming foreground!";
      });
    });

    // Background state
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notMsg = "${event.notification!.title} ${event.notification!.body} I am coming background!";
      });
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              notMsg, 
              textAlign: TextAlign.center,
            ),
          ],
        )
      ),
    );
  }
}