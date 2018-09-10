import 'dart:async';

import 'package:birkon/header/header.dart';
import 'package:birkon/header/header_button.dart';
import 'package:birkon/language.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/prayer.dart';
import 'package:flutter/material.dart';

class Chooser extends StatefulWidget {
  final Prayer prayer;
  final Order order;
  final GlobalKey headerKey;
  final double targetHeight;
  final double screenWidth;
  final bool showCollapsed;
  final int initialTranslation;

  final StreamController<LanguageUpdateEvent> languageStreamController;

  const Chooser(
      {Key key,
      this.prayer,
      this.order,
      this.headerKey,
      this.showCollapsed,
      this.initialTranslation,
      this.targetHeight,
      this.screenWidth,
      this.languageStreamController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChooserState();
}

typedef ChoiceSelectedListener(int choice);

class _ChooserState extends State<Chooser> with TickerProviderStateMixin {
  ChooserState state;

  AnimationController collapseAnimation;
  AnimationController expandAnimation;

  GlobalKey top = GlobalKey();
  GlobalKey secondary = GlobalKey();
  GlobalKey ternary = GlobalKey();

  // buttons tween
  Tween<Offset> firstOffsetTween;
  Tween<Offset> secondOffsetTween;
  Tween<Offset> thirdOffsetTween;

  // container tween
  Tween<double> cornersTween;
  Tween<double> heightTween;
  ColorTween backgroundTween;

  int selectedLanguageId;

  @override
  void initState() {
    expandAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            _updateStateWithTweens(expandAnimation);
          });

    collapseAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            _updateStateWithTweens(collapseAnimation);
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.languageStreamController
                  .add(LanguageUpdateEvent.finished(selectedLanguageId));
            }
          });

    state = ChooserState();
    if (widget.showCollapsed) {
      state.height = widget.targetHeight;
      state.corners = 0.0;
      state.background = Colors.transparent;

      state.firstOffset = widget.initialTranslation == widget.order.primary
          ? Offset(0.0, 0.0)
          : Offset(-2 * widget.screenWidth, 0.0);
      state.secondOffset = widget.initialTranslation == widget.order.secondary
          ? Offset(0.0, -(25.0 + 16.0))
          : Offset(-2 * widget.screenWidth, 0.0);
      state.thirdOffset = widget.initialTranslation == widget.order.ternary
          ? Offset(0.0, -((25.0 + 16.0) * 2))
          : Offset(-2 * widget.screenWidth, 0.0);

      _startExpandAnimation();
    }

    super.initState();
  }

  void _updateStateWithTweens(Animation animation) {
    setState(() {
      state.firstOffset = firstOffsetTween.evaluate(animation);
      state.secondOffset = secondOffsetTween.evaluate(animation);
      state.thirdOffset = thirdOffsetTween.evaluate(animation);

      state.height = heightTween.evaluate(animation);
      state.corners = cornersTween.evaluate(animation);

      state.background = backgroundTween.evaluate(animation);
    });
  }

  @override
  void reassemble() {
    state = ChooserState();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(color: state.background),
        SizedBox(
          height: state.height,
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(state.corners),
                            bottomRight: Radius.circular(state.corners)))),
                child: Container(color: Colors.blue),
              ),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Header(
                      prayer: widget.prayer,
                      languageCode: widget.initialTranslation,
                      languageStream: widget.languageStreamController.stream,
                    ),
                    SizedBox(height: 16.0),
                    _buildButton(top, widget.order.primary, state.firstOffset),
                    SizedBox(height: 16.0),
                    _buildButton(
                        secondary, widget.order.secondary, state.secondOffset),
                    SizedBox(height: 16.0),
                    _buildButton(
                        ternary, widget.order.ternary, state.thirdOffset),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildButton(Key key, int translationId, Offset offset) {
    return Transform(
      child: HeaderButton(
        key: key,
        text: AppLocalizations.get(context, translationId),
        onPressed: () {
          _startButtonsFadeAnimation(translationId);
        },
      ),
      transform: Matrix4.translationValues(offset.dx, offset.dy, 0.0),
    );
  }

  _startButtonsFadeAnimation(int translationId) {
    this.selectedLanguageId = translationId;
    widget.languageStreamController
        .add(LanguageUpdateEvent.started(translationId));

    firstOffsetTween = translationId == widget.order.primary
        ? Tween<Offset>(begin: state.firstOffset, end: state.firstOffset)
        : Tween<Offset>(
            begin: state.firstOffset,
            end: Offset(2 * context.size.width, state.firstOffset.dy));

    secondOffsetTween = translationId == widget.order.secondary
        ? Tween<Offset>(
            begin: state.secondOffset,
            end: Offset(0.0, -(secondary.currentContext.size.height + 16.0)))
        : Tween<Offset>(
            begin: state.secondOffset,
            end: Offset(2 * context.size.width, state.secondOffset.dy));

    thirdOffsetTween = translationId == widget.order.ternary
        ? Tween<Offset>(
            begin: state.thirdOffset,
            end:
                Offset(0.0, -((ternary.currentContext.size.height + 16.0) * 2)))
        : Tween<Offset>(
            begin: state.thirdOffset,
            end: Offset(2 * context.size.width, state.thirdOffset.dy));

    final height = widget.headerKey.currentContext.size.height;
    heightTween = Tween<double>(begin: state.height, end: height);
    cornersTween = Tween<double>(begin: state.corners, end: 0.0);
    backgroundTween =
        ColorTween(begin: state.background, end: Colors.transparent);

    collapseAnimation.forward();
  }

  _startExpandAnimation() {
    firstOffsetTween = Tween<Offset>(begin: state.firstOffset, end: Offset(0.0, 0.0));
    secondOffsetTween = Tween<Offset>(begin: state.secondOffset, end: Offset(0.0, 0.0));
    thirdOffsetTween = Tween<Offset>(begin: state.thirdOffset, end: Offset(0.0, 0.0));

    heightTween = Tween<double>(begin: state.height, end: 400.0);
    cornersTween = Tween<double>(begin: state.corners, end: 50.0);
    backgroundTween = ColorTween(begin: state.background, end: Colors.black26);

    expandAnimation.forward();
  }
}

class ChooserClipper extends ShapeBorderClipper {}

class ChooserState {
  Color background = Colors.black26;

  Offset firstOffset = Offset(0.0, 0.0);
  Offset secondOffset = Offset(0.0, 0.0);
  Offset thirdOffset = Offset(0.0, 0.0);

  double corners = 50.0;
  double height = 400.0;
}
