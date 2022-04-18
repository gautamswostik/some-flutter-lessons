import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluuter_boilerplate/app_setup/languages/languages.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization? of(context) =>
      Localizations.of<AppLocalization>(context, AppLocalization);
  Map<String, dynamic> _localizedString = {};

  Future<bool> load() async {
    final jsonString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedString =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String translate(String key) {
    return _localizedString[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizatonDelegate();
}

class _AppLocalizatonDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizatonDelegate();

  @override
  bool isSupported(Locale locale) {
    return Languages.languages
        .map((e) => e.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale);
    await appLocalization.load();
    return appLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}
