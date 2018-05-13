import 'package:birkon/paragraph.dart';
import 'package:birkon/prayer.dart';
import 'package:birkon/prayer_reader.dart';
import 'package:birkon/title.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (prayer != null) {
      return new Scaffold(
          appBar: new AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: new Text(widget.title),
          ),
          body: new ListView(
            children: <Widget>[
              new PrayerTitle(title: prayer.title.transliteration),
              new PrayerParagraph(
                  russian: "russian",
                  transliteration: "transliteration",
                  hebrew: "hebrew")
            ],
          )
      );
    } else if (e != null) {
      return new Container(
          child: new Text(e.toString()));
    } else {
      return new Container(
          width: 10.0,
          height: 10.0,
          child: new CircularProgressIndicator());
    }
  }
}
