import 'package:birkon/model/prayer.dart';
import 'package:birkon/model/string_provider.dart';
import 'package:birkon/prayer/view/bottom_sheet.dart';
import 'package:birkon/prayer/view/paragraph.dart';
import 'package:flutter/material.dart';

class PrayerScreen extends Scaffold {

  PrayerScreen(BuildContext context, Prayer prayer) :
        super(
          appBar: new AppBar(
            title: new Text(
                new StringProvider(context, prayer.title).primary.text
                    .toUpperCase()),
          ),
          body: new ListView.builder(
              itemCount: prayer.paragraphs.length,
              itemBuilder: (context, index) {
                return new PrayerParagraph(
                  paragraphProvider: new StringProvider(
                      context, prayer.paragraphs[index]),
                  listener: (paragraph) {
                    showModalBottomSheet(
                        context: context, builder: (BuildContext context) {
                      return new PrayerBottomSheet(
                          left: new TranslationTab(
                              paragraph.secondary, paragraph.secondaryTitle),
                          right: new TranslationTab(
                              paragraph.ternary, paragraph.ternaryTitle)
                      );
                    });
                  },
                );
              }
          )
      );
}