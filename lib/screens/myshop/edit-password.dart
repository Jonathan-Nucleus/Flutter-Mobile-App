import 'package:client/graphql/mutations.dart';
import 'package:client/graphql/queries.dart';
import 'package:client/widgets/large-button.dart';
import 'package:client/widgets/modals/edit-password.dart';
import 'package:client/widgets/modals/floating-modal.dart';
import 'package:client/widgets/modals/pass-update-fail.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/input.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final _passFormKey = GlobalKey<FormState>();

  var _currentController = TextEditingController();
  var _newController = TextEditingController();
  var _new2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;

    return Mutation(
        options: MutationOptions(
          document: gql(updatePassword),
          update: (GraphQLDataProxy cache, QueryResult result) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
            var value = resultData['updatePassword'];
            setState(() {
              _currentController.text = '';
              _newController.text = '';
              _new2Controller.text = '';
            });
            print(value);
            if (value == true) {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => PasswordModal(),
              );
            } else if (value != true) {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => PasswordFailedModal(),
              );
              return;
            }
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
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
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
                      child: Center(child: Text(result.exception.toString())));
                }

                if (result.isLoading) {
                  return Container(
                      child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
                    ),
                  ));
                }

                if (result.data == null) {
                  return Material(
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Text('null-value'),
                      ),
                    ),
                  );
                }

                var password = result.data['fetchUser']['password'];

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Text(
                      'Edit password',
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
                      child: Form(
                        key: _passFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: height * 0.025),
                            ),
                            SizedBox(height: 75),
                            InputField(
                              obscure: true,
                              hint: "현재 비밀번호",
                              width: width * 0.8,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "* Required";
                                } else if (value != password.toString()) {
                                  return "* Incorrect password";
                                } else {
                                  _passFormKey.currentState.save();
                                  return null;
                                }
                              },
                              controller: _currentController,
                            ),
                            SizedBox(height: 20),
                            InputField(
                              obscure: true,
                              hint: "새로운 비밀번호",
                              width: width * 0.8,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "* Required";
                                } else {
                                  _passFormKey.currentState.save();
                                  return null;
                                }
                              },
                              controller: _newController,
                            ),
                            SizedBox(height: 20),
                            InputField(
                              obscure: true,
                              hint: "새로운 비밀번호 재입력",
                              width: width * 0.8,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "* Required";
                                } else if (value != _newController.text) {
                                  return "* Passwords don't match";
                                } else {
                                  _passFormKey.currentState.save();
                                  return null;
                                }
                              },
                              controller: _new2Controller,
                            ),
                            SizedBox(height: height * 0.1),
                            LargeButton(
                                onPressed: () {
                                  if (_passFormKey.currentState.validate()) {
                                    _passFormKey.currentState.save();
                                    runMutation({
                                      'newPass': _newController.text,
                                    });
                                  } else {
                                    return Text('Error, Something went wrong!');
                                  }
                                },
                                name: '완료',
                                width: width * 0.8),
                            SizedBox(height: height * 0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
