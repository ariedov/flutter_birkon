import 'package:common/dao/direction.dart';
import 'package:common/prayer.dart';
import 'package:flutter_web/material.dart';

class PrayerWidget extends StatelessWidget {
  const PrayerWidget({Key key, this.prayer}) : super(key: key);

  final Prayer prayer;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: prayer.paragraphs.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildTitle();
          }

          return _buildParagraph(index - 1);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 25,);
        },);
  }

  _buildTitle() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            prayer.title.russian.text,
            textDirection: convertTextDirection(prayer.title.russian.direction),
          ),
        ),
        // TODO: separator
        Expanded(
          child: Text(
            prayer.title.transliteration.text,
            textDirection:
                convertTextDirection(prayer.title.transliteration.direction),
          ),
        ),
        // TODO: separator
        Expanded(
          child: Text(
            prayer.title.hebrew.text,
            textDirection: convertTextDirection(prayer.title.hebrew.direction),
          ),
        ),
      ],
    );
  }

  _buildParagraph(int index) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            prayer.paragraphs[index].russian.text,
            textDirection: convertTextDirection(prayer.title.russian.direction),
          ),
        ),
        // TODO: separator
        Expanded(
          child: Text(
            prayer.paragraphs[index].transliteration.text,
            textDirection:
                convertTextDirection(prayer.title.transliteration.direction),
          ),
        ),
        // TODO: separator
        Expanded(
          child: Text(
            prayer.paragraphs[index].hebrew.text,
            textDirection: convertTextDirection(prayer.title.hebrew.direction),
          ),
        ),
      ],
    );
  }
}

TextDirection convertTextDirection(Direction direction) {
  return direction == Direction.rtl ? TextDirection.rtl : TextDirection.ltr;
}
