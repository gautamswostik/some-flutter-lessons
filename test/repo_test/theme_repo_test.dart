import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_box.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_setup.dart';
import 'package:fluuter_boilerplate/infrastructure/theme_repo/theme_repo.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    'Testing Theme Repository',
    () {
      late AddThemeRepository addThemeRepository;

      late HiveInterface mockHive;
      late Box<bool> mockBox;
      setUp(
        () async {
          mockHive = MockHiveInterface();
          mockBox = MockBox();
          addThemeRepository = AddThemeRepository(hive: mockHive);

          await HiveSetup.initHive();
        },
      );

      test('should cache the theme', () async {
        //arrange
        when(mockHive.openBox<bool>(HiveBox.themeBox))
            .thenAnswer((_) async => mockBox);
        //act
        await addThemeRepository.addTheme(true);
        //assert
        verify(mockBox.put('theme', true));
        verify(mockHive.openBox<bool>(HiveBox.themeBox));
      });

      test('should retrun boolean value', () async {
        //arrange
        when(mockHive.openBox<bool>(HiveBox.themeBox))
            .thenAnswer((_) async => mockBox);
        when(mockBox.get('theme', defaultValue: false)).thenAnswer((_) => true);
        //act
        final result = await addThemeRepository.getSavedTheme();
        //assert
        expect(result, true);
        verify(mockHive.openBox<bool>(HiveBox.themeBox));
        verify(mockBox.get('theme', defaultValue: false));
      });
    },
  );
}
