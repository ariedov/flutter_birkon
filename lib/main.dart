import 'package:birkon/dao/translated_string.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/view/bottom_sheet.dart';
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
            title: new Text(prayer.title.transliteration.text.toUpperCase()),
          ),
          body: new ListView.builder(
              itemCount: prayer.paragraphs.length,
              itemBuilder: (context, index) {
                TranslatedString paragraph = prayer.paragraphs[index];
                return new PrayerParagraph(
                  paragraph: paragraph,
                  listener: (paragraph) {
                    showModalBottomSheet(context: context, builder: (BuildContext context) {
                      return new PrayerBottomSheet(
                          left: new TranslationTab(paragraph.russian, RUSSIAN),
                          right: new TranslationTab(paragraph.hebrew, HEBREW)
                      );
                    });
                  },
                );
              }
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
}
