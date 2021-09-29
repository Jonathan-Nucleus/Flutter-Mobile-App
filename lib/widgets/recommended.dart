import 'package:flutter/material.dart';

class Recommended extends StatelessWidget {
  final String product;
  final String profile;
  final String price;
  final Function onPressed;

  Recommended(
      {@required this.product,
      @required this.profile,
      @required this.price,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Stack(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: onPressed,
            child: Container(
              height: 140,
              width: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: NetworkImage(product),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              top: 80,
              left: 10,
              child: Row(
                children: [
                  ClipOval(
                    child: Image(
                      image: NetworkImage(profile),
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    price,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
