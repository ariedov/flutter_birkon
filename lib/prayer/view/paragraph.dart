import 'package:birkon/dao/translated_prayer.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/prayer/view/prayer_text.dart';
import 'package:flutter/material.dart';

class PrayerParagraph extends StatefulWidget {
  final TranslatedPrayer paragraph;
  final Order order;
  final ParagraphClickListener listener;

  const PrayerParagraph({Key key, this.paragraph, this.order, this.listener})
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new PrayerText(widget.paragraph.get(widget.order.primary)),
                new Align(
                  alignment: Alignment.bottomRight,
                  child: new RotatedBox(
                    quarterTurns: 1,
                    child: new Icon(Icons.launch,
                      size: 12.0,
                      textDirection: widget.paragraph.get(widget.order.primary).direction,
                    ),
                  ),
                ),
              ],
            )));
  }
}

typedef void ParagraphClickListener(TranslatedPrayer paragraph);
