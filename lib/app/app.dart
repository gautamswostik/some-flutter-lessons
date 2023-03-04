import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluuter_boilerplate/app/app_localization.dart';
import 'package:fluuter_boilerplate/app_setup/languages/languages.dart';
import 'package:fluuter_boilerplate/application/app_theme/theme_cubit.dart';
import 'package:fluuter_boilerplate/application/asset_audio/assetaudio_bloc.dart';
import 'package:fluuter_boilerplate/application/bloc_pattern/learn_bloc_bloc.dart';
import 'package:fluuter_boilerplate/application/device_audio/deviceaudio_bloc.dart';
import 'package:fluuter_boilerplate/application/infinite_list/infinite_list_bloc.dart';
import 'package:fluuter_boilerplate/application/languages/language_cubit.dart';
import 'package:fluuter_boilerplate/application/local_notes/local_notes_bloc.dart';
import 'package:fluuter_boilerplate/application/network_radio/networkradio_bloc.dart';
import 'package:fluuter_boilerplate/infrastructure/infinite_list_repo/infinite_list_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/language_repo/language_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/local_notes_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/theme_repo/theme_repo.dart';
import 'package:fluuter_boilerplate/notification_service.dart';
import 'package:fluuter_boilerplate/screens/home_screen.dart';
import 'package:fluuter_boilerplate/utils/common_mixin/wid_mixin.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    listenNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddThemeRepository addThemeRepository = AddThemeRepository(hive: Hive);
    LanguageRepository languageRepository = LanguageRepository(hive: Hive);
    GetPostsRepository getPostsRepository = GetPostsRepository();
    LocalNotesRepository localNotesRepository =
        LocalNotesRepository(hive: Hive, uuid: const Uuid());
    AudioPlayer audioPlayer = AudioPlayer();
    AudioCache audioCache = AudioCache();

    return MultiBlocProvider(
      providers: [
        BlocProvider<LearnBlocBloc>(
          create: (context) => LearnBlocBloc(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) =>
              ThemeCubit(addThemeRepository: addThemeRepository)..getTheme(),
        ),
        BlocProvider<LanguageCubit>(
          create: (context) =>
              LanguageCubit(languageRepository: languageRepository)..getLang(),
        ),
        BlocProvider<NetworkAudioBloc>(
          create: (context) => NetworkAudioBloc(
            audioPlayer: audioPlayer,
          ),
        ),
        BlocProvider<AssetAudioBloc>(
          create: (context) => AssetAudioBloc(
            audioPlayer: audioPlayer,
            audioCache: audioCache,
          ),
        ),
        BlocProvider<DeviceAudioBloc>(
          create: (context) => DeviceAudioBloc(
            audioPlayer: audioPlayer,
          ),
        ),
        BlocProvider<LocalNotesBloc>(
          create: (context) => LocalNotesBloc(
            localNotesRepository: localNotesRepository,
          ),
        ),
        BlocProvider<InfiniteListBloc>(
          create: (context) => InfiniteListBloc(
            getPosts: getPostsRepository,
          ),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                if (themeState is ThemeLoaded) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: HomeScreen(themeValue: themeState.isDarkValue),
                    // home: WidWithMixin(),
                    theme: themeState.isDark,
                    themeMode: ThemeMode.system,
                    supportedLocales: [
                      ...Languages.languages
                          .map((e) => Locale(e.languageCode))
                          .toList(),
                    ],
                    locale: state.locale,
                    localizationsDelegates: const [
                      AppLocalization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                  );
                }
                return const SizedBox();
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void listenNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      Map<String, dynamic> data = message.data;
      final FLutterBoilerPlateNotificationService _notificationService =
          FLutterBoilerPlateNotificationService();
      // _notificationService.showNotifications(
      //     " message.notification!.title", "S");

      if (data.containsKey("image")) {
        _notificationService.showImageNotification(
            data["image"], data["title"], data["message"]);
      } else {
        _notificationService.showNotifications(data["title"], data["message"]);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {});
  }
}

class WidWithMixin extends StatefulWidget {
  const WidWithMixin({Key? key}) : super(key: key);

  @override
  State<WidWithMixin> createState() => _WidWithMixinState();
}

class _WidWithMixinState extends State<WidWithMixin> with CustomScaffold {
  @override
  Widget body() {
    return ListView.builder(
      itemCount: 200,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            index.toString(),
          ),
        );
      },
    );
  }

  @override
  String get title => "Hello world";

  @override
  Color get appbarColor =>
      Theme.of(context).appBarTheme.backgroundColor ?? Colors.pink;
}
