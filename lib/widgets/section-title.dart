import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style:
            TextStyle(fontFamily: "Bold", fontSize: 15, color: Colors.black87),
      ),
    );
  }
}
