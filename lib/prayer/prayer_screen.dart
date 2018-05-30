import 'package:birkon/localization/keys.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/prayer.dart';
import 'package:birkon/model/order_provider.dart';
import 'package:birkon/prayer/view/bottom_sheet.dart';
import 'package:birkon/prayer/view/paragraph.dart';
import 'package:flutter/material.dart';

class PrayerScreen extends Scaffold {
  final SettingsItemClickListener listener;

  PrayerScreen(BuildContext context, Prayer prayer,
      OrderProvider orderProvider, this.listener)
      : super(
            appBar: new AppBar(
              title: new Text(prayer.title.get(orderProvider.primary).text.toUpperCase(),
                  textDirection: prayer.title.get(orderProvider.primary).direction),
              actions: <Widget>[
                new PopupMenuButton<int>(
                  onSelected: (id) {
                    listener(orderProvider);
                  },
                  itemBuilder: (BuildContext context) {
                    return new List()
                      ..add(new PopupMenuItem(
                          value: 1,
                          child: new Text(
                              AppLocalizations.get(context, SETTINGS))));
                  },
                ),
              ],
            ),
            body: new ListView.builder(
                itemCount: prayer.paragraphs.length,
                itemBuilder: (context, index) {
                  return new PrayerParagraph(
                    paragraph: prayer.paragraphs[index],
                    orderProvider: orderProvider,
                    listener: (paragraph) {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return new PrayerBottomSheet(
                                left: new TranslationTab(
                                    paragraph.get(orderProvider.secondary),
                                    orderProvider.secondary),
                                right: new TranslationTab(
                                    paragraph.get(orderProvider.ternary),
                                    orderProvider.ternary));
                          });
                    },
                  );
                }));
}

typedef void SettingsItemClickListener(OrderProvider provider);
