import 'package:birkon/dao/directional_string.dart';
import 'package:flutter/material.dart';

class PrayerText extends Padding {

  PrayerText(DirectionalString data) : super(
    padding: EdgeInsets.all(16.0),
    child: new Text(
      data.text,
      textDirection: data.direction,
      style: new TextStyle(
        fontSize: 16.0,
      )
    )
  );
}