import 'package:birkon/localization/keys.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/prayer.dart';
import 'package:birkon/model/string_provider.dart';
import 'package:birkon/prayer/view/bottom_sheet.dart';
import 'package:birkon/prayer/view/paragraph.dart';
import 'package:flutter/material.dart';

class PrayerScreen extends Scaffold {
  final SettingsItemClickListener listener;

  PrayerScreen(BuildContext context, Prayer prayer,
      StringProvider titleProvider, this.listener)
      : super(
            appBar: new AppBar(
              title: new Text(titleProvider.primary.text.toUpperCase(),
                  textDirection: titleProvider.primary.direction),
              actions: <Widget>[
                new PopupMenuButton<int>(
                  onSelected: (id) {
                    listener();
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
                    paragraphProvider:
                        new StringProvider(context, prayer.paragraphs[index]),
                    listener: (paragraph) {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return new PrayerBottomSheet(
                                left: new TranslationTab(paragraph.secondary,
                                    paragraph.secondaryTitle),
                                right: new TranslationTab(
                                    paragraph.ternary, paragraph.ternaryTitle));
                          });
                    },
                  );
                }));
}

typedef void SettingsItemClickListener();
