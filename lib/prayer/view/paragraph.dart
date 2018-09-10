import 'package:birkon/dao/translated_prayer.dart';
import 'package:birkon/prayer/view/prayer_text.dart';
import 'package:flutter/material.dart';

class PrayerParagraph extends StatefulWidget {
  final TranslatedPrayer paragraph;
  final int languageCode;
  final ParagraphClickListener listener;

  const PrayerParagraph(
      {Key key, this.paragraph, this.languageCode, this.listener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new ParagraphState();
}

class ParagraphState extends State<PrayerParagraph> {
  @override
  Widget build(BuildContext context) {
    bool isLtr = widget.paragraph.get(widget.languageCode).direction ==
        TextDirection.ltr;
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment:
              isLtr ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: <Widget>[
            PrayerText(widget.paragraph.get(widget.languageCode)),
          ],
        ));
  }
}

typedef void ParagraphClickListener(TranslatedPrayer paragraph);
