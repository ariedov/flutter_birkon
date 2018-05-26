import 'package:birkon/dao/directional_string.dart';
import 'package:birkon/view/prayer_text.dart';
import 'package:flutter/material.dart';

class PrayerBottomSheet extends StatelessWidget {
  final DirectionalString left;
  final DirectionalString right;

  const PrayerBottomSheet({Key key, this.left, this.right}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: new Column(
          children: <Widget>[
            new TabBar(tabs: <Tab>[
              new Tab(text: "LEFT"),
              new Tab(text: "RIGHT"),
            ]),
            new Container(
              height: 200.0,
              child: new TabBarView(
                children: <Widget>[
                  new ListView(
                    children: <Widget>[new PrayerText(left)],
                  ),
                  new ListView(
                    children: <Widget>[new PrayerText(right)],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
