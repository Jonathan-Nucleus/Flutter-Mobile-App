import 'package:flutter/material.dart';

class ImageOptions extends StatelessWidget {
  final Function onTapGallery;
  final Function onTapCamera;

  ImageOptions({@required this.onTapGallery, @required this.onTapCamera});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: EdgeInsets.only(top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Image Options',
            style: TextStyle(
              fontFamily: "Bold",
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Icon(
                          Icons.photo_library,
                          color: Colors.black87,
                        ),SizedBox(width: 25),
                        new Text(
                          'Photo Library',
                          style: TextStyle(
                            fontFamily: "Regular",
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: onTapGallery,
                ),
                new ListTile(
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Icon(
                          Icons.photo_camera,
                          color: Colors.black87,
                        ),
                        SizedBox(width: 65),
                        new Text(
                          'Camera',
                          style: TextStyle(
                            fontFamily: "Regular",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: onTapCamera,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
