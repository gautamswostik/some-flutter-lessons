import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_boilerplate/app_setup/languages/entity/language_entity.dart';
import 'package:fluuter_boilerplate/app_setup/languages/languages.dart';
import 'package:fluuter_boilerplate/infrastructure/language_repo/language_repo.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final LanguageRepository languageRepository;
  LanguageCubit({required this.languageRepository})
      : super(
          LanguageLoaded(
            locale: Locale(
              Languages.languages[0].languageCode,
            ),
          ),
        );

  void toggle(String languageCode) async {
    languageRepository.addLanguage(languageCode);

    emit(
      LanguageLoaded(
        locale: Locale(
          languageCode,
        ),
      ),
    );
  }

  void getLang() async {
    String entity = await languageRepository.getSavedLanguage();
    emit(
      LanguageLoaded(
        locale: Locale(
          entity,
        ),
      ),
    );
  }
}
