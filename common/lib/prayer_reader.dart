import 'dart:async';
import 'dart:convert';

import 'package:common/dao/direction.dart';
import 'package:common/prayer.dart';
import 'package:common/prayer_asset_loader.dart';

import 'dao/directional_string.dart';
import 'dao/translated_prayer.dart';

class PrayerReader {
  PrayerReader(this._assetLoader);

  final PrayerAssetLoader _assetLoader;

  Future<Prayer> readPrayer(String path) async {
    final prayer = await _assetLoader.loadPrayerString(path);
    Map<String, dynamic> decodedPrayer = json.decode(prayer);

    TranslatedPrayer title = TranslatedPrayer(
        DirectionalString(decodedPrayer["title"]["ru"], Direction.ltr),
        DirectionalString(
            decodedPrayer["title"]["transliteration"], Direction.ltr),
        DirectionalString(decodedPrayer["title"]["he"], Direction.rtl));

    List<TranslatedPrayer> paragraphs = new List();
    for (dynamic paragraph in decodedPrayer["paragraphs"]) {
      paragraphs.add(new TranslatedPrayer(
          new DirectionalString(paragraph["ru"], Direction.ltr),
          new DirectionalString(
              paragraph["transliteration"], Direction.ltr),
          new DirectionalString(paragraph["he"], Direction.rtl)));
    }

    return new Prayer(title, paragraphs);
  }
}
