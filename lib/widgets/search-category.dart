import 'package:flutter/material.dart';

class SearchCategory extends StatelessWidget {
  final String category;
  final String image;
  final Function onPressed;

  SearchCategory({this.category, this.onPressed, this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    child: Image.network(
                      image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    height: 100,
                    width: 100,
                  )),
            ),
            Positioned(
                top: 60,
                child: Text(
                  category,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )),
          ],
        ),
      ),
    );
  }
}
