import 'package:client/graphql/graphql.dart';
import 'package:client/graphql/mutations.dart';
import 'package:client/routes/routes.dart';
import 'package:client/widgets/large-button.dart';
import 'package:client/widgets/modals/code-modal.dart';
import 'package:client/widgets/modals/failed-modal.dart';
import 'package:client/widgets/modals/floating-modal.dart';
import 'package:client/widgets/modals/proceed-modal.dart';
import 'package:client/widgets/modals/undismissable.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/input.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:validators/validators.dart' as validator;

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
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
            document: gql(confirmPhoneAuthCode),
            update: (GraphQLDataProxy cache, QueryResult result2) {
              return cache;
            },
            onCompleted: (dynamic resultData) {
              String value = resultData['confirmPhoneAuthCode']['accessToken'];
              GraphQLConfiguration.setToken(value);
              if (value != null) {
                showUndissmisableModalBottomSheet(
                  context: context,
                  builder: (context) => ProceedModal(),
                );
              } else if (value == null) {
                showUndissmisableModalBottomSheet(
                  context: context,
                  builder: (context) => FailedModal(),
                );
                return;
              }
            }),
        builder: (RunMutation runMutation2, QueryResult result2) {
          if (result2.hasException) {
            return Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      child: Text(
                        'Verification Failed!',
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          child: Text(
                            'Incorrect Details! Try Again',
                            style: TextStyle(
                                fontFamily: "Medium",
                                fontSize: 12,
                                color: HexColor("#dddddd")),
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Material(
                            child: Text(
                              'Verification',
                              style: TextStyle(
                                  fontFamily: "Bold",
                                  fontSize: 12,
                                  color: HexColor("#262626")),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
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
                    if (resultData != null) {
                      showFloatingModalBottomSheet(
                        context: context,
                        builder: (context) => CodeModal(),
                      );
                    }
                  }),
              builder: (RunMutation runMutation, QueryResult result) {
                if (result.hasException) {
                  return Center(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            child: Text(
                              'Verification Failed!',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                child: Text(
                                  'Incorrect Details! Try Again',
                                  style: TextStyle(
                                      fontFamily: "Medium",
                                      fontSize: 12,
                                      color: HexColor("#dddddd")),
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Material(
                                  child: Text(
                                    'Verification',
                                    style: TextStyle(
                                        fontFamily: "Bold",
                                        fontSize: 12,
                                        color: HexColor("#262626")),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

                return Material(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: height * 0.15),
                          child: Image(
                            image:
                                AssetImage("lib/assets/images/logo_main.png"),
                            height: height * 0.1,
                            width: width * 0.25,
                          ),
                        ),
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
                                      } else if (!validator.isNumeric(value)) {
                                        return 'Please enter number only';
                                      } else if (value.length > 3) {
                                        return 'Not valid code';
                                      } else if (value.contains(" ")) {
                                        return 'enter value without space';
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
                                      } else if (!validator.isNumeric(value)) {
                                        return 'Please enter number only';
                                      } else if (value.length > 14) {
                                        return 'Not valid number';
                                      } else if (value.length < 8) {
                                        return 'Not valid number';
                                      } else if (value.contains(" ")) {
                                        return 'enter value without space';
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
                          ),
                        ),
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
                                  } else if (!validator.isNumeric(value)) {
                                    return 'Enter number only';
                                  } else if (value.length > 6 ||
                                      value.length < 6) {
                                    return 'Not valid code length';
                                  } else if (value.contains(" ")) {
                                    return 'no space';
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
                                    if (_authFormKey.currentState.validate()) {
                                      _authFormKey.currentState.save();
                                      runMutation({
                                        'name': _nameController.text,
                                        'countryCode': _codeController.text,
                                        'phoneNumber': _numberController.text,
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
                          ),
                        ),
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
                            name: '휴대폰 번호로 가입하기',
                            font: 15,
                            width: width * 0.8),
                        SizedBox(height: height * 0.1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '이미 계정이 있으신가요?',
                              style: TextStyle(
                                  fontFamily: "Medium",
                                  fontSize: 12,
                                  color: HexColor("#dddddd")),
                            ),
                            SizedBox(width: width * 0.02),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, LoginRoute);
                              },
                              child: Text(
                                '로그인하기',
                                style: TextStyle(
                                    fontFamily: "Bold",
                                    fontSize: 12,
                                    color: HexColor("#262626")),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
