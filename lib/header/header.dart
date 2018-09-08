import 'package:birkon/model/prayer.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Prayer prayer;
  final int languageCode;

  const Header({Key key, this.prayer, this.languageCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: _buildHeaderTopPadding(context) + 24.0,
          ),
          Image(
            image: AssetImage("assets/graphics/shma.png"),
            fit: BoxFit.none,
          ),
          SizedBox(height: 24.0),
          Text(
            prayer.title.get(languageCode).text.toUpperCase(),
            textDirection: prayer.title.get(languageCode).direction,
            style: Theme.of(context).textTheme.title.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  _buildHeaderTopPadding(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return statusBarHeight;
  }
}
