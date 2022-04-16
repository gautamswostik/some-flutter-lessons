import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/app_theme/theme_cubit.dart';
import 'package:fluuter_boilerplate/infrastructure/theme_repo/theme_repo.dart';
import 'package:fluuter_boilerplate/screens/home_screen.dart';
import 'package:hive_flutter/adapters.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddThemeRepository addThemeRepository = AddThemeRepository(hive: Hive);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) =>
              ThemeCubit(addThemeRepository: addThemeRepository)..getTheme(),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ThemeLoaded) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeScreen(themeValue: state.isDarkValue),
              theme: state.isDark,
              themeMode: ThemeMode.system,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
