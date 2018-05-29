import 'package:birkon/model/order_provider.dart';
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

  Prayer prayer;
  dynamic e;

  @override
  void initState() {
    super.initState();
    loadPrayer(context);
  }

  void loadPrayer(BuildContext context) async {
    try {
      PrayerReader prayerReader = new PrayerReader();
      Prayer prayer = await prayerReader.readPrayer(context);
      setState(() {
        this.prayer = prayer;
      });
    } catch (e) {
      setState(() {
        this.e = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (prayer != null) {
      return new PrayerScreen(
          context,
          prayer,
          new OrderProvider(context, prayer.title),
          _moveToPrefs);
    } else if (e != null) {
      return new Container(
          child: new Text(e
              .toString()));
    } else {
      return new Container(
          width: 10.0,
          height: 10.0,
          child: new CircularProgressIndicator());
    }
  }

  void _moveToPrefs(OrderProvider orderProvider) {
    Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new PrefsScreen(
            orderProvider: orderProvider
        ))
    );
  }
}
