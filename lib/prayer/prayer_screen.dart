import 'dart:async';

import 'package:birkon/localization/keys.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/prayer.dart';
import 'package:birkon/prayer/view/bottom_sheet.dart';
import 'package:birkon/prayer/view/paragraph.dart';
import 'package:flutter/material.dart';

class PrayerScreen extends StatelessWidget {

  final Future<Prayer> prayer;
  final Future<Order> order;
  final SettingsItemClickListener listener;

  PrayerScreen(BuildContext context,
      this.prayer,
      this.order,
      this.listener);

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: _loadData(prayer, order),
        builder: (BuildContext context, AsyncSnapshot<Data> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return _buildContent(snapshot.data.order, snapshot.data.prayer);
          }
        });
  }

  Future<Data> _loadData(Future<Prayer> prayer, Future<Order> order) async {
    return new Data(
        await prayer,
        await order);
  }

  Scaffold _buildContent(Order order, Prayer prayer) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(prayer.title.get(order.primary).text.toUpperCase(),
              textDirection: prayer.title.get(order.primary).direction),
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
                                paragraph.get(order.ternary),
                                order.ternary));
                      });
                },
              );
            }));
  }
}

class Data {

  final Prayer prayer;
  final Order order;

  Data(this.prayer, this.order);
}

typedef void SettingsItemClickListener();
