import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailsInput extends StatelessWidget {
  final bool obscure;
  final String hint;
  final double width;
  final Widget text;
  final int lines;
  final double height;
  final String value;
  final Function validator;
  final Function onChanged;
  final TextEditingController controller;

  DetailsInput(
      {@required this.obscure,
      @required this.hint,
      @required this.width,
      this.text,
      this.lines,
      this.value,
      this.height,
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
            minLines: lines,
            maxLines: 10,
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
              contentPadding: EdgeInsets.only(top: 25, left: 15),
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
