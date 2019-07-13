import 'dart:io';

import 'package:common/dao/direction.dart';
import 'package:common/prayer_asset_loader.dart';
import 'package:common/prayer_reader.dart';
import 'package:test/test.dart';

void main() {
  PrayerReader reader;

  setUp(() {
    reader = PrayerReader(TestPrayerAssetLoader());
  });

  test("test prayer parsing", () async {
    final prayer = await reader.readPrayer("test/assets/shma_israel.json");
    expect(prayer.title.hebrew.text, "שְׁמַע יִשְׂרָאֵל");
    expect(prayer.title.hebrew.direction, Direction.rtl);

    expect(prayer.title.russian.text, "Слушай, Израиль");
    expect(prayer.title.russian.direction, Direction.ltr);

    expect(prayer.title.transliteration.text, "Шма Исраэль");
    expect(prayer.title.transliteration.direction, Direction.ltr);
  });
}

class TestPrayerAssetLoader implements PrayerAssetLoader {
  @override
  Future<String> loadPrayerString(String path) async {
    final file = File(path);
    return file.readAsStringSync();
  }
}
