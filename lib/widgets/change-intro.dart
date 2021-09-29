import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangeIntro extends StatelessWidget {
  final String intro;
  final TextEditingController controller;

  ChangeIntro({@required this.intro, @required this.controller});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Container(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.only(left: width * 0.09, right: width * 0.09, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '자기소개',
                style: TextStyle(
                    fontFamily: 'Medium', fontSize: 15, color: Colors.black87),
              ),
              SizedBox(width: 10),
              Container(
                height: 200,
                width: width * 0.65,
                child: TextField(
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: HexColor("#7b7b7b"))),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    contentPadding: EdgeInsets.only(left: 15, top: 10),
                    hintText: intro,
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
