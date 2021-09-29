import 'dart:io';
import 'package:client/widgets/details-input.dart';
import 'package:http_parser/http_parser.dart';
import 'package:client/graphql/mutations.dart';
import 'package:client/widgets/modals/categories.dart';
import 'package:client/widgets/modals/floating-modal.dart';
import 'package:client/widgets/modals/image-options.dart';
import 'package:client/widgets/modals/upload-fail.dart';
import 'package:client/widgets/modals/upload-success.dart';
import 'package:client/widgets/section-title.dart';
import 'package:client/widgets/upload-info.dart';
import 'package:client/widgets/upload-input.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class UploadProduct extends StatefulWidget {
  @override
  _UploadProductState createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  File _image1;
  File _image2;
  File _image3;
  File _image4;
  File _image5;
  File _image6;

  final _formKey = GlobalKey<FormState>();

  //text-controllers
  var _priceController = TextEditingController();
  var _brandController = TextEditingController();
  dynamic _categoryValue = '카테고리 선택';
  var _conditionController = TextEditingController();
  var _sizeController = TextEditingController();
  var _styleController = TextEditingController();
  var _descriptionController = TextEditingController();

  var picker = ImagePicker();

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
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    var uploadImageList = [
      _image1,
      _image2,
      _image3,
      _image4,
      _image5,
      _image6
    ];

    var imageList = [];

    // print(_image1);

    uploadImageList.forEach((_image) {
      if (_image != null) {
        var byteData = _image.readAsBytesSync();
        var imageValue = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: '${randomString(20)}.jpg',
          contentType: MediaType("image", "jpg"),
        );

        imageList.add(imageValue);
      }
    });

    return Mutation(
        options: MutationOptions(
          document: gql(createProduct),
          update: (GraphQLDataProxy cache, QueryResult result) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
            var value = resultData['createProduct'];
            if (value == true) {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => UploadSuccessModal(),
              );
            } else if (value != true) {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => UploadFailedModal(),
              );
            } else if (value == null) {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => UploadFailedModal(),
              );
            }
            setState(() {
              _image1 = null;
              _image2 = null;
              _image3 = null;
              _image4 = null;
              _image5 = null;
              _image6 = null;
              _priceController.text = '';
              _brandController.text = '';
              _categoryValue = '카테고리 선택';
              _conditionController.text = '';
              _sizeController.text = '';
              _styleController.text = '';
              _descriptionController.text = '';
            });
          },
        ),
        builder: (RunMutation runMutation, QueryResult result) {
          if (result.hasException) {
            print(result.toString());
            return Container(
                color: Colors.white,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Upload Error, Try again!',
                      style: TextStyle(color: Colors.black87, fontSize: 11),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Okay',
                          style: TextStyle(
                            fontFamily: "medium",
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.black87)),
                    SizedBox(height: 25),
                  ],
                )));
          }

          if (result.isLoading) {
            return Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
                  ),
                ));
          }

          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  'Upload Product',
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      height: width * 0.3,
                                      width: width * 0.3,
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
                                              fit: BoxFit.cover,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        color:
                                                            Colors.grey[400]),
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
                                      height: width * 0.3,
                                      width: width * 0.3,
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
                                              fit: BoxFit.cover,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        color:
                                                            Colors.grey[400]),
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
                                      height: width * 0.3,
                                      width: width * 0.3,
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
                                              fit: BoxFit.cover,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        color:
                                                            Colors.grey[400]),
                                                  ),
                                                ]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      height: width * 0.3,
                                      width: width * 0.3,
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
                                              fit: BoxFit.cover,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        color:
                                                            Colors.grey[400]),
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
                                      height: width * 0.3,
                                      width: width * 0.3,
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
                                              fit: BoxFit.cover,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        color:
                                                            Colors.grey[400]),
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
                                      height: width * 0.3,
                                      width: width * 0.3,
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
                                              fit: BoxFit.cover,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        color:
                                                            Colors.grey[400]),
                                                  ),
                                                ]),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: SectionTitle(title: '상품 정보 입력'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 10),
                                  child: UploadInput(
                                    obscure: false,
                                    hint: "가격 입력",
                                    width: width * 0.95,
                                    text: Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text(
                                        '원',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                                    controller: _priceController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "* Required";
                                      } else {
                                        _formKey.currentState.save();
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(top: 10),
                                      child: UploadInput(
                                        obscure: false,
                                        hint: "브랜드 입력",
                                        width: width * 0.65,
                                        controller: _brandController,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "* Required";
                                          } else {
                                            _formKey.currentState.save();
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 7),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        height: 48,
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            setState(() {
                                              _brandController.text = "브랜드 없음";
                                            });
                                          },
                                          child: Center(
                                            child: Text(
                                              '브랜드 없음',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                InkResponse(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    showFloatingModalBottomSheet(
                                      context: context,
                                      builder: (context) => CategoriesModal(
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Text(
                                                '카테고리 선택',
                                                style: TextStyle(
                                                  fontFamily: "Bold",
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount: catListAll.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    _dynamicView() {
                                                      if (index == 0) {
                                                        return showFloatingModalBottomSheet(
                                                            context: context,
                                                            builder: (context) =>
                                                                CategoriesModal(
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          '상의',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Bold",
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              15),
                                                                      Expanded(
                                                                          child: ListView.builder(
                                                                              itemCount: catSub1.length,
                                                                              itemBuilder: (BuildContext context, int index) {
                                                                                return Column(
                                                                                  children: [
                                                                                    Divider(),
                                                                                    ListTile(
                                                                                      visualDensity: VisualDensity(vertical: -4),
                                                                                      title: Text(
                                                                                        '${catSub1[index]}',
                                                                                        style: TextStyle(fontSize: 13, color: Colors.black87),
                                                                                      ),
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          _categoryValue = '${catListAll[0] + '/' + catSub1[index]}';
                                                                                        });
                                                                                        var nav = Navigator.of(context);
                                                                                        nav.pop();
                                                                                        nav.pop();
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              })),
                                                                      SizedBox(
                                                                          height:
                                                                              20),
                                                                    ],
                                                                  ),
                                                                ));
                                                      } else if (index == 1) {
                                                        return showFloatingModalBottomSheet(
                                                            context: context,
                                                            builder: (context) =>
                                                                CategoriesModal(
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          '하의',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Bold",
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              15),
                                                                      Expanded(
                                                                          child: ListView.builder(
                                                                              itemCount: catSub2.length,
                                                                              itemBuilder: (BuildContext context, int index) {
                                                                                return Column(
                                                                                  children: [
                                                                                    Divider(),
                                                                                    ListTile(
                                                                                      visualDensity: VisualDensity(vertical: -4),
                                                                                      title: Text(
                                                                                        '${catSub2[index]}',
                                                                                        style: TextStyle(fontSize: 13, color: Colors.black87),
                                                                                      ),
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          _categoryValue = '${catListAll[1] + '/' + catSub2[index]}';
                                                                                        });
                                                                                        var nav = Navigator.of(context);
                                                                                        nav.pop();
                                                                                        nav.pop();
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              })),
                                                                      SizedBox(
                                                                          height:
                                                                              20),
                                                                    ],
                                                                  ),
                                                                ));
                                                      } else if (index == 2) {
                                                        return showFloatingModalBottomSheet(
                                                            context: context,
                                                            builder: (context) =>
                                                                CategoriesModal(
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          '아우터',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Bold",
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              15),
                                                                      Expanded(
                                                                          child: ListView.builder(
                                                                              itemCount: catSub3.length,
                                                                              itemBuilder: (BuildContext context, int index) {
                                                                                return Column(
                                                                                  children: [
                                                                                    Divider(),
                                                                                    ListTile(
                                                                                      visualDensity: VisualDensity(vertical: -4),
                                                                                      title: Text(
                                                                                        '${catSub3[index]}',
                                                                                        style: TextStyle(fontSize: 13, color: Colors.black87),
                                                                                      ),
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          _categoryValue = '${catListAll[2] + '/' + catSub3[index]}';
                                                                                        });
                                                                                        var nav = Navigator.of(context);
                                                                                        nav.pop();
                                                                                        nav.pop();
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              })),
                                                                      SizedBox(
                                                                          height:
                                                                              20),
                                                                    ],
                                                                  ),
                                                                ));
                                                      } else if (index == 3) {
                                                        return showFloatingModalBottomSheet(
                                                            context: context,
                                                            builder: (context) =>
                                                                CategoriesModal(
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          '세트(원피스 등)',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Bold",
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              15),
                                                                      Expanded(
                                                                          child: ListView.builder(
                                                                              itemCount: catSub4.length,
                                                                              itemBuilder: (BuildContext context, int index) {
                                                                                return Column(
                                                                                  children: [
                                                                                    Divider(),
                                                                                    ListTile(
                                                                                      visualDensity: VisualDensity(vertical: -4),
                                                                                      title: Text(
                                                                                        '${catSub4[index]}',
                                                                                        style: TextStyle(fontSize: 13, color: Colors.black87),
                                                                                      ),
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          _categoryValue = '${catListAll[3] + '/' + catSub4[index]}';
                                                                                        });
                                                                                        var nav = Navigator.of(context);
                                                                                        nav.pop();
                                                                                        nav.pop();
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              })),
                                                                      SizedBox(
                                                                          height:
                                                                              20),
                                                                    ],
                                                                  ),
                                                                ));
                                                      }
                                                    }

                                                    _custom() {
                                                      if (index == 4 ||
                                                          index == 5 ||
                                                          index == 6) {
                                                        return ListTile(
                                                          visualDensity:
                                                              VisualDensity(
                                                                  vertical: -4),
                                                          title: Text(
                                                            '${catListAll[index]}',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black87),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              _categoryValue =
                                                                  '${catListAll[index]}';
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        );
                                                      } else {
                                                        return ListTile(
                                                          visualDensity:
                                                              VisualDensity(
                                                                  vertical: -4),
                                                          title: Text(
                                                            '${catListAll[index]}',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black87),
                                                          ),
                                                          onTap: () {
                                                            return _dynamicView();
                                                          },
                                                          trailing: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 15,
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                        );
                                                      }
                                                    }

                                                    return Column(
                                                      children: [
                                                        Divider(),
                                                        _custom(),
                                                      ],
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 48,
                                    margin: EdgeInsets.only(top: 10),
                                    padding: EdgeInsets.only(top: 5, left: 15),
                                    width: width * 0.95,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey[400]),
                                    ),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            _categoryValue,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[600]),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 15, bottom: 3),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SectionTitle(title: '의류 상태'),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 10),
                                  child: UploadInput(
                                    obscure: false,
                                    hint: "Details",
                                    width: width * 0.95,
                                    controller: _conditionController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "* Required";
                                      } else {
                                        _formKey.currentState.save();
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SectionTitle(title: '사이즈'),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 10),
                                  child: UploadInput(
                                    obscure: false,
                                    hint: "Details",
                                    width: width * 0.95,
                                    controller: _sizeController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "* Required";
                                      } else {
                                        _formKey.currentState.save();
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SectionTitle(title: '스타일'),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 10),
                                  child: UploadInput(
                                    obscure: false,
                                    hint: "Details",
                                    width: width * 0.95,
                                    controller: _styleController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "* Required";
                                      } else {
                                        _formKey.currentState.save();
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SectionTitle(title: '상품 설명 입력'),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 10),
                                  child: DetailsInput(
                                    obscure: false,
                                    hint: "Details",
                                    height: 100,
                                    width: width * 0.95,
                                    lines: 8,
                                    controller: _descriptionController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "* Required";
                                      } else {
                                        _formKey.currentState.save();
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            runMutation({
                              'images': imageList,
                              'price': int.parse(_priceController.text),
                              'brand': _brandController.text,
                              'category': _categoryValue,
                              'condition': _conditionController.text,
                              'size': _sizeController.text,
                              'style': _styleController.text,
                              'description': _descriptionController.text
                            });
                          } else {
                            return AlertDialog(
                              content: Text('Error, Something went wrong!'),
                            );
                          }
                        },
                        child: Container(
                          height: 80,
                          padding: EdgeInsets.only(bottom: 20),
                          color: HexColor("#711E97"),
                          child: Center(
                              child: Text('업로드',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
