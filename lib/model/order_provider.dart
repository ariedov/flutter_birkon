import 'package:birkon/dao/directional_string.dart';
import 'package:birkon/dao/translated_prayer.dart';
import 'package:birkon/localization/keys.dart';
import 'package:flutter/material.dart';

class OrderProvider {

  final Locale locale;
  final TranslatedPrayer translatedPrayer;

  List<StringWithTitle> _order = new List(3);

  OrderProvider(BuildContext context, this.translatedPrayer) :
        this.locale = Localizations.localeOf(context)
  {
    bool isHebrew = locale.languageCode == "he";
    _order[0] = isHebrew
        ? new StringWithTitle(translatedPrayer.hebrew, HEBREW)
        : new StringWithTitle(translatedPrayer.transliteration, TRANSLITERATION);
    _order[1] = isHebrew
        ? new StringWithTitle(translatedPrayer.transliteration, TRANSLITERATION)
        : new StringWithTitle(translatedPrayer.russian, RUSSIAN);
    _order[2] = isHebrew
        ? new StringWithTitle(translatedPrayer.russian, RUSSIAN)
        : new StringWithTitle(translatedPrayer.hebrew, HEBREW);
  }

  DirectionalString get primary => _order[0].string;
  DirectionalString get secondary => _order[1].string;
  DirectionalString get ternary => _order[2].string;

  int get primaryTitle => _order[0].titleKey;
  int get secondaryTitle => _order[1].titleKey;
  int get ternaryTitle => _order[2].titleKey;
}

class StringWithTitle {
  final DirectionalString string;
  final int titleKey;

  StringWithTitle(this.string, this.titleKey);
}