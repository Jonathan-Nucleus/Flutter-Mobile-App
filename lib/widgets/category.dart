import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String image;
  final String category;
  final int productsCount;
  final Function onPressed;

  Category({
    this.image,
    this.category,
    this.productsCount,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 140,
              width: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: Colors.grey[300],
                  child: Image(image: NetworkImage(image), fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
                top: 120,
                child: Text(
                  category,
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
