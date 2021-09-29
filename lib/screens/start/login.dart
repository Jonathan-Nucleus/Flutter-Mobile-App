import 'package:client/graphql/mutations.dart';
import 'package:client/routes/routes.dart';
import 'package:client/widgets/large-button.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/input.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:client/graphql/graphql.dart';
import 'package:validators/validators.dart' as validator;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var _idController = TextEditingController();
  var _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;

    return Mutation(
        options: MutationOptions(
            document: gql(loginUser),
            update: (GraphQLDataProxy cache, QueryResult result) {
              return cache;
            },
            onCompleted: (dynamic resultData) {
              print(resultData);
              String token = resultData['loginUser']['accessToken'];

              if (token == null) {
                return;
              }
              GraphQLConfiguration.setToken(token);
              Navigator.pushNamed(context, AppRoute);
            }),
        builder: (RunMutation runMutation, QueryResult result) {
          if (result.hasException) {
            print(result.hasException.toString());
            return Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      child: Text(
                        'Login Failed!',
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          child: Text(
                            'Incorrect Login Details! Try Again',
                            style: TextStyle(
                                fontFamily: "Medium",
                                fontSize: 12,
                                color: HexColor("#dddddd")),
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginRoute);
                          },
                          child: Material(
                            child: Text(
                              '로그인하기',
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
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
                  ),
                ));
          }

          return Container(
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: height * 0.15),
                    child: Image(
                      image: AssetImage("lib/assets/images/logo_main.png"),
                      height: height * 0.1,
                      width: width * 0.25,
                    ),
                  ),
                  SizedBox(height: height * 0.1),
                  Container(
                    child: InputField(
                      obscure: false,
                      hint: "아이디",
                      width: width * 0.8,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "* Required";
                        } else if (value.contains(" ")) {
                          return 'enter value without space';
                        } else {
                          _formKey.currentState.save();
                          return null;
                        }
                      },
                      controller: _idController,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  InputField(
                    obscure: true,
                    hint: "비밀번호",
                    width: width * 0.8,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "* Required";
                      } else if (!validator.isAlphanumeric(value)) {
                        return 'Enter numbers & letters only';
                      } else {
                        _formKey.currentState.save();
                        return null;
                      }
                    },
                    controller: _passwordController,
                  ),
                  SizedBox(height: height * 0.04),
                  LargeButton(
                      onPressed: () {
                        print(_idController.text);
                        print(_passwordController.text);
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          runMutation({
                            'usernameId': _idController.text,
                            'password': _passwordController.text,
                          });
                        } else {
                          return AlertDialog(
                            content: Text('Error, Something went wrong!'),
                          );
                        }
                      },
                      name: '로그인',
                      width: width * 0.8),
                  SizedBox(height: height * 0.02),
                  LargeButton(
                      onPressed: () {
                        Navigator.pushNamed(context, VerificationRoute);
                      },
                      name: '휴대폰 번호로 가입하기',
                      width: width * 0.8),
                ],
              ),
            ),
          );
        });
  }
}
