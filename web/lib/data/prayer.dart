import 'package:birkon_web/data/direction.dart';

class Prayer {
  Prayer({this.title, this.paragraphs, this.direction});

  final String title;

  final List<Paragraph> paragraphs;

  final Direction direction;
}

class Paragraph {
  Paragraph(this.text);

  final String text;
}
