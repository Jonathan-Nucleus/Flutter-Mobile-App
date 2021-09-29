import 'package:client/graphql/queries.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/home/seller-shop.dart';
import 'package:client/widgets/followers.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class Followers extends StatefulWidget {
  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(fetchUser),
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        /* data */
        value() {
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

          var followers = result.data['fetchUser']['followers'];

          if (followers == null) {
            return Container(child: Center(child: Text('null value')));
          }

          if (followers != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: followers.length,
                itemBuilder: (context, index) {
                  final data = followers[index];
                  return Column(
                    children: [
                      FollowersAvatar(
                        image: data['profilePhoto'] ?? '',
                        id: data['usernameId'],
                        onPressed: () {
                          Navigator.pushNamed(context, SellershopRoute,
                              arguments: SellerShopRouteArguments(data['_id']));
                        },
                      ),
                    ],
                  );
                });
          }
        }
        /* data */

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Followers',
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
          body: Container(child: value()),
        );
      },
    );
  }
}
