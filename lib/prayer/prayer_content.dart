import 'package:birkon/header/header.dart';
import 'package:birkon/header/header_button.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/prayer.dart';
import 'package:birkon/prayer/view/paragraph.dart';
import 'package:flutter/material.dart';

class PrayerContent extends StatelessWidget {
  final Prayer prayer;
  final int languageId;
  final GlobalKey headerKey;

  const PrayerContent({Key key, this.prayer, this.languageId, this.headerKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              key: headerKey,
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(children: <Widget>[
                Header(prayer: prayer, languageCode: languageId),
                SizedBox(height: 16.0),
                HeaderButton(
                  text: AppLocalizations.get(context, languageId),
                  onPressed: () {},
                ),
              ]),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return PrayerParagraph(
                paragraph: prayer.paragraphs[index],
                languageCode: languageId,
                listener: (paragraph) {
                  
                },
              );
            },
            childCount: prayer.paragraphs.length,
          ),
        )
      ],
    ));
  }
}

typedef void OnMenuClickListener(int menuId);
