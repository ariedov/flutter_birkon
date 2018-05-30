import 'dart:async';

import 'package:birkon/localization/keys.dart';
import 'package:birkon/model/order/order.dart';
import 'package:flutter/material.dart';

class LocaleOrderProvider {

  final Locale locale;

  LocaleOrderProvider(BuildContext context) :
        this.locale = Localizations.localeOf(context);

  Future<Order> loadOrder() async {
    return new Future<Order>.sync(() {
      bool isHebrew = locale.languageCode == "he";
      return new Order(
          isHebrew ? HEBREW : TRANSLITERATION,
          isHebrew ? TRANSLITERATION : RUSSIAN,
          isHebrew ? RUSSIAN : HEBREW
      );
    });
  }
}