import 'dart:async';

import 'package:common/prayer_asset_loader.dart';
import 'package:flutter/widgets.dart';

class FlutterPlayerAssetLoader implements PrayerAssetLoader {
  FlutterPlayerAssetLoader(this._context);

  final BuildContext _context;

  @override
  Future<String> loadPrayerString(String path) {
    return DefaultAssetBundle.of(_context).loadString(path);
  }
}
