import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangeID extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  ChangeID({@required this.hint, @required this.controller});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Container(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.only(left: width * 0.09, right: width * 0.09, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID',
                style: TextStyle(
                    fontFamily: 'Medium', fontSize: 16, color: Colors.black87),
              ),
              SizedBox(width: 20),
              Container(
                height: 30,
                width: width * 0.65,
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: HexColor("#7b7b7b"))),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 15,
                      color: HexColor("#7b7b7b"),
                    ),
                  ),
                  controller: controller,
                ),
              )
            ],
          ),
        ));
  }
}
