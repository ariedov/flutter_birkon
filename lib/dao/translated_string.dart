import 'package:birkon/dao/directional_string.dart';

class TranslatedString {

  final DirectionalString russian;
  final DirectionalString transliteration;
  final DirectionalString hebrew;

  TranslatedString(this.russian, this.transliteration, this.hebrew);
}