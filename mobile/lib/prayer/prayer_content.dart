import 'dart:async';

import 'package:birkon/header/header.dart';
import 'package:birkon/header/header_button.dart';
import 'package:birkon/language.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/prayer/view/paragraph.dart';
import 'package:common/prayer.dart';
import 'package:flutter/material.dart';

class PrayerContent extends StatefulWidget {
  final Prayer prayer;
  final int languageId;

  final GlobalKey headerKey;
  final StreamController<LanguageUpdateEvent> languageStream;

  const PrayerContent(
      {Key key,
      this.prayer,
      this.languageId,
      this.headerKey,
      this.languageStream})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PrayerContentState();
}

class _PrayerContentState extends State<PrayerContent>
    with TickerProviderStateMixin {
  PrayerContentViewModel viewModel;

  AnimationController hidePrayerAnimation;
  AnimationController showPrayerAnimation;

  Tween<double> hideTween;
  Tween<double> showTween;

  StreamSubscription subscription;

  ScrollController scrollController;

  @override
  void initState() {
    subscription = widget.languageStream.stream.listen((state) {
      if (state is LangaugeUpdateStarted) {
        viewModel.nextTranslationId = state.newLanguageCode;

        _startPrayerHideAnimation();
      }
    });

    showPrayerAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150))
          ..addListener(() {
            setState(() {
              viewModel.contentOpacity =
                  showTween.evaluate(showPrayerAnimation);
            });
          });

    hidePrayerAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150))
          ..addListener(() {
            setState(() {
              viewModel.contentOpacity =
                  hideTween.evaluate(hidePrayerAnimation);
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              viewModel.translationId = viewModel.nextTranslationId;
              showPrayerAnimation.forward(from: 0.0);
            }
          });

    scrollController = ScrollController();

    viewModel = PrayerContentViewModel();
    viewModel.translationId = widget.languageId;
    super.initState();
  }

  _startPrayerHideAnimation() {
    hideTween = Tween<double>(begin: viewModel.contentOpacity, end: 0.0);
    showTween = ReverseTween<double>(hideTween);

    hidePrayerAnimation.forward(from: 0.0);
  }

  @override
  void didUpdateWidget(PrayerContent oldWidget) {
    viewModel.translationId = widget.languageId;

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Opacity(
      opacity: viewModel.contentOpacity,
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.blue,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                key: widget.headerKey,
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(children: <Widget>[
                  Header(
                      prayer: widget.prayer, languageCode: widget.languageId),
                  SizedBox(height: 16.0),
                  HeaderButton(
                    text:
                        AppLocalizations.getFromKey(context, widget.languageId),
                    onPressed: () {
                      scrollController.animateTo(0.0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.decelerate);

                      double height =
                          widget.headerKey.currentContext.size.height;
                      widget.languageStream
                          .add(LanguageUpdateEvent.requried(height));
                    },
                  ),
                ]),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return PrayerParagraph(
                    paragraph: widget.prayer.paragraphs[index],
                    languageCode: viewModel.translationId);
              },
              childCount: widget.prayer.paragraphs.length,
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    showPrayerAnimation.dispose();
    hidePrayerAnimation.dispose();

    subscription.cancel();
    super.dispose();
  }
}

class PrayerContentViewModel {
  double contentOpacity = 1.0;

  int translationId;
  int nextTranslationId;
}

typedef void OnMenuClickListener(int menuId);
