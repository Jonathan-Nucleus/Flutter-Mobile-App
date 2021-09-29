import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:client/graphql/mutations.dart';
import 'package:client/graphql/queries.dart';
import 'package:client/widgets/change-id.dart';
import 'package:client/widgets/change-intro.dart';
import 'package:client/widgets/change-photo.dart';
import 'package:client/widgets/modals/floating-modal.dart';
import 'package:client/widgets/modals/image-options.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _idController = TextEditingController();
  var _introController = TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
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

    return Mutation(
        options: MutationOptions(
            document: gql(updateUserPhoto),
            update: (GraphQLDataProxy cache, QueryResult result2) {
              return cache;
            },
            onCompleted: (dynamic resultData2) {
              print(resultData2);
            },
            onError: (OperationException error) {
              print(error);
            }),
        builder: (RunMutation runMutation2, QueryResult result2) {
          if (result2.hasException) {
            print(result2.exception.toString());
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

          if (result2.isLoading) {
            return Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
                  ),
                ));
          }
          return Mutation(
              options: MutationOptions(
                document: gql(editProfile),
                update: (GraphQLDataProxy cache, QueryResult result) {
                  return cache;
                },
                onCompleted: (dynamic resultData) {
                  print(resultData);
                },
              ),
              builder: (RunMutation runMutation, QueryResult result) {
                if (result.hasException) {
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
                return Query(
                    options: QueryOptions(
                      document: gql(fetchUser),
                    ),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result.hasException) {
                        return Container(
                            child: Center(
                                child: Text(result.exception.toString())));
                      }

                      if (result.isLoading) {
                        return Container(
                            child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                HexColor("#711E97")),
                          ),
                        ));
                      }

                      var photo = result.data['fetchUser']['profilePhoto'];
                      var username = result.data['fetchUser']['usernameId'];
                      var intro = result.data['fetchUser']['introduction'];

                      return Scaffold(
                        resizeToAvoidBottomInset: false,
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          title: Text(
                            'EditProfile',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 15),
                          ),
                          centerTitle: true,
                          leading: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            color: Colors.black87,
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          automaticallyImplyLeading: false,
                        ),
                        body: Column(
                          children: [
                            ChangePhoto(
                              image: _image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                        _image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        photo.toString(),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                              onPressed: () {
                                showFloatingModalBottomSheet(
                                    context: context,
                                    builder: (context) => ImageOptions(
                                          onTapCamera: () {
                                            getImageFromCamera();
                                            Navigator.of(context).pop();
                                          },
                                          onTapGallery: () {
                                            getImageFromGallery();
                                            Navigator.of(context).pop();
                                          },
                                        ));
                              },
                            ),
                            ChangeID(
                              hint: username.toString(),
                              controller: _idController,
                            ),
                            ChangeIntro(
                              intro: intro.toString(),
                              controller: _introController,
                            ),
                          ],
                        ),
                        bottomNavigationBar: InkWell(
                          onTap: () {
                            print('works');
                            val() {
                              if (_idController.text == '') {
                                return username.toString();
                              } else if (_idController.text != '') {
                                return _idController.text;
                              }
                            }

                            va2() {
                              if (_introController.text == '') {
                                return intro.toString();
                              } else if (_introController.text != '') {
                                return _introController.text;
                              }
                            }

                            runMutation({
                              'usernameId': val(),
                              'introduction': va2(),
                            });
                            setState(() {
                              _idController.text = '';
                              _introController.text = '';
                            });
                            print(_image);
                            var byteData = _image.readAsBytesSync();

                            var imageValue = MultipartFile.fromBytes(
                              'photo',
                              byteData,
                              filename: '${randomString(20)}.jpg',
                              contentType: MediaType("image", "jpg"),
                            );
                            runMutation2({'profilePhoto': imageValue});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            color: HexColor("#711E97"),
                            child: Center(
                                child: Text('확인',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17))),
                          ),
                        ),
                      );
                    });
              });
        });
  }
}
