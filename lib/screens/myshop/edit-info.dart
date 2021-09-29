import 'package:client/graphql/queries.dart';
import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class EditInfo extends StatefulWidget {
  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  @override
  Widget build(BuildContext context) {
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
                valueColor: AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
              ),
            ));
          }

          var username = result.data['fetchUser']['usernameId'];
          var phone = result.data['fetchUser']['phoneNumber'];

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'EditInfo',
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
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      dense: true,
                      title: Row(
                        children: [
                          Text(
                            '이름',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontFamily: "Medium"),
                          ),
                          SizedBox(width: 90),
                          Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              username.toString(),
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontFamily: "Medium"),
                            ),
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
                            '연락처',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontFamily: "Medium"),
                          ),
                          Text(
                            phone.toString(),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontFamily: "Medium"),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, EditnumberRoute);
                              },
                              child: Text('변경'),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey[200]))
                        ],
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '비밀번호',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontFamily: "Medium"),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, EditpasswordRoute);
                              },
                              child: Text('변경'),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey[200]))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
