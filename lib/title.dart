import 'package:flutter/material.dart';

class PrayerTitle extends StatelessWidget {

  final String title;

  const PrayerTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Text(title);
  }
}