import 'package:birkon/dao/directional_string.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/view/prayer_text.dart';
import 'package:flutter/material.dart';

class PrayerBottomSheet extends StatelessWidget {
  final TranslationTab left;
  final TranslationTab right;

  const PrayerBottomSheet({Key key, this.left, this.right}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: new ListView(
          children: <Widget>[
            new TabBar(
              labelColor: Colors.black,
              tabs: <Tab>[
                new Tab(text: AppLocalizations.get(context, left.titleKey)),
                new Tab(text: AppLocalizations.get(context, right.titleKey)),
              ]),
            new Container(
              height: 200.0,
              child: new TabBarView(
                children: <Widget>[
                  new PrayerText(left.string),
                  new PrayerText(right.string),
                ],
              ),
            )
          ],
        ));
  }
}

class TranslationTab {

  final DirectionalString string;
  final String titleKey;

  TranslationTab(this.string, this.titleKey);


}