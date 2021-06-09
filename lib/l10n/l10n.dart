import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('it'),
  ];

  static String getFlag(String code) {
    switch (code) {
      /*case 'ar':
        return '🇦🇪';
      case 'hi':
        return '🇮🇳';
      case 'es':
        return '🇪🇸';
      case 'de':
        return '🇩🇪';*/
      case 'it':
        return 'it';
      case 'en':
      default:
        return '🇺🇸';
    }
  }
}
