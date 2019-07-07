import 'package:birkon_web/data/prayer.dart';
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
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: PrayerWidget(
              prayer: Prayer(title: "Russian", paragraphs: []),
            ),
          ), // russian
          Expanded(
            child: PrayerWidget(
              prayer: Prayer(title: "Transliteration", paragraphs: []),
            ),
          ), // transliteration
          Expanded(
              child: PrayerWidget(
            prayer: Prayer(title: "Hebrew", paragraphs: []),
          )), // hebrew
        ],
      ),
    );
  }
}
