import 'dart:async';

import 'package:birkon/chooser/chooser.dart';
import 'package:birkon/model/order/locale_order_provider.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/order/order_provider.dart';
import 'package:birkon/model/order/preferences_order_provider.dart';
import 'package:birkon/model/prayer.dart';
import 'package:birkon/model/prayer_reader.dart';
import 'package:birkon/prayer/prayer_content.dart';
import 'package:flutter/material.dart';

class PrayerScreen extends StatefulWidget {
  final int prayerId;

  PrayerScreen(this.prayerId);

  @override
  State<StatefulWidget> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  final GlobalKey headerKey = new GlobalKey();

  StreamController<int> languageSelectorStream;
  PrayerScreenViewModel viewModel = PrayerScreenViewModel();

  Data data;

  @override
  void initState() {
    languageSelectorStream = StreamController<int>();

    languageSelectorStream.stream.listen((value) {
      setState(() {
        viewModel.displayOverlay = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    languageSelectorStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return _loadPrayer(context);
    }

    return _buildContent(data);
  }

  FutureBuilder<Data> _loadPrayer(BuildContext context) {
    PrayerReader prayerReader = new PrayerReader();
    LocaleOrderProvider localeOrderProvider = new LocaleOrderProvider(context);
    PreferencesOrderProvider preferencesOrderProvider =
        new PreferencesOrderProvider();
    OrderProvider orderProvider =
        new OrderProvider(preferencesOrderProvider, localeOrderProvider);
    
    Future<Prayer> prayer = prayerReader.readPrayer(context, widget.prayerId);
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
                return Text('Error: ${snapshot.error}');
              else
                return _buildContent(snapshot.data);
          }
        });
  }

  Stack _buildContent(Data data) {
    this.data = data;

    return Stack(
      children: <Widget>[
        PrayerContent(
            headerKey: headerKey,
            order: data.order,
            prayer: data.prayer),
        _buildOverlay(data),
      ],
    );
  }

  _buildOverlay(Data data) {
    if (viewModel.displayOverlay) {
      return Chooser(
        headerKey: headerKey,
        order: data.order,
        prayer: data.prayer,
        languageSink: languageSelectorStream,
      );
    }

    return SizedBox();
  }

  Future<Data> _loadData(Future<Prayer> prayer, Future<Order> order) async {
    return new Data(await prayer, await order);
  }
}

class PrayerScreenViewModel {
  bool displayOverlay = true;
}

class Data {
  final Prayer prayer;
  final Order order;

  Data(this.prayer, this.order);
}

typedef void SettingsItemClickListener();
