import 'package:client/graphql/mutations.dart';
import 'package:client/graphql/queries.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/home/seller-shop.dart';
import 'package:client/screens/message/chat.dart';
import 'package:client/widgets/modals/floating-modal.dart';
import 'package:client/widgets/modals/redirect-modal.dart';
import 'package:client/widgets/product-details-bottom.dart';
import 'package:client/widgets/product-details-top.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class ProductDetailArguments {
  final String productId;

  ProductDetailArguments(this.productId);
}

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final ProductDetailArguments routeArgs =
        ModalRoute.of(context).settings.arguments;
    return Mutation(
        options: MutationOptions(
          document: gql(follow),
          update: (GraphQLDataProxy cache, QueryResult resultFollow) {
            return cache;
          },
          onCompleted: (dynamic resultData) {},
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
                onCompleted: (dynamic resultData) {},
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
                      document: gql(addProduct),
                      update: (GraphQLDataProxy cache, QueryResult resultAdd) {
                        return cache;
                      },
                      onCompleted: (dynamic resultData) {
                        if (resultData != null) {
                          setState(() {});
                          print('product added to cart');
                        } else {
                          print('product add to cart failed');
                          return;
                        }
                      },
                    ),
                    builder:
                        (RunMutation runMutationAdd, QueryResult resultAdd) {
                      if (resultAdd.hasException) {
                        return Container(
                            color: Colors.white,
                            child: Center(
                                child: Text(
                              resultAdd.exception.toString(),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 11),
                            )));
                      }

                      if (resultAdd.isLoading) {
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
                            document: gql(removeProduct),
                            update: (GraphQLDataProxy cache,
                                QueryResult resultRemove) {
                              return cache;
                            },
                            onCompleted: (dynamic resultData) {
                              if (resultData != null) {
                                setState(() {});
                                if (resultData != null) {
                                  print('product removed from cart');
                                } else {
                                  print('remove failed');
                                  return;
                                }
                              } else {}
                            },
                          ),
                          builder: (RunMutation runMutationRemove,
                              QueryResult resultRemove) {
                            if (resultRemove.hasException) {
                              return Container(
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    resultRemove.exception.toString(),
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 11),
                                  )));
                            }

                            if (resultRemove.isLoading) {
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
                                  update: (GraphQLDataProxy cache,
                                      QueryResult result) {
                                    return cache;
                                  },
                                  onCompleted: (dynamic resultData) {
                                    var room = resultData['createRoom'];
                                    if (room != null) {
                                      return Navigator.pushNamed(
                                          context, ChatRoute,
                                          arguments:
                                              ChatRouteArguments(room['_id']));
                                    } else {
                                      return Container(
                                          color: Colors.white,
                                          child: Center(
                                              child: Text(
                                            'Chat room creation failed!',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 11),
                                          )));
                                    }
                                  },
                                ),
                                builder: (RunMutation runMutation,
                                    QueryResult result) {
                                  if (result.hasException) {
                                    return Container(
                                        color: Colors.white,
                                        child: Center(
                                            child: Text(
                                          result.exception.toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 11),
                                        )));
                                  }

                                  if (result.isLoading) {
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
                                  return Query(
                                      options: QueryOptions(
                                        document: gql(fetchUser),
                                      ),
                                      builder: (QueryResult result,
                                          {VoidCallback refetch,
                                          FetchMore fetchMore}) {
                                        if (result.hasException) {
                                          return Container(
                                              child: Center(
                                                  child: Text(result.exception
                                                      .toString())));
                                        }

                                        if (result.isLoading) {
                                          return Container(
                                              color: Colors.white,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          HexColor("#711E97")),
                                                ),
                                              ));
                                        }

                                        final userDetail =
                                            result.data['fetchUser'];

                                        return Query(
                                            options: QueryOptions(
                                                document: gql(getProductById),
                                                variables: {
                                                  '_id': routeArgs.productId
                                                }),
                                            builder: (QueryResult result,
                                                {VoidCallback refetch,
                                                FetchMore fetchMore}) {
                                              if (result.hasException) {
                                                return Container(
                                                    child: Center(
                                                        child: Text(result
                                                            .exception
                                                            .toString())));
                                              }

                                              if (result.isLoading) {
                                                return Container(
                                                    color: Colors.white,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                HexColor(
                                                                    "#711E97")),
                                                      ),
                                                    ));
                                              }

                                              final productDetail =
                                                  result.data['getProductById'];
                                              final followingProductUser =
                                                  userDetail['following'].any(
                                                      (following) =>
                                                          following['_id'] ==
                                                          productDetail['user']
                                                              ['_id']);
                                              final productIsInCart =
                                                  userDetail['myCart'].any(
                                                      (product) =>
                                                          product['_id'] ==
                                                          productDetail['_id']);

                                              Size screenSize =
                                                  MediaQuery.of(context).size;
                                              var width = screenSize.width;
                                              var height = screenSize.height;

                                              return Scaffold(
                                                appBar: AppBar(
                                                  backgroundColor: Colors.white,
                                                  elevation: 0,
                                                  title: Text(
                                                    'Product Details',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 15),
                                                  ),
                                                  centerTitle: true,
                                                  leading: IconButton(
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    color: Colors.black87,
                                                    icon:
                                                        Icon(Icons.arrow_back),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  automaticallyImplyLeading:
                                                      false,
                                                ),
                                                body: SingleChildScrollView(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 0, top: 0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ProductDetailsTop(
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  SellershopRoute,
                                                                  arguments: SellerShopRouteArguments(
                                                                      productDetail[
                                                                              'user']
                                                                          [
                                                                          '_id']));
                                                            },
                                                            profile: productDetail['user'] == null
                                                                ? ''
                                                                : (productDetail['user']['profilePhoto'] ??
                                                                    ''),
                                                            username: productDetail['user'] ==
                                                                    null
                                                                ? ''
                                                                : (productDetail['user']['usernameId'] ??
                                                                    ''),
                                                            follow:
                                                                followingProductUser
                                                                    ? 'Following'
                                                                    : 'Follow',
                                                            followColor:
                                                                followingProductUser
                                                                    ? HexColor(
                                                                        "#ffffff")
                                                                    : HexColor(
                                                                        "#711E97"),
                                                            textColor:
                                                                followingProductUser
                                                                    ? HexColor(
                                                                        "#711E97")
                                                                    : HexColor(
                                                                        "#ffffff"),
                                                            showFollowUnfollowButton:
                                                                productDetail['user']['_id'] !=
                                                                    userDetail[
                                                                        '_id'],
                                                            onFollowAction: () {
                                                              final followActionMutation =
                                                                  followingProductUser
                                                                      ? runMutationUnfollow
                                                                      : runMutationFollow;
                                                              followActionMutation({
                                                                '_id': productDetail[
                                                                        'user']
                                                                    ['_id']
                                                              });
                                                            },
                                                            images:
                                                                productDetail[
                                                                    'images'],
                                                            bookmark:
                                                                productIsInCart
                                                                    ? Visibility(
                                                                        visible:
                                                                            productDetail['user']['_id'] !=
                                                                                userDetail['_id'],
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            runMutationRemove({
                                                                              '_id': productDetail['_id']
                                                                            });
                                                                          },
                                                                          child: Icon(
                                                                              Icons.bookmark,
                                                                              color: Colors.black87,
                                                                              size: 35),
                                                                        ),
                                                                      )
                                                                    : Visibility(
                                                                        visible:
                                                                            productDetail['user']['_id'] !=
                                                                                userDetail['_id'],
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            runMutationAdd({
                                                                              '_id': productDetail['_id']
                                                                            });
                                                                          },
                                                                          child: Icon(
                                                                              Icons.bookmark_border_outlined,
                                                                              color: Colors.black87,
                                                                              size: 35),
                                                                        ),
                                                                      ),
                                                            description:
                                                                productDetail[
                                                                        'description'] ??
                                                                    ''),
                                                        ProductDetailsBottom(
                                                          price: NumberFormat
                                                              .simpleCurrency(
                                                            locale: 'ko',
                                                            name: 'KRW',
                                                          ).format(
                                                              productDetail[
                                                                  'price']),
                                                          brand: productDetail[
                                                                  'brand'] ??
                                                              '',
                                                          category: productDetail[
                                                                  'category'] ??
                                                              '',
                                                          style: productDetail[
                                                                  'style'] ??
                                                              '',
                                                          condition: productDetail[
                                                                  'condition'] ??
                                                              '',
                                                          size: productDetail[
                                                                  'size'] ??
                                                              '',
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Visibility(
                                                          visible: productDetail[
                                                                      'soldOut'] ==
                                                                  false
                                                              ? true
                                                              : productDetail['user']
                                                                          [
                                                                          '_id'] ==
                                                                      userDetail[
                                                                          '_id']
                                                                  ? true
                                                                  : false,
                                                          child: Container(
                                                            child: Text(
                                                              NumberFormat
                                                                  .simpleCurrency(
                                                                locale: 'ko',
                                                                name: 'KRW',
                                                              ).format(
                                                                  productDetail[
                                                                      'price']),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Bold',
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black87),
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: productDetail[
                                                                      'user']
                                                                  ['_id'] !=
                                                              userDetail['_id'],
                                                          child: Container(
                                                            height: 40,
                                                            width: width * 0.6,
                                                            child: productDetail[
                                                                        'soldOut'] ==
                                                                    false
                                                                ? Material(
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
                                                                            'otherUserId':
                                                                                productDetail['user']['_id']
                                                                          });
                                                                        },
                                                                        style: TextButton.styleFrom(
                                                                          backgroundColor:
                                                                              HexColor("#711E97"),
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                        )),
                                                                  )
                                                                : Text(
                                                                    '판매완료',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Bold',
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: productDetail[
                                                                      'user']
                                                                  ['_id'] ==
                                                              userDetail['_id'],
                                                          child: productDetail[
                                                                      'soldOut'] ==
                                                                  false
                                                              ? Container(
                                                                  height: 40,
                                                                  width: width *
                                                                      0.6,
                                                                  child:
                                                                      Material(
                                                                    child: TextButton(
                                                                        child: Text(
                                                                          '수정하기',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Bold',
                                                                              fontSize: 13,
                                                                              color: Colors.white),
                                                                        ),
                                                                        onPressed: () {
                                                                          showFloatingModalBottomSheet(
                                                                              context: context,
                                                                              builder: (context) => RedirectModal());
                                                                        },
                                                                        style: TextButton.styleFrom(
                                                                          backgroundColor:
                                                                              HexColor("#711E97"),
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                        )),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 40,
                                                                  width: width *
                                                                      0.6,
                                                                  child:
                                                                      Material(
                                                                    child: TextButton(
                                                                        child: Text(
                                                                          '판매완료',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Bold',
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                HexColor("#711E97"),
                                                                          ),
                                                                        ),
                                                                        onPressed: () {
                                                                          showFloatingModalBottomSheet(
                                                                              context: context,
                                                                              builder: (context) => RedirectModal());
                                                                        },
                                                                        style: TextButton.styleFrom(
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          shape: RoundedRectangleBorder(
                                                                              side: BorderSide(color: HexColor("#711E97"), width: 1, style: BorderStyle.solid),
                                                                              borderRadius: BorderRadius.circular(5.0)),
                                                                        )),
                                                                  ),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      });
                                });
                          });
                    });
              });
        });
  }
}
