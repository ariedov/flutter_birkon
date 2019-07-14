import 'package:birkon_web/web_prayer_asset_loader.dart';
import 'package:common/prayer_reader.dart';
import 'package:common/prayer.dart';
import 'package:birkon_web/prayer_widget.dart';
import 'package:flutter_web/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetLoader = WebPrayerAssetLoader();
    final prayerReader = PrayerReader(assetLoader);

    return Scaffold(
      body: FutureBuilder(
          future: prayerReader.readPrayer("shma_israel.json"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return PrayerWidget(prayer: snapshot.data);
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
