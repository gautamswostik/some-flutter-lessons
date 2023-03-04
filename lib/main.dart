import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluuter_boilerplate/app/app.dart';
import 'package:fluuter_boilerplate/app/bloc_observer.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_setup.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/env/.env');
  await HiveSetup.initHive();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  /**
   * [FOR DefaultFirebaseOptions DO]
   * # Install the CLI if not already done so
    dart pub global activate flutterfire_cli

    # Run the `configure` command, select a Firebase project and platforms
    flutterfire configure
   */
  await initFirebase(firebaseOptions: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('Error in fetching the cameras: $e');
  }

  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}

Future<void> initFirebase({required FirebaseOptions firebaseOptions}) async {
  await Firebase.initializeApp(options: firebaseOptions);
  await requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint(await FirebaseMessaging.instance.getToken());
  } else {
    print("No Permission");
  }
}


///[FIRST YOU CREATE PROJECT IN FIREBASE]
///[AND SETUP YOUR MESSAGING]
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
