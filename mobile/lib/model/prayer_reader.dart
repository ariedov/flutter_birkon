import 'dart:async';
import 'dart:convert';

import 'package:birkon/dao/directional_string.dart';
import 'package:birkon/dao/translated_prayer.dart';
import 'package:birkon/localization/keys.dart';
import 'package:birkon/model/prayer.dart';
import 'package:flutter/material.dart';

class PrayerReader {

  Future<Prayer> readPrayer(BuildContext context, int prayerId) async {
    String prayer = await DefaultAssetBundle
        .of(context)
        .loadString(_getPrayerPath(prayerId));
    Map<String, dynamic> decodedPrayer = json.decode(prayer);

    TranslatedPrayer title =
    new TranslatedPrayer(
        new DirectionalString(decodedPrayer["title"]["ru"], TextDirection.ltr),
        new DirectionalString(decodedPrayer["title"]["transliteration"], TextDirection.ltr),
        new DirectionalString(decodedPrayer["title"]["he"], TextDirection.rtl));

    List<TranslatedPrayer> paragraphs = new List();
    for (dynamic paragraph in decodedPrayer["paragraphs"]) {
      paragraphs.add(new TranslatedPrayer(
          new DirectionalString(paragraph["ru"], TextDirection.ltr),
          new DirectionalString(paragraph["transliteration"], TextDirection.ltr),
          new DirectionalString(paragraph["he"], TextDirection.rtl)));
    }

    return new Prayer(title, paragraphs);
  }

  String _getPrayerPath(int prayerId) {
    switch (prayerId) {
      case BIRKAT_HA_MAZON:
        return "assets/prayers/birkat_hamazon.json";
      case SHMA_ISRAEL:
        return "assets/prayers/shma_israel.json";
      default:
        return null;
    }
  }
}
