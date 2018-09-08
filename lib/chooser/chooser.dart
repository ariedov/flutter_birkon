import 'package:birkon/header/header.dart';
import 'package:birkon/header/header_button.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/prayer.dart';
import 'package:flutter/material.dart';

class Chooser extends StatefulWidget {
  final Prayer prayer;
  final Order order;
  final GlobalKey headerKey;

  final Sink<int> languageSink;

  const Chooser(
      {Key key,
      this.prayer,
      this.order,
      this.headerKey,
      this.languageSink})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChooserState();
}

typedef ChoiceSelectedListener(int choice);

class _ChooserState extends State<Chooser> with TickerProviderStateMixin {
  ChooserState state = ChooserState();

  AnimationController collapseAnimation;

  // buttons tween
  Tween<Offset> firstOffsetTween;
  Tween<Offset> secondOffsetTween;
  Tween<Offset> thirdOffsetTween;

  // container tween
  Tween<double> cornersTween;
  Tween<double> heightTween;
  ColorTween backgroundTween;

  int selectedOrderItem;

  @override
  void initState() {
    collapseAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {
              state.firstOffset = _evaluateCurvedOffset(firstOffsetTween, 0.2);
              state.secondOffset =
                  _evaluateCurvedOffset(secondOffsetTween, 0.4);
              state.thirdOffset = _evaluateCurvedOffset(thirdOffsetTween, 0.6);

              state.height = heightTween.evaluate(collapseAnimation);
              state.corners = cornersTween.evaluate(collapseAnimation);

              state.background = backgroundTween.evaluate(collapseAnimation);
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.languageSink.add(selectedOrderItem);
            }
          });

    super.initState();
  }

  _evaluateCurvedOffset(Tween<Offset> tween, double intervalStart) {
    return tween.evaluate(CurvedAnimation(
        parent: collapseAnimation, curve: Interval(intervalStart, 1.0)));
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
                      order: widget.order,
                    ),
                    SizedBox(height: 16.0),
                    _buildButton(widget.order.primary, state.firstOffset),
                    SizedBox(height: 16.0),
                    _buildButton(widget.order.secondary, state.secondOffset),
                    SizedBox(height: 16.0),
                    _buildButton(widget.order.ternary, state.thirdOffset),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildButton(int translationId, Offset offset) {
    return Transform(
      child: HeaderButton(
        text: AppLocalizations.get(context, translationId),
        onPressed: () {
          _startButtonsFadeAnimation(translationId);
        },
      ),
      transform: Matrix4.translationValues(offset.dx, offset.dy, 0.0),
    );
  }

  _startButtonsFadeAnimation(int translationId) {
    this.selectedOrderItem = selectedOrderItem;

    firstOffsetTween = Tween<Offset>(
        begin: state.firstOffset,
        end: Offset(2 * context.size.width, state.firstOffset.dy));
    secondOffsetTween = Tween<Offset>(
        begin: state.secondOffset,
        end: Offset(2 * context.size.width, state.secondOffset.dy));
    thirdOffsetTween = Tween<Offset>(
        begin: state.thirdOffset,
        end: Offset(2 * context.size.width, state.thirdOffset.dy));

    final height = widget.headerKey.currentContext.size.height;

    heightTween = Tween<double>(begin: state.height, end: height);
    cornersTween = Tween<double>(begin: state.corners, end: 0.0);
    backgroundTween =
        ColorTween(begin: state.background, end: Colors.transparent);

    collapseAnimation.forward(from: 0.0);
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
