import 'package:birkon/dao/translated_string.dart';
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
    return new Padding(
      padding: EdgeInsets.all(16.0),
      child: new GestureDetector(
          onTap: () {
            widget.listener(widget.paragraph);
          },
          child: new Text(
            widget.paragraph.transliteration.text,
            textDirection: widget.paragraph.transliteration.direction,
            style: new TextStyle(
              fontSize: 16.0,
            )
        )
      ),
    );
  }
}

typedef void ParagraphClickListener(TranslatedString paragraph);