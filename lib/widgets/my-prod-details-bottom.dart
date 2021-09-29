import 'package:flutter/material.dart';

class MyProductDetailsBottom extends StatefulWidget {
  final String price;
  final String brand;
  final String category;
  final String style;
  final String condition;
  final String size;

  MyProductDetailsBottom(
      {this.price,
      this.brand,
      this.category,
      this.style,
      this.condition,
      this.size});
  @override
  _MyProductDetailsBottomState createState() => _MyProductDetailsBottomState();
}

class _MyProductDetailsBottomState extends State<MyProductDetailsBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 15, left: 10, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.price,
              style: TextStyle(
                  fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '브랜드',
                  style: TextStyle(
                      fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
                ),
                Text(
                  widget.brand,
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 15,
                      color: Colors.black87),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '상품 카테고리',
                  style: TextStyle(
                      fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
                ),
                Text(
                  widget.category,
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 15,
                      color: Colors.black87),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '스타일',
              style: TextStyle(
                  fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 3),
            Text(widget.style),
            SizedBox(height: 10),
            Text(
              '의류 상태',
              style: TextStyle(
                  fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 3),
            Text(widget.condition),
            SizedBox(height: 10),
            Text(
              '사이즈',
              style: TextStyle(
                  fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 3),
            Text(widget.size),
            SizedBox(height: 10),
            SizedBox(height: 20),
          ],
        ));
  }
}
