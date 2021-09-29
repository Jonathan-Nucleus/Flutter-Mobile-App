import 'package:flutter/material.dart';

class ChangePhoto extends StatelessWidget {
  final Widget image;
  final Function onPressed;

  ChangePhoto({@required this.image, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: height * 0.06),
            child: Column(
              children: [
                ClipOval(
                  child: Container(
                    color: Colors.grey[200],
                    child: image,
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    "프로필 수정하기",
                    style: TextStyle(
                        fontFamily: "Medium",
                        fontSize: 14,
                        color: Colors.blue[400]),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
