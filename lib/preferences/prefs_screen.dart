import 'package:birkon/localization/keys.dart';
import 'package:birkon/localization/localizations.dart';
import 'package:birkon/preferences/view/sortable_list_view.dart';
import 'package:flutter/material.dart';

class PrefsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List items = new List()
      ..add("String 1")
      ..add("String 2")
      ..add("String 3");

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