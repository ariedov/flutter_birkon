import 'dart:async';

import 'package:birkon/model/order/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesOrderProvider {

  final Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  final String _hasOrderKey = "has_order";
  final String _primaryKey = "primary";
  final String _secondaryKey = "secondary";
  final String _ternaryKey = "ternary";

  Future<bool> hasOrder() async {
    SharedPreferences prefs = await preferences;
    return prefs.getKeys().contains(_hasOrderKey);
  }

  Future<Order> loadOrder() async {
    SharedPreferences prefs = await preferences;
    return new Order(
        prefs.getInt(_primaryKey),
        prefs.getInt(_secondaryKey),
        prefs.getInt(_ternaryKey)
    );
  }

  void saveOrder(int primary, int secondary, int ternary) async {
    SharedPreferences prefs = await preferences;
    prefs.setBool(_hasOrderKey, true);

    prefs.setInt(_primaryKey, primary);
    prefs.setInt(_secondaryKey, secondary);
    prefs.setInt(_ternaryKey, ternary);
  }
}