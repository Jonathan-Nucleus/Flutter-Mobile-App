import 'package:client/routes/routes.dart';
import 'package:client/screens/search/search-bar-results.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;

    return Container(
      height: 40,
      width: width * 0.95,
      child: TextFormField(
        onFieldSubmitted: (String value) async {
          print('works');

          return Navigator.pushNamed(context, SearchBarRoute,
              arguments: MySearchArguments(value));
        },
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
          fillColor: Colors.grey[200],
          filled: true,
          hintText: "search...",
          hintStyle: TextStyle(
            fontFamily: 'Medium',
            fontSize: 14,
            color: HexColor("#7b7b7b"),
          ),
        ),
      ),
    );
  }
}
