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
    bool isLtr = widget.paragraph.get(widget.order.primary).direction == TextDirection.ltr;
    return new InkWell(
        onTap: () {
          widget.listener(widget.paragraph);
        },
        child: new Padding(
            padding: EdgeInsets.all(16.0),
            child: new Column(
              crossAxisAlignment: isLtr ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: <Widget>[
                new PrayerText(widget.paragraph.get(widget.order.primary)),
                _buildDropDownIcon(isLtr)
              ],
            )));
  }

  Widget _buildDropDownIcon(bool isLtr) {
    return new Align(
      alignment: isLtr ? Alignment.bottomRight : Alignment.bottomLeft,
      child: new RotatedBox(
        quarterTurns: isLtr ? 1 : 2,
        child: new Icon(Icons.launch,
          size: 12.0,
        ),
      ),
    );
  }
}

typedef void ParagraphClickListener(TranslatedPrayer paragraph);
