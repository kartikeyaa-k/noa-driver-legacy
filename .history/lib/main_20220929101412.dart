import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:noa_driver/core/controllers/address_controller.dart';
import 'package:noa_driver/core/environments/base_config.dart';
import 'package:noa_driver/core/models/communities_model.dart';
import 'package:noa_driver/core/models/sub_community_model.dart';
import 'package:noa_driver/splash/splash.dart';
import 'package:provider/provider.dart';
import 'locator/locator.dart';
import 'login-registration/login-controller.dart';
import 'order-details/order-controller.dart';

List<CommunityModel> mainCommunityList = [];
List<SubCommunityModel> mainSubCommunityList = [];

late FirebaseMessaging messaging;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  // print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  messaging = FirebaseMessaging.instance;

  const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );

  Environment().initConfig(environment);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'ic_launcher',
          ),
        ),
      );
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // print("App is open"+message.data.toString());
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  // print('User granted permission: ${settings.authorizationStatus}');

  await setupLocator();
  runApp(const MyApp());
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description,
    importance: Importance.high,
    playSound: true);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CustommerLoginController()),
        ChangeNotifierProvider(create: (context) => OrderController()),
        // LATEST
        // CONTACT KARTIKEYA
        ChangeNotifierProvider(create: (context) => AddressController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Nunito"),
        home: Splash(),
      ),
    );
  }
}
