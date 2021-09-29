import 'package:flutter/material.dart';

class EditedModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.only(top: 45),
      child: Column(
        children: [
          Text(
            'Verification Successful',
            style: TextStyle(
              fontFamily: "Bold",
              fontSize: 20,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Your number has been updated',
            style: TextStyle(
              fontFamily: "medium",
              fontSize: 14,
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(left: 100, right: 100),
            child: Container(
              width: 100,
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Okay',
                    style: TextStyle(
                      fontFamily: "medium",
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.black87)),
            ),
          )
        ],
      ),
    );
  }
}
