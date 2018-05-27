import 'package:flutter/material.dart';

const String RUSSIAN = "russian";
const String TRANSLIATERATION = "transliteration";
const String HEBREW = "hebrew";

class AppLocalizations {

  static Map<String, Map<String, String>> _localizedValues = {
    'ru': {
      RUSSIAN: "Русский",
      TRANSLIATERATION: "Транслитерация",
      HEBREW: "Иврит",
    },

    'he': {
      RUSSIAN: "רוסית",
      TRANSLIATERATION: "תעתיק",
      HEBREW: "עברית",
    }
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