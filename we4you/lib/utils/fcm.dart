import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  // local notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init(BuildContext context) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('assets/we.png');
    var initializationSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );

    if (!_initialized) {
      // For iOS request permission first.
      // NotificationSettings settings = await firebaseMessaging.requestPermission(
      //   alert: true,
      //   announcement: false,
      //   badge: true,
      //   carPlay: false,
      //   criticalAlert: false,
      //   provisional: false,
      //   sound: true,
      // );

      firebaseMessaging.requestNotificationPermissions(
          IosNotificationSettings(sound: true, badge: true, alert: true));
      firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });

      firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          _demoNotification(
            message['notification']['title'],
            message['notification']['body'],
          );
          print("onMessage: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );

      // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   _demoNotification(
      //     message.notification.title,
      //     message.notification.body,
      //   );
      // });

      // ignore: missing_return
      // FirebaseMessaging.onBackgroundMessage((RemoteMessage _) {});

      // String token = await firebaseMessaging.getToken();
      // print("FirebaseMessaging token: $token");
      _initialized = true;
    }
  }

  Future onSelectNotification(String payload) async {
    // showDialog(
    //   context: context,
    //   builder: (_) {
    //     return AlertDialog(
    //       title: Text("PayLoad"),
    //       content: Text("Payload : $payload"),
    //     );
    //   },
    // );
    debugPrint(payload);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID',
      'channel name',
      'channel description',
      importance: Importance.max,
      playSound: true,
      showProgress: true,
      priority: Priority.max,
    );

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }
}
