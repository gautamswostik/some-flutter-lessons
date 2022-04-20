import 'package:equatable/equatable.dart';

class LanguageEntity extends Equatable {
  final String languageCode;
  final String languageName;

  const LanguageEntity({
    required this.languageCode,
    required this.languageName,
  });

  @override
  List<Object?> get props => [languageCode, languageName];
}
