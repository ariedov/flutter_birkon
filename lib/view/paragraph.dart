import 'package:birkon/dao/translated_string.dart';
import 'package:birkon/view/prayer_text.dart';
import 'package:flutter/material.dart';

class PrayerParagraph extends StatefulWidget {
  final TranslatedString paragraph;
  final ParagraphClickListener listener;

  const PrayerParagraph({Key key, this.paragraph, this.listener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new ParagraphState();
}

class ParagraphState extends State<PrayerParagraph> {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
        onTap: () {
          widget.listener(widget.paragraph);
        },
        child: new Padding(
            padding: EdgeInsets.all(16.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new PrayerText(widget.paragraph.transliteration),
                new Align(
                  alignment: Alignment.bottomRight,
                  child: new RotatedBox(
                    quarterTurns: 1,
                    child: new Icon(
                      new IconData(0xe895,
                          fontFamily: 'MaterialIcons',
                          matchTextDirection: true),
                      size: 12.0,
                      textDirection: widget.paragraph.transliteration.direction,
                    ),
                  ),
                ),
              ],
            )));
  }
}

typedef void ParagraphClickListener(TranslatedString paragraph);
