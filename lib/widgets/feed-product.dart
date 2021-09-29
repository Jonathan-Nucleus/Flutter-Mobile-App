import 'package:client/screens/home/seller-shop.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client/routes/routes.dart';

class FeedProduct extends StatefulWidget {
  final String profile;
  final String username;
  final List images;
  final String description;
  final String productId;
  final Function onPressed;
  final Icon bookmark;
  final String userId;

  FeedProduct(
      {this.profile,
      this.username,
      this.images,
      this.description,
      this.productId,
      this.onPressed,
      this.bookmark,
      this.userId});
  @override
  _FeedProductState createState() => _FeedProductState();
}

class _FeedProductState extends State<FeedProduct> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, SellershopRoute,
                arguments: SellerShopRouteArguments(widget.userId));
          },
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
            child: Row(
              children: [
                ClipOval(
                  child: Image(
                    image: NetworkImage(widget.profile),
                    height: 50,
                    width: 50,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  widget.username,
                  style: TextStyle(color: Colors.black87),
                )
              ],
            ),
          ),
        ),
        Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                color: Colors.grey[200],
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 375,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: widget.images
                      .map((item) => Container(
                            child: Center(
                                child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              height: 400,
                              width: 500,
                            )),
                          ))
                      .toList(),
                ),
              ),
              Positioned(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.images.map((url) {
                      int index = widget.images.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Colors.purple[700]
                                : Colors.grey[100]),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 6, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 2), child: widget.bookmark),
              Container(
                width: 100,
                child: TextButton(
                    onPressed: widget.onPressed,
                    child: Text(
                      '제품 보기',
                      style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 12,
                          color: Colors.white),
                    ),
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.black87)),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10, right: 20, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                style: TextStyle(
                    fontFamily: 'Bold', fontSize: 16, color: Colors.black87),
              ),
              Text(
                widget.description,
                style: TextStyle(
                    fontFamily: 'Medium', fontSize: 15, color: Colors.black87),
              ),
              SizedBox(width: 15),
            ],
          ),
        )
      ],
    );
  }
}
