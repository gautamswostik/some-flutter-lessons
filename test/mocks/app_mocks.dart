import 'package:fluuter_boilerplate/application/app_theme/theme_cubit.dart';
import 'package:fluuter_boilerplate/infrastructure/theme_repo/theme_repo.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  ThemeCubit,
  HiveInterface,
  AddThemeRepository,
  Box,
])
void main() {}
