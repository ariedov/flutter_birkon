import 'dart:convert';

import 'package:birkon_web/data/direction.dart';
import 'package:flutter_web/material.dart';

class Prayer {
  Prayer({this.title, this.paragraphs, this.direction});

  final String title;

  final List<Paragraph> paragraphs;

  final Direction direction;

  Future<Prayer> readFromAssets(BuildContext context, String path, Direction direction) async {
    final prayerJson = await rootBundle.loadString(path);
    final decoded = json.decode(prayerJson);

    final title = decoded["title"];

  }
}

class Paragraph {
  Paragraph(this.text);

  final String text;
}
