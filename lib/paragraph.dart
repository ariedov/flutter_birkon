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
  bool _showRussian;
  bool _showHebrew;

  void showRussian() {
    setState(() {
      _showRussian = true;
      _showHebrew = false;
    });
  }

  void showHebrew() {
    setState(() {
      _showRussian = false;
      _showHebrew = true;
    });
  }

  void hideTranslations() {
    setState(() {
      _showRussian = false;
      _showHebrew = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Opacity(
            opacity: _showRussian ? 1.0 : 0.0,
            child: new Container(
                decoration: new BoxDecoration(color: Colors.white),
                margin: new EdgeInsets.only(right: 10.0),
                child: new Text(widget.russian))),
        new Opacity(opacity: 1.0, child: new Text(widget.transliteration)),
        new Opacity(
            opacity: _showHebrew ? 1.0 : 0.0,
            child: new Container(
                decoration: new BoxDecoration(color: Colors.white),
                margin: new EdgeInsets.only(left: 10.0),
                child: new Text(widget.hebrew)))
      ],
    );
  }
}
