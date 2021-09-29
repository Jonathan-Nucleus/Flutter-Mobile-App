import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetailsTop extends StatefulWidget {
  final String profile;
  final String username;
  final String follow;
  final Function onFollowAction;
  final List images;
  final Widget bookmark;
  final String description;
  final bool showFollowUnfollowButton;
  final Color followColor;
  final Color textColor;
  final Function onPressed;

  ProductDetailsTop(
      {this.profile,
      this.username,
      this.follow,
      this.images,
      this.bookmark,
      this.description,
      this.onFollowAction,
      this.followColor,
      this.textColor,
      this.onPressed,
      this.showFollowUnfollowButton});
  @override
  _ProductDetailsTopState createState() => _ProductDetailsTopState();
}

class _ProductDetailsTopState extends State<ProductDetailsTop> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
          child: Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: widget.onPressed,
                child: Row(
                  children: [
                    ClipOval(
                      child: Image(
                        image: NetworkImage(widget.profile),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.username,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Visibility(
                visible: widget.showFollowUnfollowButton,
                child: Container(
                  height: 30,
                  width: 100,
                  child: Material(
                    child: TextButton(
                        child: Text(
                          widget.follow,
                          style: TextStyle(
                              fontFamily: 'Bold',
                              fontSize: 13,
                              color: widget.textColor),
                        ),
                        onPressed: widget.onFollowAction,
                        style: TextButton.styleFrom(
                          backgroundColor: widget.followColor,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: HexColor("#711E97"),
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(18.0)),
                        )),
                  ),
                ),
              ),
            ],
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
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10, right: 20, top: 5),
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
              SizedBox(width: 15)
            ],
          ),
        )
      ],
    );
  }
}
