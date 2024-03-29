import 'package:birkon/prayer/view/prayer_text.dart';
import 'package:birkon/utils.dart';
import 'package:common/dao/direction.dart';
import 'package:common/dao/translated_prayer.dart';
import 'package:flutter/material.dart';

class PrayerParagraph extends StatefulWidget {
  final TranslatedPrayer paragraph;
  final int languageCode;

  const PrayerParagraph(
      {Key key, this.paragraph, this.languageCode})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new ParagraphState();
}

class ParagraphState extends State<PrayerParagraph> {
  @override
  Widget build(BuildContext context) {
    final language = keyToLanguage(widget.languageCode);
    bool isLtr = widget.paragraph.get(language).direction ==
        Direction.ltr;
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment:
              isLtr ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: <Widget>[
            PrayerText(widget.paragraph.get(language)),
          ],
        ));
  }
}
