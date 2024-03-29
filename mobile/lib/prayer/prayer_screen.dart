import 'dart:async';

import 'package:birkon/asset_loader.dart';
import 'package:birkon/header/header.dart';
import 'package:birkon/header/header_button.dart';
import 'package:birkon/language.dart';
import 'package:birkon/localization/keys.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/order/locale_order_provider.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/order/order_provider.dart';
import 'package:birkon/model/order/preferences_order_provider.dart';
import 'package:birkon/prayer/prayer_content.dart';
import 'package:common/prayer.dart';
import 'package:common/prayer_reader.dart';
import 'package:chooser/chooser.dart';
import 'package:flutter/material.dart';

class PrayerScreen extends StatefulWidget {
  final int prayerId;

  PrayerScreen(this.prayerId);

  @override
  State<StatefulWidget> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  final GlobalKey headerKey = new GlobalKey();

  StreamController<LanguageUpdateEvent> languageSelectorStream;
  PrayerScreenViewModel viewModel = PrayerScreenViewModel();

  Data data;

  @override
  void initState() {
    languageSelectorStream = StreamController<LanguageUpdateEvent>.broadcast();

    languageSelectorStream.stream.listen((event) {
      if (event is LanguageUpdateRequired) {
        setState(() {
          viewModel.displayOverlay = true;
          viewModel.showCollapsedOverlay = true;
          viewModel.headerHeight = event.headerHeight;
          viewModel.screenWidth = context.size.width;
        });
      }
      if (event is LanguageUpdateFinished) {
        setState(() {
          viewModel.displayOverlay = false;
          data = data.copyWith(languageId: event.newLanguageCode);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    languageSelectorStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return _loadPrayer(context);
    }

    return _buildContent(data);
  }

  FutureBuilder<Data> _loadPrayer(BuildContext context) {
    final prayerReader = PrayerReader(FlutterPlayerAssetLoader(context));

    LocaleOrderProvider localeOrderProvider = new LocaleOrderProvider(context);
    PreferencesOrderProvider preferencesOrderProvider =
        new PreferencesOrderProvider();
    OrderProvider orderProvider =
        new OrderProvider(preferencesOrderProvider, localeOrderProvider);

    Future<Prayer> prayer = prayerReader.readPrayer(_getPrayerPath(widget.prayerId));
    Future<Order> order = orderProvider.loadOrder();

    return new FutureBuilder(
        future: _loadData(prayer, order),
        builder: (BuildContext context, AsyncSnapshot<Data> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: SizedBox.fromSize(
                    child: CircularProgressIndicator(),
                    size: Size(32.0, 32.0),
                  ));
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return _buildContent(snapshot.data);
          }
        });
  }

  Stack _buildContent(Data data) {
    this.data = data;

    return Stack(
      children: <Widget>[
        PrayerContent(
          headerKey: headerKey,
          languageId: data.languageId,
          prayer: data.prayer,
          languageStream: languageSelectorStream,
        ),
        _buildOverlay(data),
      ],
    );
  }

  _buildOverlay(Data data) {
    if (viewModel.displayOverlay) {
      return Chooser(
        ids: [data.order.primary, data.order.secondary, data.order.ternary],
        actionsBuilder: (context, key, id, pressed) => HeaderButton(
          key: key,
          text: AppLocalizations.getFromKey(context, id),
          onPressed: pressed,
        ),
        header: Header(
          prayer: data.prayer,
          languageCode: data.languageId,
          languageStream: languageSelectorStream.stream,
        ),
        showCollapsed: viewModel.showCollapsedOverlay,
        initialValue: data.languageId,
        provideHeight: () {
          if (viewModel.headerHeight != null) {
            return viewModel.headerHeight;
          }
          return headerKey.currentContext.size.height;
        },
        screenWidth: viewModel.screenWidth,
        chooserSink: StreamController()
          ..stream.listen((state) {
            if (state is ChooserStarted) {
              languageSelectorStream.add(LanguageUpdateEvent.started(state.id));
            }
            if (state is ChooserFinished) {
              languageSelectorStream
                  .add(LanguageUpdateEvent.finished(state.id));
            }
          }),
      );
    }

    return SizedBox();
  }

  Future<Data> _loadData(Future<Prayer> prayer, Future<Order> order) async {
    final syncOrder = await order;
    return new Data(await prayer, syncOrder, syncOrder.primary);
  }
}

class PrayerScreenViewModel {
  bool displayOverlay = true;
  bool showCollapsedOverlay = false;
  double headerHeight;
  double screenWidth;
}

class Data {
  final Prayer prayer;
  final Order order;
  final int languageId;

  Data(this.prayer, this.order, this.languageId);

  copyWith({int languageId}) {
    return Data(this.prayer, this.order, languageId);
  }
}

String _getPrayerPath(int prayerId) {
  switch (prayerId) {
    case BIRKAT_HA_MAZON:
      return "assets/prayers/birkat_hamazon.json";
    case SHMA_ISRAEL:
      return "assets/prayers/shma_israel.json";
    default:
      return null;
  }
}

typedef void SettingsItemClickListener();
