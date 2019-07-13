import 'directional_string.dart';
import 'language.dart';

class TranslatedPrayer {

  final DirectionalString russian;
  final DirectionalString transliteration;
  final DirectionalString hebrew;

  Map<Language, DirectionalString> _translations = new Map();

  TranslatedPrayer(this.russian, this.transliteration, this.hebrew) {
    _translations[Language.russian] = russian;
    _translations[Language.transliteration] = transliteration;
    _translations[Language.hebrew] = hebrew;
  }

  DirectionalString get(Language language) => _translations[language];
}