import 'package:birkon/localization/localizations.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {

  final int prayerId;
  final String image;
  final PrayerClickListener listener;

  const ListItem(this.prayerId, this.image, this.listener, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new InkWell(
        onTap: () {
          listener(prayerId, image);
        },
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Image(
                image: new AssetImage(image),
                fit: BoxFit.cover),
            new Padding(
              padding: EdgeInsets.all(16.0),
              child:
              new Text(AppLocalizations.get(context, prayerId),
                  style: new TextStyle(
                    fontSize: 22.0,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

typedef void PrayerClickListener(int prayerId, String image);