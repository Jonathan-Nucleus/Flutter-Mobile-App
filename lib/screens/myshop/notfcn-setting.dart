import 'package:client/graphql/mutations.dart';
import 'package:client/graphql/queries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class NotificationSettings extends StatefulWidget {
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    return Mutation(
        options: MutationOptions(
          document: gql(updateNoti),
          onCompleted: (dynamic resultData) {
            print(resultData);
          },
        ),
        builder: (RunMutation runMutation, QueryResult result) {
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

                var notification = result.data['fetchUser']['notification'];
                var directMessage = result.data['fetchUser']['directMessage'];
                var marketing = result.data['fetchUser']['marketing'];

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Text(
                      'Notification Settings',
                      style: TextStyle(color: Colors.black87, fontSize: 15),
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
                  body: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 0, top: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            dense: true,
                            title: Text(
                              '전체 알림',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontFamily: "Bold"),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '푸시 알림',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontFamily: "Medium"),
                                ),
                                new FlutterSwitch(
                                  value: notification,
                                  height: 25,
                                  width: 45,
                                  padding: 3,
                                  activeColor: Colors.purple[600],
                                  toggleSize: 20,
                                  onToggle: (bool) {
                                    runMutation(
                                      {'pushNoti': !notification},
                                    );
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            dense: true,
                            title: Text(
                              '푸시 알림',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontFamily: "Bold"),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '쪽지 알림',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontFamily: "Medium"),
                                ),
                                new FlutterSwitch(
                                  value: directMessage,
                                  height: 25,
                                  width: 45,
                                  padding: 3,
                                  activeColor: Colors.purple[600],
                                  toggleSize: 20,
                                  onToggle: (bool) {
                                    runMutation(
                                      {'directMessage': !directMessage},
                                    );
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            dense: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '마케팅 수신 동의',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontFamily: "Medium"),
                                ),
                                new FlutterSwitch(
                                  value: marketing,
                                  height: 25,
                                  width: 45,
                                  padding: 3,
                                  activeColor: Colors.purple[600],
                                  toggleSize: 20,
                                  onToggle: (bool) {
                                    runMutation(
                                      {'marketing': !marketing},
                                    );
                                    setState(() {});
                                  },
                                ),
                              ],
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
