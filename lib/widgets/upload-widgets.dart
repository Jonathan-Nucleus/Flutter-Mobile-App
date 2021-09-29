import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'modals/floating-modal.dart';
import 'modals/image-options.dart';

class UploadWidgets extends StatefulWidget {
  @override
  _UploadWidgetsState createState() => _UploadWidgetsState();
}

class _UploadWidgetsState extends State<UploadWidgets> {
  File _image1;
  File _image2;
  File _image3;
  File _image4;
  File _image5;
  File _image6;

  final picker = ImagePicker();

  // image one
  Future getImageFromCamera1() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery1() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // image two
  Future getImageFromCamera2() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery2() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // image three
  Future getImageFromCamera3() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image3 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery3() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image3 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // image four
  Future getImageFromCamera4() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image4 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery4() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image4 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // image five
  Future getImageFromCamera5() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image5 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery5() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image5 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // image six
  Future getImageFromCamera6() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image6 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery6() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image6 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkResponse(
                onTap: () {
                  showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => ImageOptions(
                            onTapCamera: () {
                              getImageFromCamera1();
                              Navigator.of(context).pop();
                            },
                            onTapGallery: () {
                              getImageFromGallery1();
                              Navigator.of(context).pop();
                            },
                          ));
                },
                child: Container(
                  height: 125,
                  width: 125,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  child: _image1 != null
                      ? Image.file(
                          _image1,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey[800],
                                size: 22,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '썸네일',
                                style: TextStyle(
                                    fontFamily: 'Medium',
                                    fontSize: 12,
                                    color: Colors.grey[400]),
                              ),
                            ]),
                ),
              ),
              InkResponse(
                onTap: () {
                  showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => ImageOptions(
                            onTapCamera: () {
                              getImageFromCamera2();
                              Navigator.of(context).pop();
                            },
                            onTapGallery: () {
                              getImageFromGallery2();
                              Navigator.of(context).pop();
                            },
                          ));
                },
                child: Container(
                  height: 125,
                  width: 125,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  child: _image2 != null
                      ? Image.file(
                          _image2,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey[800],
                                size: 22,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '앞면',
                                style: TextStyle(
                                    fontFamily: 'Medium',
                                    fontSize: 12,
                                    color: Colors.grey[400]),
                              ),
                            ]),
                ),
              ),
              InkResponse(
                onTap: () {
                  showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => ImageOptions(
                            onTapCamera: () {
                              getImageFromCamera3();
                              Navigator.of(context).pop();
                            },
                            onTapGallery: () {
                              getImageFromGallery3();
                              Navigator.of(context).pop();
                            },
                          ));
                },
                child: Container(
                  height: 125,
                  width: 125,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  child: _image3 != null
                      ? Image.file(
                          _image3,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey[800],
                                size: 22,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '뒤면',
                                style: TextStyle(
                                    fontFamily: 'Medium',
                                    fontSize: 12,
                                    color: Colors.grey[400]),
                              ),
                            ]),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkResponse(
                onTap: () {
                  showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => ImageOptions(
                            onTapCamera: () {
                              getImageFromCamera4();
                              Navigator.of(context).pop();
                            },
                            onTapGallery: () {
                              getImageFromGallery4();
                              Navigator.of(context).pop();
                            },
                          ));
                },
                child: Container(
                  height: 125,
                  width: 125,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  child: _image4 != null
                      ? Image.file(
                          _image4,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey[800],
                                size: 22,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '라벨',
                                style: TextStyle(
                                    fontFamily: 'Medium',
                                    fontSize: 12,
                                    color: Colors.grey[400]),
                              ),
                            ]),
                ),
              ),
              InkResponse(
                onTap: () {
                  showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => ImageOptions(
                            onTapCamera: () {
                              getImageFromCamera5();
                              Navigator.of(context).pop();
                            },
                            onTapGallery: () {
                              getImageFromGallery5();
                              Navigator.of(context).pop();
                            },
                          ));
                },
                child: Container(
                  height: 125,
                  width: 125,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  child: _image5 != null
                      ? Image.file(
                          _image5,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey[800],
                                size: 22,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '디테일 1',
                                style: TextStyle(
                                    fontFamily: 'Medium',
                                    fontSize: 12,
                                    color: Colors.grey[400]),
                              ),
                            ]),
                ),
              ),
              InkResponse(
                onTap: () {
                  showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => ImageOptions(
                            onTapCamera: () {
                              getImageFromCamera6();
                              Navigator.of(context).pop();
                            },
                            onTapGallery: () {
                              getImageFromGallery6();
                              Navigator.of(context).pop();
                            },
                          ));
                },
                child: Container(
                  height: 125,
                  width: 125,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  child: _image6 != null
                      ? Image.file(
                          _image6,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey[800],
                                size: 22,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '디테일 2',
                                style: TextStyle(
                                    fontFamily: 'Medium',
                                    fontSize: 12,
                                    color: Colors.grey[400]),
                              ),
                            ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
