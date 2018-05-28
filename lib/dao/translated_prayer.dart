import 'package:birkon/dao/directional_string.dart';

class TranslatedPrayer {

  final DirectionalString russian;
  final DirectionalString transliteration;
  final DirectionalString hebrew;

  TranslatedPrayer(this.russian, this.transliteration, this.hebrew);
}