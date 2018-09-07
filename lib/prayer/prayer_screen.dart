import 'dart:async';

import 'package:birkon/model/order/locale_order_provider.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/order/order_provider.dart';
import 'package:birkon/model/order/preferences_order_provider.dart';
import 'package:birkon/model/prayer.dart';
import 'package:birkon/model/prayer_reader.dart';
import 'package:birkon/prayer/prayer_content.dart';
import 'package:flutter/material.dart';

class PrayerScreen extends StatelessWidget {
  final int prayerId;

  PrayerScreen(this.prayerId);

  @override
  Widget build(BuildContext context) {
    PrayerReader prayerReader = new PrayerReader();
    LocaleOrderProvider localeOrderProvider = new LocaleOrderProvider(context);
    PreferencesOrderProvider preferencesOrderProvider =
        new PreferencesOrderProvider();
    OrderProvider orderProvider =
        new OrderProvider(preferencesOrderProvider, localeOrderProvider);

    Future<Prayer> prayer = prayerReader.readPrayer(context, prayerId);
    Future<Order> order = orderProvider.loadOrder();

    return new FutureBuilder(
        future: _loadData(prayer, order),
        builder: (BuildContext context, AsyncSnapshot<Data> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                  alignment: Alignment.center,
                  child: SizedBox.fromSize(
                    child: CircularProgressIndicator(),
                    size: Size(32.0, 32.0),
                  ));
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return new PrayerContent(
                    order: snapshot.data.order,
                    prayer: snapshot.data.prayer);
          }
        });
  }

  Future<Data> _loadData(Future<Prayer> prayer, Future<Order> order) async {
    return new Data(await prayer, await order);
  }
}

class Data {
  final Prayer prayer;
  final Order order;

  Data(this.prayer, this.order);
}

typedef void SettingsItemClickListener();
