import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  final String profile;
  final String id;
  final Function onPressed;

  Ranking({@required this.profile, @required this.id, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            ClipOval(
              child: Image(
                image: NetworkImage(profile),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
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
      ),
    );
  }
}
