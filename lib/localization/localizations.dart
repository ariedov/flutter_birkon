import 'package:birkon/localization/he.dart' as hebrew;
import 'package:birkon/localization/ru.dart' as russian;
import 'package:flutter/material.dart';

class AppLocalizations {

  static Map<String, Map<String, String>> _localizedValues = {
    'ru': russian.translations,
    'he': hebrew.translations
  };

  static String get(BuildContext context, String key) {
    String languageCode = LocaleProvider.getLanguageCode(context);
    return _localizedValues[languageCode][key];
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