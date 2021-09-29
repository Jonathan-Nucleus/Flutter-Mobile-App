import 'package:client/graphql/queries.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/home/product-details.dart';
import 'package:client/screens/home/seller-shop.dart';
import 'package:client/widgets/feed-product.dart';
import 'package:client/widgets/followed-sellers.dart';
import 'package:client/widgets/section-title.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(getMostRecentFollowing),
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

          return Query(
              options: QueryOptions(
                document: gql(getFeedProducts),
              ),
              builder: (QueryResult result2,
                  {VoidCallback refetch, FetchMore fetchMore}) {
                if (result2.hasException) {
                  return Container(
                      child: Center(child: Text(result2.exception.toString())));
                }

                if (result2.isLoading) {
                  return Container(
                      child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
                    ),
                  ));
                }

                var recentFollowing = result.data['getMostRecentFollowing'];
                var feedProducts = result2.data['getFeedProducts'];

                return Query(
                    options: QueryOptions(
                      document: gql(fetchUser),
                    ),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result.hasException) {
                        return Container(
                            child: Center(
                                child: Text(result.exception.toString())));
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

                      final userDetail = result.data['fetchUser'];

                      return WillPopScope(
                        onWillPop: () async => false,
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: [
                              SectionTitle(title: '팔로우한 셀러'),
                              Container(
                                height: 120,
                                padding: EdgeInsets.only(top: 10),
                                child: recentFollowing.length == 0
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Center(
                                            child: Text(
                                          'follow users to see feed data',
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        )),
                                      )
                                    : ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: recentFollowing
                                            .map<Widget>((following) {
                                          return FollowedSellers(
                                            image:
                                                following['profilePhoto'] ?? '',
                                            id: following['usernameId'] ?? '',
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, SellershopRoute,
                                                  arguments:
                                                      SellerShopRouteArguments(
                                                          following['_id']));
                                            },
                                          );
                                        }).toList()),
                              ),
                              SizedBox(height: 10),
                              Divider(
                                height: 1,
                              ),
                              feedProducts.length == 0
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Center(
                                          child: Text(
                                        'follow users to see feed data',
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      )),
                                    )
                                  : ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) {
                                        return Divider();
                                      },
                                      itemCount: feedProducts.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final data = feedProducts[index];
                                        final productIsInCart =
                                            userDetail['myCart'].any(
                                                (product) =>
                                                    product['_id'] ==
                                                    data['_id']);
                                        return FeedProduct(
                                          userId: data['user']['_id'],
                                          profile: data['user']['profilePhoto'],
                                          username: data['user']['usernameId'],
                                          images: data['images'],
                                          description: data['description'],
                                          productId: data['_id'],
                                          bookmark: productIsInCart
                                              ? Icon(Icons.bookmark,
                                                  color: Colors.black87,
                                                  size: 35)
                                              : Icon(
                                                  Icons
                                                      .bookmark_border_outlined,
                                                  color: Colors.black87,
                                                  size: 35),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, ProductdetailsRoute,
                                                arguments:
                                                    ProductDetailArguments(
                                                        data['_id']));
                                          },
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      );
                    });
              });
        });
  }
}
