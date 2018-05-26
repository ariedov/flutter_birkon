import 'package:birkon/dao/directional_string.dart';
import 'package:flutter/material.dart';

class PrayerBottomSheet extends StatelessWidget {

  final DirectionalString left;
  final DirectionalString right;

  const PrayerBottomSheet({Key key, this.left, this.right}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 150.0,
      child: new PageView(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              new Text(left.text, textDirection: left.direction)
            ],
          ),

          new ListView(
            children: <Widget>[
              new Text(right.text, textDirection: right.direction)
            ],
          )
        ],
      ),
    );
  }
}