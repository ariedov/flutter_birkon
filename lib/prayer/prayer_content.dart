import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/prayer.dart';
import 'package:birkon/prayer/view/bottom_sheet.dart';
import 'package:birkon/prayer/view/paragraph.dart';
import 'package:flutter/material.dart';

class PrayerContent extends StatelessWidget {
  final Prayer prayer;
  final Order order;

  const PrayerContent({Key key, this.prayer, this.order}) : super(key: key);

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
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/graphics/shma.png"),
                      fit: BoxFit.none,
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      prayer.title.get(order.primary).text.toUpperCase(),
                      textDirection: prayer.title.get(order.primary).direction,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    OutlineButton(
                      child: Text(
                        AppLocalizations.get(context, order.primary)
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
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
