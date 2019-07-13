import 'package:common/dao/direction.dart';
import 'package:common/dao/directional_string.dart';
import 'package:flutter/material.dart';

class PrayerText extends Text {
  PrayerText(DirectionalString data)
      : super(data.text,
            textDirection: data.direction == Direction.rtl
                ? TextDirection.rtl
                : TextDirection.ltr,
            style: new TextStyle(
              fontSize: 16.0,
            ));
}
