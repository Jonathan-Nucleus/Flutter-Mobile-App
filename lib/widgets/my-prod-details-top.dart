import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client/routes/routes.dart';

class MyProductDetailsTop extends StatefulWidget {
  final String profile;
  final String username;
  final String follow;
  final List images;
  final bool bookmark;
  final String description;

  MyProductDetailsTop(
      {this.profile,
      this.username,
      this.follow,
      this.images,
      this.bookmark,
      this.description});
  @override
  _MyProductDetailsTopState createState() => _MyProductDetailsTopState();
}

class _MyProductDetailsTopState extends State<MyProductDetailsTop> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
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
                ),
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
                      height: 400,
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
          padding: EdgeInsets.only(left: 10, right: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                style: TextStyle(
                    fontFamily: 'Bold', fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.description,
                    style: TextStyle(
                        fontFamily: 'Medium',
                        fontSize: 15,
                        color: Colors.black87),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
