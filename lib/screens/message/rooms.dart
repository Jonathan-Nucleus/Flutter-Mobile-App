import 'package:client/graphql/queries.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/message/chat.dart';
import 'package:client/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class Rooms extends StatefulWidget {
  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(getRooms),
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

          if (result.data == null) {
            return Container(child: Center(child: Text('null-value')));
          }

          var rooms = result.data['getRooms'];

          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  'Chat Rooms',
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (BuildContext context, int index) {
                  var room = rooms[index];
                  var timestamp = room['last_message'] == null
                      ? ''
                      : DateFormat('yyyy-MM-dd hh:mm').format(
                          new DateTime.fromMillisecondsSinceEpoch(
                              int.parse(room['last_message']['createdAt'])));
                  return MessageDetails(
                      onPressed: () {
                        Navigator.pushNamed(context, ChatRoute,
                                arguments: ChatRouteArguments(room['_id']))
                            .then((value) => setState(() {
                                  refetch();
                                  print(value);
                                }));
                      },
                      roomId: room['_id'],
                      seller: room['other_user']['usernameId'],
                      stamp: timestamp,
                      text: room['last_message'] == null
                          ? ''
                          : room['last_message']['text'],
                      unread: room['number_of_unread_messages'].toString());
                },
              ),
            ),
          );
        });
  }
}
