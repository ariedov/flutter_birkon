import 'package:birkon/localization/keys.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/order/order.dart';
import 'package:birkon/model/order/preferences_order_provider.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:flutter/material.dart';

class PrefsScreen extends StatelessWidget {

  final Order initialOrder;
  final PreferencesOrderProvider prefsOrderProvider;

  const PrefsScreen({Key key, this.initialOrder, this.prefsOrderProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> items = [initialOrder.primary, initialOrder.secondary, initialOrder.ternary];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppLocalizations.get(context, ORDER)),
      ),
      body: new DragAndDropList<int>(
        items,
        canBeDraggedTo: (oldIndex, newIndex) => true,
        itemBuilder: (BuildContext context, item) => new Card(
            child: new ListTile(
                leading: new Icon(Icons.dehaze),
                title: new Text(AppLocalizations.get(context, item))
            )
        ),
        onDragFinish: (before, after) {
          int data = items[before];
          items.removeAt(before);
          items.insert(after, data);

          _saveOrder(items[0], items[1], items[2]);
        },
      ),
    );
  }

  void _saveOrder(int primary, int secondary, int ternary) {
    prefsOrderProvider.saveOrder(primary, secondary, ternary);
  }
}