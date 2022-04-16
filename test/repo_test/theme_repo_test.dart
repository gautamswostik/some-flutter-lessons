import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_box.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_setup.dart';
import 'package:fluuter_boilerplate/infrastructure/theme_repo/theme_repo.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    'Testing Theme Repository',
    () {
      late AddThemeRepository hiveMovieSearchRepo;
      setUp(
        () async {
          hiveMovieSearchRepo = MockAddThemeRepository();
          await HiveSetup.initHive();
        },
      );

      test('should return true when called getSavedTheme', () async {
        //arrange
        when(hiveMovieSearchRepo.getSavedTheme()).thenAnswer((_) async => true);
        //act
        final result = await hiveMovieSearchRepo.getSavedTheme();
        //assert
        verify((hiveMovieSearchRepo.getSavedTheme()));
        expect(result, true);
      });
    },
  );
}
