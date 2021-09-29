import 'package:flutter/material.dart';

class PhotoFrame extends StatelessWidget {
  final String text;
  

  PhotoFrame({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        Icons.add_circle_outline,
        color: Colors.grey[800],
        size: 22,
      ),
      SizedBox(height: 5),
      Text(
        text,
        style: TextStyle(
            fontFamily: 'Medium', fontSize: 12, color: Colors.grey[400]),
      ),
    ]);
  }
}
