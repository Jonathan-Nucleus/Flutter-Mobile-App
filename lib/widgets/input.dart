import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class InputField extends StatelessWidget {
  final bool obscure;
  final String hint;
  final double width;
  final Function validator;
  final TextEditingController controller;

  InputField({
    @required this.obscure,
    @required this.hint,
    @required this.width,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        child: Material(
          child: TextFormField(
            obscureText: obscure,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.grey[300])),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: Colors.grey[300]),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: Colors.grey[300]),
              ),
              contentPadding: EdgeInsets.only(top: 5, left: 15),
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'Medium',
                fontSize: 13,
                color: HexColor("#7b7b7b"),
              ),
            ),
            validator: validator,
            controller: controller,
          ),
        ));
  }
}
