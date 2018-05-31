import 'package:birkon/localization/keys.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/prayer.dart';
import 'package:birkon/prayer/view/bottom_sheet.dart';
import 'package:birkon/prayer/view/paragraph.dart';
import 'package:flutter/material.dart';

class PrayerContent extends StatelessWidget {

  final Prayer prayer;
  final Order order;
  final OnMenuClickListener listener;

  const PrayerContent({Key key, this.prayer, this.order, this.listener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(prayer.title.get(order.primary).text.toUpperCase(),
              textDirection: prayer.title.get(order.primary).direction),
          actions: <Widget>[
            new PopupMenuButton<int>(
              onSelected: (id) {
                listener(id);
              },
              itemBuilder: (BuildContext context) {
                return new List()
                  ..add(new PopupMenuItem(
                      value: 1,
                      child:
                      new Text(AppLocalizations.get(context, SETTINGS))));
              },
            ),
          ],
        ),
        body: new ListView.builder(
            itemCount: prayer.paragraphs.length,
            itemBuilder: (context, index) {
              return new PrayerParagraph(
                paragraph: prayer.paragraphs[index],
                order: order,
                listener: (paragraph) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return new PrayerBottomSheet(
                            left: new TranslationTab(
                                paragraph.get(order.secondary),
                                order.secondary),
                            right: new TranslationTab(
                                paragraph.get(order.ternary), order.ternary));
                      });
                },
              );
            }));
  }
}

typedef void OnMenuClickListener(int menuId);