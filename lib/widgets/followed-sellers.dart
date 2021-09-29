import 'package:flutter/material.dart';

class FollowedSellers extends StatelessWidget {
  final String image;
  final String id;
  final Function onPressed;

  FollowedSellers({@required this.image, @required this.id, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          InkResponse(
            onTap: onPressed,
            child: ClipOval(
              child: Container(
                color: Colors.grey[200],
                child: Image(
                  image: NetworkImage(image),
                  height: 80,
                  width: 80,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            id,
            style: TextStyle(
                fontFamily: "Medium", fontSize: 15, color: Colors.black87),
          )
        ],
      ),
    );
  }
}
