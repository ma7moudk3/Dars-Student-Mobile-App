import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../constants/exports.dart';

class FcmHelper {
  // FCM Messaging >> FCM = Firebase Cloud Messaging
  static late FirebaseMessaging messaging;

  // Notification lib
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// this function will initialize firebase and fcm instance
  static Future<void> initFcm() async {
    try {
      // initialize fcm and firebase core
      // uncomment the 4 comments below if you didn't already initialize firebase in the main
      // await Firebase.initializeApp(
      //     //  only uncomment this line if you set up firebase vie firebase cli
      //     // options: DefaultFirebaseOptions.currentPlatform,
      //     );
      messaging = FirebaseMessaging.instance;
      // initialize notifications channel and libraries
      await _initNotification();

      // notification settings handler
      await _setupFcmNotificationSettings();

      // background and foreground handlers
      FirebaseMessaging.onMessage.listen(_fcmForegroundHandler);
      FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
      // listen to notifications clicks
    } catch (error) {
      log(error.toString());
    }
  }

  static Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  static void _handleMessage(RemoteMessage message) async {
    log('onMessageOpenedApp ${message.data}');
    Map<String, dynamic> data = message.data;
    log('onMessageOpenedApp $data');
    switch (data['type']) {
      
    }
  }

  ///handle fcm notification settings (sound,badge..etc)
  static Future<void> _setupFcmNotificationSettings() async {
    //show notification with sound and badge
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );
    //NotificationSettings settings
    await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      announcement: false,
      criticalAlert: false,
      provisional: false,
      carPlay: false,
    );
  }

  ///handle fcm notification when app is closed/terminated
  static Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
    // _showNotification(
    //   id: 1,
    //   title: message.notification?.title ?? 'Title',
    //   body: message.notification?.body ?? 'Body',
    // );
    if (message.notification != null) {
      //No need for showing Notification manually.
      //For BackgroundMessages: Firebase automatically sends a Notification.
      //If you call the flutterLocalNotificationsPlugin.show()-Methode for
      //example the Notification will be displayed twice.
    } else {
      showNotification(message, "${message.data}");
    }
  }

  //handle fcm notification when app is open
  static Future<void> _fcmForegroundHandler(RemoteMessage message) async {
    // _showNotification(
    //   id: 1,
    //   title: message.notification?.title ?? 'Title',
    //   body: message.notification?.body ?? 'Body',
    //   // icon: '@drawable/ic_launcher',
    //   // largeIcon: DrawableResourceAndroidBitmap('@mipmap/athr_icon'),
    // );
    showNotification(message, "${message.data}");
  }

  static showNotification(RemoteMessage message, String payload) async {
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'high_importance_channel', 'High Importance Notifications',
        // sound: const RawResourceAndroidNotificationSound('notification'),
        playSound: true,
        enableVibration: true,
        visibility: NotificationVisibility.public,
        enableLights: true,
        autoCancel: true,
        color: Colors.white,
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        additionalFlags: Int32List.fromList(<int>[16 * (0x00000010)]),
        importance: Importance.high,
        priority: Priority.high);
    var notificationDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    log('message.    ${message.messageId}');
    Map<String, dynamic> data = message.data;
    String body = data['body'] ?? "Body";
    // log('message ${message.notification!.title}');
    log('message.data ${message.data}');
    log('my payload $payload');
    await flutterLocalNotificationsPlugin
        .show(200, 'Athr Online', body, notificationDetails, payload: payload);
  }

  ///init notifications channels
  static _initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      '@drawable/athr_icon',
    );

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      final NotificationAppLaunchDetails? details =
          await flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      log("test me !-> ${details!.notificationResponse!.payload}");
      log("test me !-> $details");

      // log('payload $payload');
      // List<String> str =
      //     payload!.replaceAll("{", "").replaceAll("}", "").split(",");
      // Map<String, dynamic> data = {};
      // for (int i = 0; i < str.length; i++) {
      //   List<String> s = str[i].split(":");
      //   log("s.length ${s.length}");
      //   log(s.toString());
      //   log("s[0]");
      //   log(s[0]);
      //   data.putIfAbsent(s[0].trim(), () => s[1].trim());
      // }
      // print('data $data');
      // switch (data['type']) {

      // }
    });
  }
}
