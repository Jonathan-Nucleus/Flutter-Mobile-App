import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SendInput extends StatelessWidget {
  final TextEditingController textController;
  final Function onPressed;
  final Function validator;

  SendInput({this.textController, this.onPressed, this.validator});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Container(
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: width * 0.75,
              child: TextFormField(
                validator: validator,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  contentPadding: EdgeInsets.only(top: 5, left: 15),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "send message...",
                  hintStyle: TextStyle(
                    fontFamily: 'Medium',
                    fontSize: 14,
                    color: HexColor("#7b7b7b"),
                  ),
                ),
                controller: textController,
              ),
            ),
            SizedBox(width: 5),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Colors.purple[400],
              icon: Icon(MdiIcons.telegram),
              iconSize: 30,
              onPressed: onPressed,
            ),
          ],
        ));
  }
}
