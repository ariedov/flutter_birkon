import 'package:birkon/dao/directional_string.dart';
import 'package:birkon/dao/translated_prayer.dart';
import 'package:birkon/localization/keys.dart';
import 'package:flutter/material.dart';

class OrderProvider {

  final Locale locale;

  List<int> _order = new List(3);

  OrderProvider(BuildContext context) :
        this.locale = Localizations.localeOf(context)
  {
    bool isHebrew = locale.languageCode == "he";
    _order[0] = isHebrew ? HEBREW : TRANSLITERATION;
    _order[1] = isHebrew ? TRANSLITERATION : RUSSIAN;
    _order[2] = isHebrew ? RUSSIAN : HEBREW;
  }

  int get primary => _order[0];
  int get secondary => _order[1];
  int get ternary => _order[2];
}