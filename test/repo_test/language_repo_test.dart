import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_box.dart';
import 'package:fluuter_boilerplate/infrastructure/language_repo/language_repo.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    'Testing Language Repository',
    () {
      late LanguageRepository languageRepository;
      late HiveInterface mockHive;
      late Box mockBox;
      setUp(
        () {
          mockHive = MockHiveInterface();
          mockBox = MockBox();
          languageRepository = LanguageRepository(hive: mockHive);
        },
      );
      test(
        'Testing Add language method',
        () async {
          //arange
          when(mockHive.openBox(HiveBox.languageBox))
              .thenAnswer((_) async => mockBox);
          //act
          await languageRepository.addLanguage('en');
          //assert
          verify(mockBox.put('language', 'en'));
          verify(mockHive.openBox(HiveBox.languageBox));
        },
      );

      test(
        'Testing Get Saved Language',
        () async {
          //arange
          when(mockHive.openBox(HiveBox.languageBox))
              .thenAnswer((_) async => mockBox);
          when(mockBox.get('language')).thenAnswer((_) => 'en');
          //act
          final result = await languageRepository.getSavedLanguage();
          //assert
          expect(result, 'en');
          verify(mockHive.openBox(HiveBox.languageBox));
          verify(mockBox.get('language'));
        },
      );
    },
  );
}
