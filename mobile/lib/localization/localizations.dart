import 'package:birkon/localization/he.dart' as hebrew;
import 'package:birkon/localization/keys.dart';
import 'package:birkon/localization/ru.dart' as russian;
import 'package:flutter/material.dart';

class AppLocalizations {

  static Map<String, Map<int, String>> _localizedValues = {
    'ru': russian.translations,
    'he': hebrew.translations
  };

  static String get(BuildContext context, int key) {
    String languageCode = LocaleProvider.getLanguageCode(context);
    return _localizedValues[languageCode][key];
  }

  static String getFromKey(BuildContext context, int key) {
    if (key == RUSSIAN || key == TRANSLITERATION) {
      return _localizedValues['ru'][key];
    }
    return _localizedValues['he'][key];
  }
}

class LocaleProvider {

  static String getLanguageCode(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    String languageCode = locale.languageCode;
    if (languageCode != 'ru' || languageCode != 'he') {
      languageCode = 'ru';
    }
    return languageCode;
  }
}