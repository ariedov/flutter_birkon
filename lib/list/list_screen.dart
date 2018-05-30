import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("app name"),
      ),
      body: new ListView(
        children: <Widget>[
          new Card(
            child: new Column(
              children: <Widget>[
                new Image(
                    image: new AssetImage('assets/graphics/birkat_hamazon.jpeg')
                ),
                new Text("birkat ha mazon")
              ],
            ),
          )
        ],
      ),
    );
  }

}