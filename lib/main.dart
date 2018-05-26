import 'package:birkon/view/paragraph.dart';
import 'package:birkon/prayer.dart';
import 'package:birkon/prayer_reader.dart';
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
      return new Scaffold(
          appBar: new AppBar(
            title: new Text(prayer.title.transliteration.toUpperCase()),
          ),
          body: new ListView.builder(
              itemCount: prayer.paragraphs.length,
              itemBuilder: _listViewBuilder
          ));
    } else if (e != null) {
      return new Container(
          child: new Text(e
              .toString()));
    } else {
      return new Container(
          width: 10.0,
          height:
          10.0,
          child: new CircularProgressIndicator());
    }
  }

  Widget _listViewBuilder(BuildContext context, int index) {
    TranslatedString paragraph = prayer.paragraphs[index];
    return new PrayerParagraph(
        russian: paragraph.russian,
        transliteration: paragraph.transliteration,
        hebrew: paragraph.hebrew);
  }
}
