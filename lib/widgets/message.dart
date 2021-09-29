import 'package:flutter/material.dart';

class MessageDetails extends StatelessWidget {
  final dynamic roomId;
  final dynamic seller;
  final dynamic stamp;
  final dynamic text;
  final dynamic unread;
  final Function onPressed;

  MessageDetails(
      {this.roomId,
      this.seller,
      this.stamp,
      this.text,
      this.unread,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    _unreadCondition() {
      if (unread == '0') {
        return Container();
      } else {
        return Container(
          height: 25,
          width: 25,
          padding: EdgeInsets.all(2),
          decoration: new BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: Text(
            unread,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              height: 1.5,
              fontFamily: "Medium",
            ),
          )),
        );
      }
    }

    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height * 0.1,
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  seller,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: "Medium"),
                ),
                SizedBox(height: 5),
                Text(
                  stamp,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontFamily: "Medium"),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: width * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        height: 1.5,
                        fontFamily: "Medium",
                      ),
                      maxLines: 2,
                    ),
                  ),
                  _unreadCondition(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
