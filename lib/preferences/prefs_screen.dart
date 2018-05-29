import 'package:birkon/localization/keys.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/model/order_provider.dart';
import 'package:birkon/preferences/view/sortable_list_view.dart';
import 'package:flutter/material.dart';

class PrefsScreen extends StatelessWidget {

  final OrderProvider orderProvider;

  const PrefsScreen({Key key, this.orderProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List items = new List()
      ..add(AppLocalizations.get(context, orderProvider.primaryTitle))
      ..add(AppLocalizations.get(context, orderProvider.secondaryTitle))
      ..add(AppLocalizations.get(context, orderProvider.ternaryTitle));

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppLocalizations.get(context, SETTINGS)),
      ),
      body: new SortableListView(
        items: items,
        itemBuilder: (_, index) => new Card(
            child: new ListTile(
                leading: new Icon(Icons.dehaze),
                title: new Text(items[index])
            )
        ),

      ),
    );
  }
}