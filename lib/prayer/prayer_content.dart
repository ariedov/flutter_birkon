import 'package:birkon/header/header.dart';
import 'package:birkon/header/header_button.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/prayer.dart';
import 'package:birkon/prayer/view/bottom_sheet.dart';
import 'package:birkon/prayer/view/paragraph.dart';
import 'package:flutter/material.dart';

class PrayerContent extends StatelessWidget {
  final Prayer prayer;
  final Order order;
  final GlobalKey headerKey;

  const PrayerContent({Key key, this.prayer, this.order, this.headerKey})
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
                Header(prayer: prayer, order: order),
                SizedBox(height: 16.0),
                HeaderButton(
                  text: AppLocalizations.get(context, order.primary),
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
                order: order,
                listener: (paragraph) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return PrayerBottomSheet(
                            left: TranslationTab(paragraph.get(order.secondary),
                                order.secondary),
                            right: TranslationTab(
                                paragraph.get(order.ternary), order.ternary));
                      });
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
