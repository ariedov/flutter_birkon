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
          new Card(
            child: new InkWell(
              onTap: () {
                _moveToPrayer(context, BIRKAT_HA_MAZON);
              },
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image(
                      image: new AssetImage(
                          'assets/graphics/birkat_hamazon.jpeg')),
                  new Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                        new Text(AppLocalizations.get(context, BIRKAT_HA_MAZON),
                            style: new TextStyle(
                              fontSize: 22.0,
                            )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _moveToPrayer(BuildContext context, int prayerId) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new PrayerScreen(prayerId)));
  }
}

typedef void OnPrayerClickListener(int prayerId);
