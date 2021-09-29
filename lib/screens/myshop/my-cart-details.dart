import 'package:client/graphql/queries.dart';
import 'package:client/graphql/mutations.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/message/chat.dart';
import 'package:client/widgets/my-cart-details-boottom.dart';
import 'package:client/widgets/my-cart-details-top.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class MyCartDetailArguments {
  final String productId;

  MyCartDetailArguments(this.productId);
}

class MyCartDetails extends StatefulWidget {
  @override
  _MyCartDetailsState createState() => _MyCartDetailsState();
}

class _MyCartDetailsState extends State<MyCartDetails> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    final MyCartDetailArguments routeArgs =
        ModalRoute.of(context).settings.arguments;

    return Mutation(
        options: MutationOptions(
          document: gql(createRoom),
          update: (GraphQLDataProxy cache, QueryResult result) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
            var room = resultData['createRoom'];
            if (room != null) {
              return Navigator.pushNamed(context, ChatRoute,
                  arguments: ChatRouteArguments(room['_id']));
            } else {
              return Container(
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    'Chat room creation failed!',
                    style: TextStyle(color: Colors.black87, fontSize: 11),
                  )));
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
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              HexColor("#711E97")),
                        ),
                      ));
                }

                var cartProducts = result.data['fetchUser']['myCart'];
                var followingList = result.data['fetchUser']['following'];

                var selectedProduct = cartProducts.firstWhere(
                    (product) => product['_id'] == routeArgs.productId,
                    orElse: () => null);

                var followingUser = followingList.firstWhere(
                    (following) =>
                        following['_id'] == selectedProduct['user']['_id'],
                    orElse: () => null);

                var formattedPrice = NumberFormat.simpleCurrency(
                  locale: 'ko',
                  name: 'KRW',
                ).format(selectedProduct['price']);

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
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
                          MyCartDetailsTop(
                              profile:
                                  selectedProduct['user']['profilePhoto'] ?? '',
                              username:
                                  selectedProduct['user']['usernameId'] ?? '',
                              follow:
                                  followingUser == null ? 'Follow' : 'Unfollow',
                              images: selectedProduct['images'],
                              bookmark: true,
                              description:
                                  selectedProduct['description'] ?? ''),
                          MyCartDetailsBottom(
                            price: formattedPrice,
                            brand: selectedProduct['brand'] ?? '',
                            category: selectedProduct['category'] ?? '',
                            style: selectedProduct['style'] ?? '',
                            condition: selectedProduct['condition'] ?? '',
                            size: selectedProduct['size'] ?? '',
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: Material(
                    elevation: 4,
                    child: Container(
                      height: height * 0.11,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              formattedPrice,
                              style: TextStyle(
                                  fontFamily: 'Bold',
                                  fontSize: 18,
                                  color: Colors.black87),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: width * 0.6,
                            child: Material(
                              child: TextButton(
                                  child: Text(
                                    '쪽지하기',
                                    style: TextStyle(
                                        fontFamily: 'Bold',
                                        fontSize: 13,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    runMutation({
                                      'otherUserId': selectedProduct['user']
                                          ['_id']
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: HexColor("#711E97"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  )),
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
