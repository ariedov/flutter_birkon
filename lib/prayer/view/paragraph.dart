import 'package:birkon/model/string_provider.dart';
import 'package:birkon/prayer/view/prayer_text.dart';
import 'package:flutter/material.dart';

class PrayerParagraph extends StatefulWidget {
  final StringProvider paragraphProvider;
  final ParagraphClickListener listener;

  const PrayerParagraph({Key key, this.paragraphProvider, this.listener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new ParagraphState();
}

class ParagraphState extends State<PrayerParagraph> {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
        onTap: () {
          widget.listener(widget.paragraphProvider);
        },
        child: new Padding(
            padding: EdgeInsets.all(16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new PrayerText(widget.paragraphProvider.primary),
                new Align(
                  alignment: Alignment.bottomRight,
                  child: new RotatedBox(
                    quarterTurns: 1,
                    child: new Icon(
                      new IconData(0xe895,
                          fontFamily: 'MaterialIcons',
                          matchTextDirection: true),
                      size: 12.0,
                      textDirection: widget.paragraphProvider.primary.direction,
                    ),
                  ),
                ),
              ],
            )));
  }
}

typedef void ParagraphClickListener(StringProvider paragraph);
