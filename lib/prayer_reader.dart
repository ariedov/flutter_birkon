import 'dart:async';
import 'dart:convert';

import 'package:birkon/prayer.dart';
import 'package:flutter/material.dart';

class PrayerReader {

  Future<Prayer> readPrayer(BuildContext context) async {
    String prayer = await DefaultAssetBundle
        .of(context)
        .loadString("assets/prayers/birkat_hamazon.json");
    Map<String, dynamic> decodedPrayer = json.decode(prayer);

    TranslatedString title =
    new TranslatedString(
        decodedPrayer["title"]["ru"],
        decodedPrayer["title"]["transliteration"],
        decodedPrayer["title"]["he"]);

    List<TranslatedString> paragraphs = new List();
    for (dynamic paragraph in decodedPrayer["paragraphs"]) {
      paragraphs.add(new TranslatedString(
          paragraph["ru"],
          paragraph["transliteration"],
          paragraph["he"]));
    }

    return new Prayer(title, paragraphs);
  }
}
