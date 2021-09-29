import 'package:client/graphql/mutations.dart';
import 'package:client/graphql/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Mutation(
        options: MutationOptions(
          document: gql(removeNotification),
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

                var notification = result.data['fetchUser']['notifications'];

                notif() {
                  if (notification.length == 0) {
                    return Center(
                      child: Text(
                        'No notifications',
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    );
                  } else if (notification.length > 0) {
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: notification.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = notification[index]['message'];
                        return Dismissible(
                          child: ListTile(
                            title: Text(
                              data.toString(),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14),
                            ),
                          ),
                          background: Container(
                            color: HexColor("#711E97"),
                          ),
                          key: UniqueKey(),
                          onDismissed: (DismissDirection direction) {
                            runMutation(
                              {
                                '_id': notification[index]['_id'],
                              },
                            );
                            setState(() {
                             
                            });
                          },
                        );
                      },
                    );
                  }
                }

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Text(
                      'Notifications',
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
                  body: notif(),
                );
              });
        });
  }
}
