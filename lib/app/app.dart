import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluuter_boilerplate/app/app_localization.dart';
import 'package:fluuter_boilerplate/app_setup/languages/languages.dart';
import 'package:fluuter_boilerplate/application/app_theme/theme_cubit.dart';
import 'package:fluuter_boilerplate/application/languages/language_cubit.dart';
import 'package:fluuter_boilerplate/application/network_radio/networkradio_bloc.dart';
import 'package:fluuter_boilerplate/infrastructure/language_repo/language_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/theme_repo/theme_repo.dart';
import 'package:fluuter_boilerplate/screens/home_screen.dart';
import 'package:hive_flutter/adapters.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddThemeRepository addThemeRepository = AddThemeRepository(hive: Hive);
    LanguageRepository languageRepository = LanguageRepository(hive: Hive);
    AudioPlayer audioPlayer = AudioPlayer();

    return MultiBlocProvider(
      providers: [
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
}
