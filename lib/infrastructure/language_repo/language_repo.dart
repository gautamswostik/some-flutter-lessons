import 'package:fluuter_boilerplate/app_setup/hive/hive_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IAddLanguageRepository {
  Future<void> addLanguage(String languageCode);

  Future<String> getSavedLanguage();
}

class LanguageRepository extends IAddLanguageRepository {
  LanguageRepository({required this.hive});
  final HiveInterface hive;

  @override
  Future<void> addLanguage(String languageCode) async {
    final languageBox = await hive.openBox(HiveBox.languageBox);
    await languageBox.put('language', languageCode);
  }

  @override
  Future<String> getSavedLanguage() async {
    final languageBox = await hive.openBox(HiveBox.languageBox);
    String entity = languageBox.get('language');
    return entity;
  }
}
