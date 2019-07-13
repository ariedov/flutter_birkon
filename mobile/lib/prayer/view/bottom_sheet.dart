import 'package:birkon/localization/localizations.dart';
import 'package:birkon/prayer/view/prayer_text.dart';
import 'package:common/dao/directional_string.dart';
import 'package:flutter/material.dart';

class PrayerBottomSheet extends StatelessWidget {
  final TranslationTab left;
  final TranslationTab right;

  const PrayerBottomSheet({Key key, this.left, this.right}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: new Column(
          children: <Widget>[
            new TabBar(labelColor: Colors.black, tabs: <Tab>[
              new Tab(text: AppLocalizations.get(context, left.titleKey)),
              new Tab(text: AppLocalizations.get(context, right.titleKey)),
            ]),
            new Expanded(
              child: new TabBarView(
                children: <Widget>[
                  new ListView(children: <Widget>[
                    new Padding(
                        padding: EdgeInsets.all(16.0),
                        child: new PrayerText(left.string))
                  ]),
                  new ListView(children: <Widget>[
                    new Padding(
                        padding: EdgeInsets.all(16.0),
                        child: new PrayerText(right.string))
                  ]),
                ],
              ),
            )
          ],
        ));
  }
}

class TranslationTab {
  final DirectionalString string;
  final int titleKey;

  TranslationTab(this.string, this.titleKey);
}
