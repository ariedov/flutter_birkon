import 'package:birkon/list/view/list_item.dart';
import 'package:birkon/localization/keys.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/prayer/prayer_screen.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {

  ListScreen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppLocalizations.get(context, APP_NAME)),
      ),
      body: new ListView(
        children: <Widget>[
          new ListItem(BIRKAT_HA_MAZON, 'assets/graphics/birkat_hamazon.jpeg',
                  (prayerId, image) {
                    _moveToPrayer(context, prayerId, image);
              }),
          new ListItem(SHMA_ISRAEL, 'assets/graphics/shma_israel.jpg',
                  (prayerId, image) {
                    _moveToPrayer(context, prayerId, image);
              })
        ],
      ),
    );
  }

  void _moveToPrayer(BuildContext context, int prayerId, String image) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new PrayerScreen(prayerId, image)));
  }
}

typedef void OnPrayerClickListener(int prayerId);
