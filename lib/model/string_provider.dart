import 'package:birkon/dao/directional_string.dart';
import 'package:birkon/dao/translated_prayer.dart';
import 'package:birkon/localization/keys.dart';
import 'package:flutter/material.dart';

class StringProvider {

  final Locale locale;
  final TranslatedPrayer translatedPrayer;

  StringProvider(BuildContext context, this.translatedPrayer) :
        this.locale = Localizations.localeOf(context);

  DirectionalString get primary => translatedPrayer.transliteration;
  DirectionalString get secondary => translatedPrayer.russian;
  DirectionalString get ternary => translatedPrayer.hebrew;

  String get primaryTitle => TRANSLIATERATION;
  String get secondaryTitle => RUSSIAN;
  String get ternaryTitle => HEBREW;
}