import 'package:fluuter_boilerplate/app_setup/hive/hive_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IAddThemeRepository {
  Future<void> addTheme(bool isDark);

  Future<bool> getSavedTheme();
}

class AddThemeRepository extends IAddThemeRepository {
  AddThemeRepository({required this.hive});
  final HiveInterface hive;
  @override
  Future<void> addTheme(bool isDark) async {
    final themeBox = await hive.openBox<bool>(HiveBox.themeBox);
    await themeBox.put('theme', isDark);
  }

  @override
  Future<bool> getSavedTheme() async {
    final themeBox = await _openBox(HiveBox.themeBox);
    bool theme = await themeBox.get('theme', defaultValue: false);
    return theme;
  }

  Future<Box> _openBox(String type) async {
    try {
      final box = await hive.openBox(type);
      return box;
    } catch (e) {
      throw Exception();
    }
  }
}
