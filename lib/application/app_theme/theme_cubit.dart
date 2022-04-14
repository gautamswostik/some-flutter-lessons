import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/app_setup/theme/theme_choices.dart';
import 'package:fluuter_boilerplate/infrastructure/theme_repo/theme_repo.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final AddThemeRepository addThemeRepository;
  ThemeCubit({required this.addThemeRepository}) : super(ThemeInitial());
  void toggleTheme(bool isDark) async {
    addThemeRepository.addTheme(isDark);
    if (isDark) {
      emit(ThemeLoaded(
        isDark: ThemeChoice.darkMode,
        isDarkValue: isDark,
      ));
    } else {
      emit(ThemeLoaded(
        isDark: ThemeChoice.lightMode,
        isDarkValue: isDark,
      ));
    }
  }

  void getTheme() async {
    bool isDark = await addThemeRepository.getSavedTheme();
    if (isDark) {
      emit(ThemeLoaded(
        isDark: ThemeChoice.darkMode,
        isDarkValue: isDark,
      ));
    } else {
      emit(ThemeLoaded(
        isDark: ThemeChoice.lightMode,
        isDarkValue: isDark,
      ));
    }
  }
}
