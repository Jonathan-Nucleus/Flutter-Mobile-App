import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UploadInput extends StatelessWidget {
  final bool obscure;
  final String hint;
  final double width;
  final Widget text;
  final int lines;
  final String value;
  final double height;
  final Function validator;
  final TextEditingController controller;
  final Function onChanged;

  UploadInput(
      {@required this.obscure,
      @required this.hint,
      @required this.width,
      this.text,
      this.lines,
      this.height,
      this.value,
      this.onChanged,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        child: Material(
          child: TextFormField(
            initialValue: value,
            style: TextStyle(
              fontFamily: 'Medium',
              fontSize: 14,
              color: Colors.black87,
            ),
            obscureText: obscure,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.grey[400])),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: Colors.grey[400]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: Colors.grey[400]),
              ),
              contentPadding: EdgeInsets.only(top: 5, left: 15),
              hintText: hint,
              suffixIcon: text,
              hintStyle: TextStyle(
                fontFamily: 'Medium',
                fontSize: 13,
                color: HexColor("#7b7b7b"),
              ),
            ),
            controller: controller,
            validator: validator,
            onChanged: onChanged,
          ),
        ));
  }
}
