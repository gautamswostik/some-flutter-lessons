import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluuter_boilerplate/app/app.dart';
import 'package:fluuter_boilerplate/app/bloc_observer.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_setup.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/env/.env');
  await HiveSetup.initHive();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('Error in fetching the cameras: $e');
  }
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
      BlocOverrides.current;
    },
    blocObserver: AppBlocObserver(),
  );
}
