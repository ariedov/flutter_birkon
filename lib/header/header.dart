import 'dart:async';

import 'package:birkon/language.dart';
import 'package:birkon/model/prayer.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final Prayer prayer;
  final int languageCode;

  final Stream<LanguageUpdateEvent> languageStream;

  const Header({Key key, this.prayer, this.languageCode, this.languageStream})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TickerProviderStateMixin {
  HeaderViewModel viewModel = HeaderViewModel();

  AnimationController hideAnimation;
  AnimationController showAnimation;

  Tween<double> hideTween;
  Tween<double> showTween;

  @override
  void initState() {
    viewModel.headerTitle =
        widget.prayer.title.get(widget.languageCode).text.toUpperCase();
    viewModel.headerTextDirection =
        widget.prayer.title.get(widget.languageCode).direction;

    widget.languageStream.listen((event) {
      if (event is LangaugeUpdateStarted) {
        viewModel.nextLanguageCode = event.newLanguageCode;
        _startLanguageAnimation(event.newLanguageCode);
      }
    });

    showAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150))
          ..addListener(() {
            setState(() {
              viewModel.headerOpacity = showTween.evaluate(hideAnimation);
            });
          });

    hideAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150))
          ..addListener(() {
            setState(() {
              viewModel.headerOpacity = hideTween.evaluate(hideAnimation);
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              viewModel.headerTitle = widget.prayer.title
                  .get(viewModel.nextLanguageCode)
                  .text
                  .toUpperCase();
              viewModel.headerTextDirection =
                  widget.prayer.title.get(viewModel.nextLanguageCode).direction;

              showAnimation.forward();
            }
          });

    super.initState();
  }

  _startLanguageAnimation(int language) {
    hideTween = Tween<double>(begin: 1.0, end: 0.0);
    showTween = ReverseTween<double>(hideTween);

    hideAnimation.forward();
  }

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
          Opacity(
            opacity: viewModel.headerOpacity,
            child: Text(
              viewModel.headerTitle,
              textDirection: viewModel.headerTextDirection,
              style: Theme.of(context).textTheme.title.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white),
            ),
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

class HeaderViewModel {
  String headerTitle;
  TextDirection headerTextDirection;

  int nextLanguageCode;

  double headerOpacity = 1.0;
}
