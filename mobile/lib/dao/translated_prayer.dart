import 'package:birkon/dao/directional_string.dart';
import 'package:birkon/localization/keys.dart';

class TranslatedPrayer {

  final DirectionalString russian;
  final DirectionalString transliteration;
  final DirectionalString hebrew;

  Map<int, DirectionalString> _translations = new Map();

  TranslatedPrayer(this.russian, this.transliteration, this.hebrew) {
    _translations[RUSSIAN] = russian;
    _translations[TRANSLITERATION] = transliteration;
    _translations[HEBREW] = hebrew;
  }

  DirectionalString get(int key) => _translations[key];
}