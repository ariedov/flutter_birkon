import 'dart:async';

import 'package:birkon/list/list_screen.dart';
import 'package:birkon/model/order/locale_order_provider.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/order/order_provider.dart';
import 'package:birkon/model/order/preferences_order_provider.dart';
import 'package:birkon/prayer/prayer_screen.dart';
import 'package:birkon/model/prayer.dart';
import 'package:birkon/model/prayer_reader.dart';
import 'package:birkon/preferences/prefs_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<Prayer> prayer;

  @override
  void initState() {
    super.initState();
    PrayerReader prayerReader = new PrayerReader();
    setState(() {
      this.prayer = prayerReader.readPrayer(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    LocaleOrderProvider localeOrderProvider = new LocaleOrderProvider(context);
    PreferencesOrderProvider preferencesOrderProvider =
        new PreferencesOrderProvider();

    OrderProvider orderProvider =
        new OrderProvider(preferencesOrderProvider, localeOrderProvider);
    Future<Order> order = orderProvider.loadOrder();

//    return new PrayerScreen(context, prayer, order, () {
//      _moveToPrefs(context, order, preferencesOrderProvider);
//    }
  return new ListScreen();
  }

  void _moveToPrefs(BuildContext context, Future<Order> order,
      PreferencesOrderProvider prefsOrderProvider) async {
    Order initialOrder = await order;
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new PrefsScreen(
                  initialOrder: initialOrder,
                  prefsOrderProvider: prefsOrderProvider,
                )));
  }
}
