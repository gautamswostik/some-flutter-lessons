import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/app/app.dart';
import 'package:fluuter_boilerplate/app/bloc_observer.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSetup.initHive();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
      BlocOverrides.current;
    },
    blocObserver: AppBlocObserver(),
  );
}
