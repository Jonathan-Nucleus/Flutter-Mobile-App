import 'dart:io';
import 'package:client/graphql/queries.dart';
import 'package:client/widgets/category-input.dart';
import 'package:client/widgets/details-input.dart';
import 'package:client/widgets/modals/edited-fail.dart';
import 'package:client/widgets/modals/edited-success.dart';
import 'package:client/widgets/photo-frame.dart';
import 'package:http_parser/http_parser.dart';
import 'package:client/graphql/mutations.dart';
import 'package:client/widgets/modals/categories.dart';
import 'package:client/widgets/modals/floating-modal.dart';
import 'package:client/widgets/modals/image-options.dart';
import 'package:client/widgets/section-title.dart';
import 'package:client/widgets/upload-info.dart';
import 'package:client/widgets/upload-input.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:validators/validators.dart' as validator;

class EditProductArguments {
  final String productId;

  EditProductArguments(this.productId);
}

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File _image1;
  File _image2;
  File _image3;
  File _image4;
  File _image5;
  File _image6;

  final _formKey = GlobalKey<FormState>();

  var picker = ImagePicker();

  _getRemovedImageIndexes(selectedProduct) {
    final removedImagesIndexes = [];

    if (_image1 != null && selectedProduct['images'].length > 0) {
      removedImagesIndexes.add(0);
    }

    if (_image2 != null && selectedProduct['images'].length > 1) {
      removedImagesIndexes.add(1);
    }

    if (_image3 != null && selectedProduct['images'].length > 2) {
      removedImagesIndexes.add(2);
    }

    if (_image4 != null && selectedProduct['images'].length > 3) {
      removedImagesIndexes.add(3);
    }

    if (_image5 != null && selectedProduct['images'].length > 4) {
      removedImagesIndexes.add(4);
    }

    if (_image6 != null && selectedProduct['images'].length > 5) {
      removedImagesIndexes.add(5);
    }

    return removedImagesIndexes;
  }

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

  var _categoryController = '';
  var _priceController = '';
  var _brandController = '';

  @override
  Widget build(BuildContext context) {
    final EditProductArguments routeArgs =
        ModalRoute.of(context).settings.arguments;

    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var uploadImageList = [
      _image1,
      _image2,
      _image3,
      _image4,
      _image5,
      _image6
    ];

    var imageList = [];

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

    return Query(
        options: QueryOptions(
          document: gql(fetchUser),
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Container(
                child: Center(child: Text(result.exception.toString())));
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

          var myProducts = result.data['fetchUser']['myProducts'];

          var selectedProduct = myProducts
              .firstWhere((product) => product['_id'] == routeArgs.productId);

          //text-controllers

          var _conditionController =
              TextEditingController(text: selectedProduct['condition']);
          var _sizeController =
              TextEditingController(text: selectedProduct['size']);
          var _styleController =
              TextEditingController(text: selectedProduct['style']);
          var _descriptionController =
              TextEditingController(text: selectedProduct['description']);

          var _newPrice = _priceController == ''
              ? selectedProduct['price'].toString()
              : _priceController;
          var _newBrand = _brandController == ''
              ? selectedProduct['brand']
              : _brandController;
          var _newCategory = _categoryController == ''
              ? selectedProduct['category']
              : _categoryController;
          var _newCondition = selectedProduct['condition'];
          var _newSize = selectedProduct['size'];
          var _newStyle = selectedProduct['style'];
          var _newDescription = selectedProduct['description'];

          return Mutation(
              options: MutationOptions(
                document: gql(updateProduct),
                update: (GraphQLDataProxy cache, QueryResult result) {
                  return cache;
                },
                onCompleted: (dynamic resultData) {
                  var value = resultData['updateProduct'];
                  if (value == true) {
                    refetch();
                    showFloatingModalBottomSheet(
                        context: context,
                        builder: (context) => EditSuccessModal());
                  } else {
                    showFloatingModalBottomSheet(
                        context: context,
                        builder: (context) => EditedFailedModal());
                  }
                  setState(() {
                    _image1 = null;
                    _image2 = null;
                    _image3 = null;
                    _image4 = null;
                    _image5 = null;
                    _image6 = null;
                    _priceController = '';
                    _brandController = '';
                    _conditionController.text = '';
                    _sizeController.text = '';
                    _styleController.text = '';
                    _descriptionController.text = '';
                  });
                },
              ),
              builder: (RunMutation runMutation, QueryResult result) {
                if (result.hasException) {
                  print(
                    result.exception.toString(),
                  );
                  return Container(
                      color: Colors.white,
                      child: Center(
                          child: Text(
                        result.exception.toString(),
                        style: TextStyle(color: Colors.black87, fontSize: 11),
                      )));
                }

                if (result.isLoading) {
                  return Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              HexColor("#711E97")),
                        ),
                      ));
                }

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Text(
                      'Edit Product',
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    centerTitle: true,
                    leading: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Colors.black87,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
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
                                              builder: (context) =>
                                                  ImageOptions(
                                                    onTapCamera: () {
                                                      getImageFromCamera1();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    onTapGallery: () {
                                                      getImageFromGallery1();
                                                      Navigator.of(context)
                                                          .pop();
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
                                              : selectedProduct['images']
                                                          .length >
                                                      0
                                                  ? Image.network(
                                                      selectedProduct['images']
                                                          [0],
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : PhotoFrame(text: '썸네일'),
                                        ),
                                      ),
                                      InkResponse(
                                        onTap: () {
                                          showFloatingModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  ImageOptions(
                                                    onTapCamera: () {
                                                      getImageFromCamera2();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    onTapGallery: () {
                                                      getImageFromGallery2();
                                                      Navigator.of(context)
                                                          .pop();
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
                                              : selectedProduct['images']
                                                          .length >
                                                      1
                                                  ? Image.network(
                                                      selectedProduct['images']
                                                          [1],
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : PhotoFrame(text: '앞면'),
                                        ),
                                      ),
                                      InkResponse(
                                        onTap: () {
                                          showFloatingModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  ImageOptions(
                                                    onTapCamera: () {
                                                      getImageFromCamera3();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    onTapGallery: () {
                                                      getImageFromGallery3();
                                                      Navigator.of(context)
                                                          .pop();
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
                                              : selectedProduct['images']
                                                          .length >
                                                      2
                                                  ? Image.network(
                                                      selectedProduct['images']
                                                          [2],
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : PhotoFrame(text: '뒤면'),
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
                                              builder: (context) =>
                                                  ImageOptions(
                                                    onTapCamera: () {
                                                      getImageFromCamera4();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    onTapGallery: () {
                                                      getImageFromGallery4();
                                                      Navigator.of(context)
                                                          .pop();
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
                                              : selectedProduct['images']
                                                          .length >
                                                      3
                                                  ? Image.network(
                                                      selectedProduct['images']
                                                          [3],
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : PhotoFrame(text: '라벨'),
                                        ),
                                      ),
                                      InkResponse(
                                        onTap: () {
                                          showFloatingModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  ImageOptions(
                                                    onTapCamera: () {
                                                      getImageFromCamera5();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    onTapGallery: () {
                                                      getImageFromGallery5();
                                                      Navigator.of(context)
                                                          .pop();
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
                                              : selectedProduct['images']
                                                          .length >
                                                      4
                                                  ? Image.network(
                                                      selectedProduct['images']
                                                          [4],
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : PhotoFrame(text: '디테일 1'),
                                        ),
                                      ),
                                      InkResponse(
                                        onTap: () {
                                          showFloatingModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  ImageOptions(
                                                    onTapCamera: () {
                                                      getImageFromCamera6();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    onTapGallery: () {
                                                      getImageFromGallery6();
                                                      Navigator.of(context)
                                                          .pop();
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
                                              : selectedProduct['images']
                                                          .length >
                                                      5
                                                  ? Image.network(
                                                      selectedProduct['images']
                                                          [5],
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : PhotoFrame(text: '디테일 2'),
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
                                        controller: TextEditingController(
                                            text: _priceController == ''
                                                ? selectedProduct['price']
                                                    .toString()
                                                : _priceController.toString()),
                                        onChanged: (String price) {
                                          _newPrice = price;

                                          _priceController = _newPrice;

                                          print(price);
                                          print(_newPrice);
                                        },
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "* Required";
                                          } else if (!validator
                                              .isNumeric(value)) {
                                            return "* enter numbers only";
                                          } else {
                                            _formKey.currentState.save();
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(top: 10),
                                          child: UploadInput(
                                            obscure: false,
                                            hint: "브랜드 입력",
                                            width: width * 0.65,
                                            controller: TextEditingController(
                                                text: _brandController == ''
                                                    ? selectedProduct['brand']
                                                    : _brandController),
                                            onChanged: (String brand) {
                                              _newBrand = brand;

                                              _brandController = _newBrand;

                                              print(_newBrand);
                                            },
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
                                                  _brandController = "브랜드 없음";
                                                });

                                                _newBrand = _brandController;
                                                print(_newBrand);
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
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: InkResponse(
                                        onTap: () {
                                          showFloatingModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                CategoriesModal(
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
                                                        itemCount:
                                                            catListAll.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          _dynamicView() {
                                                            if (index == 0) {
                                                              return showFloatingModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          CategoriesModal(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(
                                                                                  child: Text(
                                                                                    '상의',
                                                                                    style: TextStyle(
                                                                                      fontFamily: "Bold",
                                                                                      fontSize: 16,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(height: 15),
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
                                                                                                    _categoryController = '${catListAll[0] + '/' + catSub1[index]}';
                                                                                                  });

                                                                                                  _newCategory = _categoryController;
                                                                                                  print(_newCategory);

                                                                                                  var nav = Navigator.of(context);
                                                                                                  nav.pop();
                                                                                                  nav.pop();
                                                                                                },
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        })),
                                                                                SizedBox(height: 20),
                                                                              ],
                                                                            ),
                                                                          ));
                                                            } else if (index ==
                                                                1) {
                                                              return showFloatingModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          CategoriesModal(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(
                                                                                  child: Text(
                                                                                    '하의',
                                                                                    style: TextStyle(
                                                                                      fontFamily: "Bold",
                                                                                      fontSize: 16,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(height: 15),
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
                                                                                                    _categoryController = '${catListAll[1] + '/' + catSub2[index]}';
                                                                                                  });

                                                                                                  _newCategory = _categoryController;
                                                                                                  print(_newCategory);
                                                                                                  var nav = Navigator.of(context);
                                                                                                  nav.pop();
                                                                                                  nav.pop();
                                                                                                },
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        })),
                                                                                SizedBox(height: 20),
                                                                              ],
                                                                            ),
                                                                          ));
                                                            } else if (index ==
                                                                2) {
                                                              return showFloatingModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          CategoriesModal(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(
                                                                                  child: Text(
                                                                                    '아우터',
                                                                                    style: TextStyle(
                                                                                      fontFamily: "Bold",
                                                                                      fontSize: 16,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(height: 15),
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
                                                                                                    _categoryController = '${catListAll[2] + '/' + catSub3[index]}';
                                                                                                  });

                                                                                                  _newCategory = _categoryController;
                                                                                                  print(_newCategory);

                                                                                                  var nav = Navigator.of(context);
                                                                                                  nav.pop();
                                                                                                  nav.pop();
                                                                                                },
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        })),
                                                                                SizedBox(height: 20),
                                                                              ],
                                                                            ),
                                                                          ));
                                                            } else if (index ==
                                                                3) {
                                                              return showFloatingModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          CategoriesModal(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(
                                                                                  child: Text(
                                                                                    '원피스/세트',
                                                                                    style: TextStyle(
                                                                                      fontFamily: "Bold",
                                                                                      fontSize: 16,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(height: 15),
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
                                                                                                    _categoryController = '${catListAll[3] + '/' + catSub4[index]}';
                                                                                                  });

                                                                                                  _newCategory = _categoryController;
                                                                                                  print(_newCategory);

                                                                                                  var nav = Navigator.of(context);
                                                                                                  nav.pop();
                                                                                                  nav.pop();
                                                                                                },
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        })),
                                                                                SizedBox(height: 20),
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
                                                                        vertical:
                                                                            -4),
                                                                title: Text(
                                                                  '${catListAll[index]}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    _categoryController =
                                                                        '${catListAll[index]}';
                                                                  });

                                                                  _newCategory =
                                                                      _categoryController;

                                                                  print(
                                                                      _newCategory);

                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              );
                                                            } else {
                                                              return ListTile(
                                                                visualDensity:
                                                                    VisualDensity(
                                                                        vertical:
                                                                            -4),
                                                                title: Text(
                                                                  '${catListAll[index]}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
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
                                                                  color: Colors
                                                                      .black87,
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
                                          padding:
                                              EdgeInsets.only(top: 5, left: 15),
                                          width: width * 0.95,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey[400]),
                                          ),
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _categoryController == ''
                                                      ? selectedProduct[
                                                          'category']
                                                      : _categoryController,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black87),
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
                                        onChanged: (String condition) {
                                          _newCondition = condition;
                                          print(_newCondition);
                                        },
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
                                        onChanged: (String size) {
                                          _newSize = size;
                                          print(_newSize);
                                        },
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
                                        onChanged: (String style) {
                                          _newStyle = style;
                                          print(_newStyle);
                                        },
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
                                        onChanged: (String description) {
                                          _newDescription = description;
                                          print(_newDescription);
                                        },
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
                                final removedImagesIndexes =
                                    _getRemovedImageIndexes(selectedProduct);

                                runMutation({
                                  '_id': selectedProduct['_id'],
                                  'removedImagesIndexes': removedImagesIndexes,
                                  'newImages': imageList,
                                  'price': int.parse(_newPrice),
                                  'brand': _newBrand,
                                  'category': _newCategory,
                                  'condition': _newCondition,
                                  'size': _newSize,
                                  'style': _newStyle,
                                  'description': _newDescription,
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
                );
              });
        });
  }
}
