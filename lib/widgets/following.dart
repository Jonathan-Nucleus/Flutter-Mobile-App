import 'package:flutter/material.dart';

class FollowingAvatar extends StatelessWidget {
  final String image;
  final String id;
  final Function onPressed;

  FollowingAvatar({@required this.image, @required this.id, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        height: 80,
        padding: EdgeInsets.only(
          left: 15,
        ),
        margin: EdgeInsets.only(top: 10),
        color: Colors.grey[50],
        child: Row(
          children: [
            ClipOval(
              child: Container(
                color: Colors.grey[200],
                child: Image(
                  image: NetworkImage(image),
                  height: 70,
                  width: 70,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              id,
              style: TextStyle(
                  color: Colors.black87, fontSize: 16, fontFamily: 'Medium'),
            )
          ],
        ),
      ),
    );
  }
}
