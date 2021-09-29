import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LargeButton extends StatelessWidget {
  final Function onPressed;
  final String name;
  final double width;
  final double font;

  LargeButton(
      {@required this.onPressed,
      @required this.name,
      @required this.width,
      this.font});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: width,
      child: Material(
        child: TextButton(
            child: Text(
              name,
              style: TextStyle(
                  fontFamily: 'Bold', fontSize: font, color: Colors.white),
            ),
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: HexColor("#711E97"),
            )),
      ),
    );
  }
}
