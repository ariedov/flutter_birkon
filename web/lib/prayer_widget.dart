import 'package:flutter_web/material.dart';

import 'data/direction.dart';
import 'data/prayer.dart';

class PrayerWidget extends StatelessWidget {
  const PrayerWidget({Key key, this.prayer}) : super(key: key);

  final Prayer prayer;

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>();

    children.add(SizedBox(
      height: 15.0,
    ));
    children.add(Text(
      prayer.title,
      textDirection: prayer.direction == Direction.right
          ? TextDirection.rtl
          : TextDirection.ltr,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    ));

    children.addAll(_buildParagraphs());

    return Column(
      children: children,
    );
  }

  _buildParagraphs() {
    final widgets = List<Widget>();
    for (final paragraph in prayer.paragraphs) {
      widgets.addAll([
        Text(
          paragraph.text,
          textDirection: prayer.direction == Direction.right
              ? TextDirection.rtl
              : TextDirection.ltr,
        ),
        SizedBox(
          height: 10.0,
        )
      ]);
    }

    return widgets;
  }
}
