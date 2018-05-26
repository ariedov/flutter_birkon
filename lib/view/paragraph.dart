import 'package:birkon/dao/translated_string.dart';
import 'package:birkon/view/prayer_text.dart';
import 'package:flutter/material.dart';

class PrayerParagraph extends StatefulWidget {
  final TranslatedString paragraph;
  final ParagraphClickListener listener;

  const PrayerParagraph(
      {Key key, this.paragraph, this.listener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new ParagraphState();
}

class ParagraphState extends State<PrayerParagraph> {

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        widget.listener(widget.paragraph);
      },
      child: new PrayerText(widget.paragraph.transliteration)
    );
  }
}

typedef void ParagraphClickListener(TranslatedString paragraph);