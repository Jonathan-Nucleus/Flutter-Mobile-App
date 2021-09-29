import 'package:client/graphql/mutations.dart';
import 'package:client/widgets/large-button.dart';
import 'package:client/widgets/modals/code-modal.dart';
import 'package:client/widgets/modals/edit-number.dart';
import 'package:client/widgets/modals/failed-modal.dart';
import 'package:client/widgets/modals/floating-modal.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/input.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class EditNumber extends StatefulWidget {
  @override
  _EditNumberState createState() => _EditNumberState();
}

class _EditNumberState extends State<EditNumber> {
  final _authFormKey = GlobalKey<FormState>();
  final _verifyFormKey = GlobalKey<FormState>();

  var _nameController = TextEditingController();
  var _codeController = TextEditingController();
  var _numberController = TextEditingController();
  var _authCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;

    return Mutation(
        options: MutationOptions(
            document: gql(confirmEditedPhoneAuthCode),
            update: (GraphQLDataProxy cache, QueryResult result2) {
              return cache;
            },
            onCompleted: (dynamic resultData) {
              var value = resultData['confirmEditedPhoneAuthCode'];
              setState(() {
                _nameController.text = '';
                _codeController.text = '';
                _numberController.text = '';
                _authCodeController.text = '';
              });
              print(value);
              if (value == true) {
                showFloatingModalBottomSheet(
                  context: context,
                  builder: (context) => EditedModal(),
                );
              } else if (value != true) {
                showFloatingModalBottomSheet(
                  context: context,
                  builder: (context) => FailedModal(),
                );
                return;
              }
            }),
        builder: (RunMutation runMutation2, QueryResult result2) {
          if (result2.hasException) {
            return Container(
                color: Colors.white,
                child: Center(
                    child: Text(
                  result2.exception.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.black54),
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
                  document: gql(getPhoneAuthCode),
                  update: (GraphQLDataProxy cache, QueryResult result) {},
                  onCompleted: (dynamic resultData) {
                    print(resultData);
                    showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => CodeModal(),
                    );
                  }),
              builder: (RunMutation runMutation, QueryResult result) {
                if (result.hasException) {
                  return Container(
                    child: Container(
                      color: Colors.white,
                      child: Center(
                          child: Text(
                        result.exception.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      )),
                    ),
                  );
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
                      'Edit number',
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
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
                  body: Material(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.1),
                          Form(
                              key: _authFormKey,
                              child: Column(
                                children: [
                                  InputField(
                                    obscure: false,
                                    hint: "이름",
                                    width: width * 0.8,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "* Required";
                                      } else {
                                        _authFormKey.currentState.save();
                                        return null;
                                      }
                                    },
                                    controller: _nameController,
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InputField(
                                        obscure: false,
                                        hint: "82",
                                        width: width * 0.23,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "* Required";
                                          } else {
                                            _authFormKey.currentState.save();
                                            return null;
                                          }
                                        },
                                        controller: _codeController,
                                      ),
                                      SizedBox(width: width * 0.02),
                                      InputField(
                                        obscure: false,
                                        hint: "전화번호",
                                        width: width * 0.55,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "* Required";
                                          } else {
                                            _authFormKey.currentState.save();
                                            return null;
                                          }
                                        },
                                        controller: _numberController,
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(height: height * 0.02),
                          Form(
                              key: _verifyFormKey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputField(
                                    obscure: false,
                                    hint: "인증번호",
                                    width: width * 0.39,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "* Required";
                                      } else {
                                        _verifyFormKey.currentState.save();
                                        return null;
                                      }
                                    },
                                    controller: _authCodeController,
                                  ),
                                  SizedBox(width: width * 0.02),
                                  LargeButton(
                                      onPressed: () {
                                        if (_authFormKey.currentState
                                            .validate()) {
                                          _authFormKey.currentState.save();
                                          runMutation({
                                            'name': _nameController.text,
                                            'countryCode': _codeController.text,
                                            'phoneNumber':
                                                _numberController.text,
                                          });
                                        } else {
                                          return Text(
                                              'Error, Something went wrong!');
                                        }
                                      },
                                      name: '인증번호 받기',
                                      font: 13,
                                      width: width * 0.39),
                                ],
                              )),
                          SizedBox(height: height * 0.04),
                          LargeButton(
                              onPressed: () {
                                if (_verifyFormKey.currentState.validate()) {
                                  _verifyFormKey.currentState.save();
                                  runMutation2({
                                    'countryCode': _codeController.text,
                                    'phoneNumber': _numberController.text,
                                    'code': _authCodeController.text,
                                  });
                                } else {
                                  return Text('Error, Something went wrong!');
                                }
                              },
                              name: '인증완료',
                              font: 15,
                              width: width * 0.8),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
