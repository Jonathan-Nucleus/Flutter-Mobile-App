import 'package:flutter/material.dart';

class DeleteModal extends StatelessWidget {
  final Function onPressedDelete;

  const DeleteModal({this.onPressedDelete});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Container(
      height: 190,
      padding: EdgeInsets.only(top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '상품 삭제',
            style: TextStyle(
              fontFamily: "Bold",
              fontSize: 20,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '상품을 정말 삭제하시겠습니까?',
            style: TextStyle(
              fontFamily: "medium",
              fontSize: 14,
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.25,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '취소',
                        style: TextStyle(
                          fontFamily: "medium",
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[400])),
                ),
                SizedBox(width: 15),
                Container(
                  width: width * 0.25,
                  child: TextButton(
                      onPressed: onPressedDelete,
                      child: Text(
                        '삭제',
                        style: TextStyle(
                          fontFamily: "medium",
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black87)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
