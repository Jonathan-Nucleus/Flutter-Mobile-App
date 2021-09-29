import 'package:flutter/material.dart';

class ProductDetailsBottom extends StatelessWidget {
  final String price;
  final String brand;
  final String category;
  final String style;
  final String condition;
  final String size;
  final Function onPressed;

  ProductDetailsBottom(
      {this.price,
      this.brand,
      this.category,
      this.style,
      this.condition,
      this.size,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 15, left: 10, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              price,
              style: TextStyle(
                  fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '브랜드',
                  style: TextStyle(
                      fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
                ),
                Text(
                  brand,
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 15,
                      color: Colors.black87),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '상품 카테고리',
                  style: TextStyle(
                      fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
                ),
                Text(
                  category,
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 15,
                      color: Colors.black87),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              '스타일',
              style: TextStyle(
                  fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(style),
            SizedBox(height: 15),
            Text(
              '의류 상태',
              style: TextStyle(
                  fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(condition),
            SizedBox(height: 15),
            Text(
              '사이즈',
              style: TextStyle(
                  fontFamily: 'Bold', fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(size),
            SizedBox(height: 15),
            SizedBox(height: 25),
          ],
        ));
  }
}
