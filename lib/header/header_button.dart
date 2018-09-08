import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const HeaderButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200.0,
        child: OutlineButton(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPressed: onPressed,
        ));
  }
}
