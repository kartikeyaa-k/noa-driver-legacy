import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'order-details/order-controller.dart';

/// Custom instance of [BlocObserver] which logs
/// any state changes and errors.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      fatal: true,
      reason: '$bloc throws error',
    );
    super.onError(bloc, error, stackTrace);
  }
}

/// ----------------------------[BlocObserver]
///
///
///
///
///

List<CommunityModel> mainCommunityList = [];
List<SubCommunityModel> mainSubCommunityList = [];
String token = '';

late FirebaseMessaging messaging;
late FirebaseCrashlytics crashlytics;

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

  crashlytics = FirebaseCrashlytics.instance;

  await crashlytics.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.PROD,
  );

  Environment().initConfig(environment);

  Bloc.observer = AppBlocObserver();

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
            channel.id, channel.name,

            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'ic_launcher',
            playSound: true,
            sound: const RawResourceAndroidNotificationSound('ring'),
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
    sound: RawResourceAndroidNotificationSound('ring'),
    playSound: true);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final SetupOptions options =
        SetupOptionsBuilder('1f6d2021183954dea6a23436f452208c561d724f').build();
    Smartlook.setupAndStartRecording(options);
  }

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
      child: SmartlookHelperWidget(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Nunito"),
          home: Splash(),
        ),
      ),
    );
  }
}
