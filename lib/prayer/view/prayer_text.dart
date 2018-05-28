import 'package:birkon/dao/directional_string.dart';
import 'package:flutter/material.dart';

class PrayerText extends Text {

  PrayerText(DirectionalString data)
      : super(data.text,
            textDirection: data.direction,
            style: new TextStyle(
              fontSize: 16.0,
            ));
}
