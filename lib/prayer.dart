class Prayer {
  final TranslatedString title;
  final List<TranslatedString> paragraphs;

  Prayer(this.title, this.paragraphs);
}

class TranslatedString {

  final String russian;
  final String transliteration;
  final String hebrew;

  TranslatedString(this.russian, this.transliteration, this.hebrew);
}