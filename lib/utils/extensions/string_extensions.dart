import 'package:flutter/cupertino.dart';
import 'package:fluuter_boilerplate/app/app_localization.dart';

extension StringExtension on String {
  String translateTo(BuildContext context) {
    return AppLocalization.of(context)!.translate(this);
  }
}
