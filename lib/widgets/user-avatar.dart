import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String image;
  final String id;

  UserAvatar({@required this.image, @required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipOval(
            child: Container(
              color: Colors.grey[200],
              child: Image(
                image: NetworkImage(image),
                width: 100,
                height: 100,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            id,
            style: TextStyle(
                fontFamily: "Bold", fontSize: 15, color: Colors.black87),
          )
        ],
      ),
    );
  }
}
