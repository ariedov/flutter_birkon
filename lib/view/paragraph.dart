import 'package:flutter/material.dart';

class PrayerParagraph extends StatefulWidget {
  final String russian;
  final String transliteration;
  final String hebrew;

  const PrayerParagraph(
      {Key key, this.russian, this.transliteration, this.hebrew})
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

          },
          child: new Text(
            widget.transliteration,
            style: new TextStyle(
              fontSize: 16.0,
            )
        )
      ),
    );
  }
}
