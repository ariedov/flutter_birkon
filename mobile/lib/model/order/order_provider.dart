import 'dart:async';

import 'package:birkon/model/order/locale_order_provider.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/order/preferences_order_provider.dart';

class OrderProvider {

  final PreferencesOrderProvider preferencesOrderProvider;
  final LocaleOrderProvider localeOrderProvider;

  OrderProvider(this.preferencesOrderProvider, this.localeOrderProvider);

  Future<Order> loadOrder() async {
    bool hasOrder = await preferencesOrderProvider.hasOrder();
    if (hasOrder) {
      return preferencesOrderProvider.loadOrder();
    } else {
      return localeOrderProvider.loadOrder();
    }
  }
}