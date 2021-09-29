import 'dart:ui';
import 'package:client/graphql/queries.dart';
import 'package:client/graphql/mutations.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/home/product-details.dart';
import 'package:client/screens/message/chat.dart';
import 'package:client/widgets/user-avatar.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SellerShopRouteArguments {
  final String userId;

  SellerShopRouteArguments(this.userId);
}

class SellerShop extends StatefulWidget {
  @override
  _SellerShopState createState() => _SellerShopState();
}

class _SellerShopState extends State<SellerShop> {
  @override
  Widget build(BuildContext context) {
    final SellerShopRouteArguments routeArgs =
        ModalRoute.of(context).settings.arguments;

    return Mutation(
        options: MutationOptions(
          document: gql(follow),
          update: (GraphQLDataProxy cache, QueryResult resultFollow) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
            setState(() {});
          },
        ),
        builder: (RunMutation runMutationFollow, QueryResult resultFollow) {
          if (resultFollow.hasException) {
            return Container(
                color: Colors.white,
                child: Center(
                    child: Text(
                  resultFollow.exception.toString(),
                  style: TextStyle(color: Colors.black87, fontSize: 11),
                )));
          }

          if (resultFollow.isLoading) {
            return Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
                  ),
                ));
          }

          return Mutation(
              options: MutationOptions(
                document: gql(unfollow),
                update: (GraphQLDataProxy cache, QueryResult resultUnfollow) {
                  return cache;
                },
                onCompleted: (dynamic resultData) {
                  setState(() {});
                },
              ),
              builder: (RunMutation runMutationUnfollow,
                  QueryResult resultUnfollow) {
                if (resultUnfollow.hasException) {
                  return Container(
                      color: Colors.white,
                      child: Center(
                          child: Text(
                        resultUnfollow.exception.toString(),
                        style: TextStyle(color: Colors.black87, fontSize: 11),
                      )));
                }

                if (resultUnfollow.isLoading) {
                  return Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              HexColor("#711E97")),
                        ),
                      ));
                }

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
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 11),
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
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 11),
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

                      return Query(
                          options: QueryOptions(
                              document: gql(fetchUserById),
                              variables: {'_id': routeArgs.userId}),
                          builder: (QueryResult result,
                              {VoidCallback refetch, FetchMore fetchMore}) {
                            if (result.hasException) {
                              return Container(
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    result.exception.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
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
                              return Material(
                                child: Container(
                                  color: Colors.white,
                                  child: Center(
                                    child: Text('null-value'),
                                  ),
                                ),
                              );
                            }

                            return Query(
                                options: QueryOptions(
                                  document: gql(fetchUser),
                                ),
                                builder: (QueryResult result3,
                                    {VoidCallback refetch,
                                    FetchMore fetchMore}) {
                                  if (result3.hasException) {
                                    return Container(
                                        child: Center(
                                            child: Text(
                                                result.exception.toString())));
                                  }

                                  if (result3.isLoading) {
                                    return Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    HexColor("#711E97")),
                                          ),
                                        ));
                                  }

                                  final selectedUserDetail =
                                      result.data['fetchUserById'];

                                  final currentUser = result3.data['fetchUser'];

                                  final followingSelectedUser =
                                      selectedUserDetail['followers'].any(
                                          (follower) =>
                                              follower['_id'] ==
                                              currentUser['_id']);

                                  return Scaffold(
                                    appBar: AppBar(
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      title: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 0, right: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.arrow_back,
                                                      color: Colors.black87,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        currentUser['_id'] !=
                                                            selectedUserDetail[
                                                                '_id'],
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        runMutation({
                                                          'otherUserId':
                                                              selectedUserDetail[
                                                                  '_id']
                                                        });
                                                      },
                                                      child: Icon(
                                                        MdiIcons.telegram,
                                                        color: Colors.black87,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  top: 5, left: 20),
                                              color: Colors.white,
                                              child: UserAvatar(
                                                  image: selectedUserDetail[
                                                          'profilePhoto'] ??
                                                      '',
                                                  id: selectedUserDetail[
                                                      'usernameId']),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 60, right: 70, top: 5),
                                              color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          selectedUserDetail[
                                                                  'followers']
                                                              .length
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Bold',
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                        Text(
                                                          'Followers',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Bold',
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          selectedUserDetail[
                                                                  'following']
                                                              .length
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Bold',
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                        Text(
                                                          'Following',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Bold',
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        selectedUserDetail[
                                                                'myProducts']
                                                            .where((product) =>
                                                                product[
                                                                    'soldOut'] ==
                                                                true)
                                                            .length
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily: 'Bold',
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black87),
                                                      ),
                                                      Text(
                                                        'Sold',
                                                        style: TextStyle(
                                                            fontFamily: 'Bold',
                                                            fontSize: 13,
                                                            color:
                                                                Colors.black87),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20, top: 10,),
                                              color: Colors.white,
                                              child: Text(
                                                selectedUserDetail[
                                                    'introduction'],
                                                style: TextStyle(
                                                    fontFamily: 'regular',
                                                    fontSize: 13,
                                                    color: Colors.grey[700]),
                                                maxLines: 2,
                                              ),
                                            ),
                                            Visibility(
                                              visible: currentUser['_id'] ==
                                                  selectedUserDetail['_id'],
                                              child: SizedBox(
                                                height: 45,
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text(
                                                    'Please go to your account for more details',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: currentUser['_id'] !=
                                                  selectedUserDetail['_id'],
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 25,
                                                    right: 20,
                                                    top: 10),
                                                child: Container(
                                                  height: 45,
                                                  width: 300,
                                                  child: TextButton(
                                                      child: Text(
                                                        followingSelectedUser
                                                            ? 'Following'
                                                            : 'Follow',
                                                        style: TextStyle(
                                                            fontFamily: 'Bold',
                                                            fontSize: 13,
                                                            color: HexColor(
                                                                followingSelectedUser
                                                                    ? "#711E97"
                                                                    : "#ffffff")),
                                                      ),
                                                      onPressed: () {
                                                        final runMutation =
                                                            followingSelectedUser
                                                                ? runMutationUnfollow
                                                                : runMutationFollow;
                                                        runMutation({
                                                          '_id':
                                                              selectedUserDetail[
                                                                  '_id']
                                                        });
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor: HexColor(
                                                            followingSelectedUser
                                                                ? "#ffffff"
                                                                : "#711E97"),
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: HexColor(
                                                                    "#711E97"),
                                                                width: 1,
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25.0)),
                                                      )),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      centerTitle: true,
                                      automaticallyImplyLeading: false,
                                      toolbarHeight: 315,
                                    ),
                                    body: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                        ),
                                        itemCount:
                                            selectedUserDetail['myProducts']
                                                .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final myProduct =
                                              selectedUserDetail['myProducts']
                                                  [index];
                                          _productFilter() {
                                            if (myProduct['soldOut'] == false) {
                                              return Container(
                                                  color: Colors.grey[300],
                                                  child: Image(
                                                    image: NetworkImage(
                                                        myProduct['images'][0]),
                                                    fit: BoxFit.cover,
                                                  ));
                                            } else if (myProduct['soldOut'] ==
                                                true) {
                                              return Container(
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                        color: Colors.grey[300],
                                                        child: Image(
                                                          image: NetworkImage(
                                                              myProduct[
                                                                  'images'][0]),
                                                          fit: BoxFit.cover,
                                                        )),
                                                    Positioned(
                                                        top: 60,
                                                        child: Text(
                                                          'SOLD OUT',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 18),
                                                        )),
                                                  ],
                                                ),
                                              );
                                            }
                                          }

                                          return InkResponse(
                                              onTap: () {
                                                print(index);
                                                Navigator.pushNamed(context,
                                                    ProductdetailsRoute,
                                                    arguments:
                                                        ProductDetailArguments(
                                                            myProduct['_id']));
                                              },
                                              child: _productFilter());
                                        }),
                                  );
                                });
                          });
                    });
              });
        });
  }
}
