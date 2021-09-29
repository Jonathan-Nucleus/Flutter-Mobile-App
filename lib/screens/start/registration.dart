import 'package:client/graphql/mutations.dart';
import 'package:client/routes/routes.dart';
import 'package:client/widgets/large-button.dart';
import 'package:client/widgets/modals/failed2-modal.dart';
import 'package:client/widgets/modals/failed3-modal.dart';
import 'package:client/widgets/modals/login-modal.dart';
import 'package:client/widgets/modals/undismissable.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/input.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:validators/validators.dart' as validator;

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey2 = GlobalKey<FormState>();

  var _idController = TextEditingController();
  var _passwordController = TextEditingController();
  var _passwordController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;

    return Mutation(
        options: MutationOptions(
            document: gql(registerUser),
            update: (GraphQLDataProxy cache, QueryResult result) {
              return cache;
            },
            onCompleted: (dynamic resultData) {
              var user = resultData['registerUser'];
              if (user == true) {
                showUndissmisableModalBottomSheet(
                  context: context,
                  builder: (context) => LoginModal(),
                );
              } else if (user == false) {
                showUndissmisableModalBottomSheet(
                  context: context,
                  builder: (context) => DuplicateFailedModal(),
                );
              } else if (user == null) {
                showUndissmisableModalBottomSheet(
                  context: context,
                  builder: (context) => RegistrationFailedModal(),
                );
              }
            }),
        builder: (RunMutation runMutation, QueryResult result) {
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

          return Material(
            child: Container(
              color: Colors.white,
              child: Form(
                key: _formKey2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: height * 0.1),
                    ),
                    SizedBox(height: 75),
                    InputField(
                      obscure: false,
                      hint: "아이디",
                      width: width * 0.8,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "* Required";
                        } else if (value.contains(" ")) {
                          return 'enter value without space';
                        } else if (value.length < 1) {
                          return 'Enter longer ID';
                        } else if (value.length > 15) {
                          return 'Enter shorter ID';
                        } else {
                          _formKey2.currentState.save();
                          return null;
                        }
                      },
                      controller: _idController,
                    ),
                    SizedBox(height: 20),
                    InputField(
                      obscure: true,
                      hint: "비밀번호",
                      width: width * 0.8,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "* Required";
                        } else if (!validator.isAlphanumeric(value)) {
                          return 'Enter numbers & letters only';
                        } else if (value.contains(" ")) {
                          return 'enter value without space';
                        } else if (value.length < 6) {
                          return 'Enter longer Password';
                        } else if (value.length > 15) {
                          return 'Enter shorter Password';
                        } else {
                          _formKey2.currentState.save();
                          return null;
                        }
                      },
                      controller: _passwordController,
                    ),
                    SizedBox(height: 20),
                    InputField(
                      obscure: true,
                      hint: "비밀번호 확인",
                      width: width * 0.8,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "* Required";
                        } else if (value != _passwordController.text) {
                          return "* Passwords don't match";
                        } else {
                          _formKey2.currentState.save();
                          return null;
                        }
                      },
                      controller: _passwordController2,
                    ),
                    SizedBox(height: height * 0.1),
                    LargeButton(
                      onPressed: () {
                        if (_formKey2.currentState.validate()) {
                          _formKey2.currentState.save();
                          runMutation({
                            'usernameId': _idController.text,
                            'password': _passwordController.text
                          });
                        } else {
                          return Text('Error, Something went wrong!');
                        }
                      },
                      name: '다음',
                      width: width * 0.25,
                    ),
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
            ),
          );
        });
  }
}
