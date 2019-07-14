import 'package:common/prayer_asset_loader.dart';
import 'package:flutter_web/material.dart';

class WebPrayerAssetLoader implements PrayerAssetLoader {

  @override
  Future<String> loadPrayerString(String path) {
    return rootBundle.loadString(path);
  }
}