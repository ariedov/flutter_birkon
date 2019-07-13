import 'package:common/dao/language.dart';

import 'localization/keys.dart';

Language keyToLanguage(int key) {
  switch(key) {
    case RUSSIAN: 
      return Language.russian;
    case TRANSLITERATION:
      return Language.transliteration;
    case HEBREW:
      return Language.hebrew;
    default:
      throw Exception("No such langauge: $key");
  }
}