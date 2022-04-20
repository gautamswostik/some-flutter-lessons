import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_setup.dart';
import 'package:fluuter_boilerplate/app_setup/theme/theme_choices.dart';
import 'package:fluuter_boilerplate/application/app_theme/theme_cubit.dart';
import 'package:fluuter_boilerplate/infrastructure/theme_repo/theme_repo.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    'Testing Theme Cubit',
    () {
      late ThemeCubit mockThemeCubit;
      late AddThemeRepository mockAddThemeRepository;
      setUp(() async {
        mockThemeCubit = MockThemeCubit();
        mockAddThemeRepository = MockAddThemeRepository();
        await HiveSetup.initHive();
      });
      test(
        'The cubit should emit Theme initial state',
        () {
          when(mockThemeCubit.state).thenReturn(ThemeInitial());
          expect(mockThemeCubit.state, isA<ThemeInitial>());
          verify(mockThemeCubit.state);
        },
      );
      blocTest<ThemeCubit, ThemeState>(
        "Should return ThemeLoaded State for both true and false",
        setUp: () {
          when(mockThemeCubit.toggleTheme(true)).thenAnswer((_) =>
              {ThemeLoaded(isDark: ThemeChoice.darkMode, isDarkValue: true)});
        },
        build: () => ThemeCubit(addThemeRepository: mockAddThemeRepository),
        act: (bloc) {
          bloc.toggleTheme(true);
        },
        expect: () => [isA<ThemeLoaded>()],
        verify: (bloc) {
          mockThemeCubit.toggleTheme(true);
        },
      );
      
      blocTest<ThemeCubit, ThemeState>(
        "Should return ThemeLoaded State",
        setUp: () {
          when(mockAddThemeRepository.getSavedTheme())
              .thenAnswer((_) async => true);
          when(mockThemeCubit.getTheme()).thenAnswer((_) =>
              {ThemeLoaded(isDark: ThemeChoice.darkMode, isDarkValue: true)});
        },
        build: () => ThemeCubit(addThemeRepository: mockAddThemeRepository),
        act: (bloc) {
          bloc.getTheme();
        },
        expect: () => [isA<ThemeLoaded>()],
        verify: (bloc) {
          mockAddThemeRepository.getSavedTheme();
          mockThemeCubit.getTheme();
        },
      );

      tearDown(
        () {
          mockThemeCubit.close();
        },
      );
    },
  );
}
