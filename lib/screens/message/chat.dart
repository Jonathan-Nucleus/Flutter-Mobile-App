import 'package:client/graphql/mutations.dart';
import 'package:client/graphql/queries.dart';
import 'package:client/widgets/send-input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatRouteArguments {
  final String roomId;

  ChatRouteArguments(this.roomId);
}

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _formKey = GlobalKey<FormState>();
  var _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ChatRouteArguments routeArgs =
        ModalRoute.of(context).settings.arguments;
    return Mutation(
        options: MutationOptions(
          document: gql(sendMessage),
          update: (GraphQLDataProxy cache, QueryResult result) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
            setState(() {
              _messageController.text = '';
            });
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
              options: QueryOptions(document: gql(fetchUser)),
              builder: (QueryResult result,
                  {VoidCallback refetch, FetchMore fetchMore}) {
                if (result.hasException) {
                  return Container(
                      color: Colors.white,
                      child: Center(
                          child: Text(
                        result.exception.toString(),
                        style: TextStyle(color: Colors.black87, fontSize: 12),
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

                var username = result.data['fetchUser']['usernameId'];

                if (result.data == null) {
                  return Container(child: Center(child: Text('null-value')));
                }

                Size screenSize = MediaQuery.of(context).size;
                var width = screenSize.width;
                var height = screenSize.width;

                return Query(
                    options: QueryOptions(
                        document: gql(getRoom),
                        variables: {'_id': routeArgs.roomId}),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result.hasException) {
                        return Container(
                            color: Colors.white,
                            child: Center(
                                child: Text(
                              result.exception.toString(),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 12),
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

                      if (result.data == null) {
                        return Container(
                            child: Center(child: Text('null-value')));
                      }

                      var room = result.data['getRoom'];

                      return Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          title: Text(
                            room['other_user']['usernameId'],
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
                              Navigator.pop(context, true);
                            },
                          ),
                          automaticallyImplyLeading: false,
                        ),
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: room['messages'].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var message = room['messages'][index];

                                      if (message['receiver']['usernameId'] ==
                                          username) {
                                        return ChatBubble(
                                          clipper: ChatBubbleClipper1(
                                              type: BubbleType.receiverBubble),
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          backGroundColor: Colors.purple[100],
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                            ),
                                            child: Text(
                                              message['text'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return ChatBubble(
                                          clipper: ChatBubbleClipper1(
                                              type: BubbleType.sendBubble),
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.only(top: 10, bottom: 10),
                                          backGroundColor: Colors.grey[300],
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                            ),
                                            child: Text(
                                              message['text'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: width * 0.18,
                              color: Colors.grey[300],
                              child: Form(
                                key: _formKey,
                                child: SendInput(
                                  textController: _messageController,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "* Required";
                                    } else {
                                      _formKey.currentState.save();
                                      return null;
                                    }
                                  },
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      runMutation({
                                        'receiverId': room['other_user']['_id'],
                                        'text': _messageController.text
                                      });
                                    } else {
                                      return Text(
                                          'Error, Something went wrong!');
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              });
        });
  }
}
