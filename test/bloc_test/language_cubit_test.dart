import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_setup.dart';
import 'package:fluuter_boilerplate/app_setup/languages/languages.dart';
import 'package:fluuter_boilerplate/application/languages/language_cubit.dart';
import 'package:fluuter_boilerplate/infrastructure/language_repo/language_repo.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    'Testing Language cubit',
    () {
      late LanguageCubit mockLanguageCubit;
      late LanguageRepository mockLanguageRepository;

      setUp(() async {
        mockLanguageCubit = MockLanguageCubit();
        mockLanguageRepository = MockLanguageRepository();

        await HiveSetup.initHive();
      });

      test(
        'The cubit should emit Theme initial state',
        () {
          when(mockLanguageCubit.state).thenReturn(LanguageLoaded(
            locale: Locale(
              Languages.languages[0].languageCode,
            ),
          ));
          expect(mockLanguageCubit.state, isA<LanguageLoaded>());
          verify(mockLanguageCubit.state);
        },
      );

      blocTest<LanguageCubit, LanguageState>(
        "Should return LanguageLoaded State",
        setUp: () {
          when(mockLanguageCubit.toggle('en')).thenAnswer((_) => {
                const LanguageLoaded(
                  locale: Locale(
                    'en',
                  ),
                ),
              });
        },
        build: () => LanguageCubit(languageRepository: mockLanguageRepository),
        act: (bloc) {
          bloc.toggle('en');
        },
        expect: () => [isA<LanguageLoaded>()],
        verify: (bloc) {
          mockLanguageCubit.toggle('en');
        },
      );
      blocTest<LanguageCubit, LanguageState>(
        "Should return LanguageLoaded State",
        setUp: () {
          when(mockLanguageRepository.getSavedLanguage())
              .thenAnswer((_) async => 'lang');
          when(mockLanguageCubit.getLang()).thenAnswer((_) => {
                const LanguageLoaded(
                  locale: Locale(
                    'lang',
                  ),
                ),
              });
        },
        build: () => LanguageCubit(languageRepository: mockLanguageRepository),
        act: (bloc) {
          bloc.getLang();
        },
        expect: () => [isA<LanguageLoaded>()],
        verify: (bloc) {
          mockLanguageRepository.getSavedLanguage();
          mockLanguageCubit.getLang();
        },
      );
      tearDown(
        () {
          mockLanguageCubit.close();
        },
      );
    },
  );
}
