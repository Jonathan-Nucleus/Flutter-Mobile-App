import 'package:client/widgets/search-category.dart';
import 'package:flutter/material.dart';

class SearchListview extends StatelessWidget {
  final String category1;
  final Function onPressed1;
  final String category2;
  final Function onPressed2;
  final String category3;
  final Function onPressed3;
  final String category4;
  final Function onPressed4;
  final String category5;
  final Function onPressed5;

  SearchListview(
      {this.category1,
      this.onPressed1,
      this.category2,
      this.onPressed2,
      this.category3,
      this.onPressed3,
      this.category4,
      this.onPressed4,
      this.category5,
      this.onPressed5});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(right: 10),
        children: [
          SearchCategory(category: category1, onPressed: onPressed1),
          SearchCategory(category: category2, onPressed: onPressed2),
          SearchCategory(category: category3, onPressed: onPressed3),
          SearchCategory(category: category4, onPressed: onPressed4),
          SearchCategory(category: category5, onPressed: onPressed5),
        ],
      ),
    );
  }
}
