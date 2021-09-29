import 'package:client/graphql/mutations.dart';
import 'package:client/graphql/queries.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/myshop/edit-product.dart';
import 'package:client/widgets/modals/edit-modal.dart';
import 'package:client/widgets/modals/floating-modal.dart';
import 'package:client/widgets/modals/sold-modal.dart';
import 'package:client/widgets/my-prod-details-bottom.dart';
import 'package:client/widgets/my-prod-details-top.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class MyProductDetailArguments {
  final String productId;

  MyProductDetailArguments(this.productId);
}

class MyProductDetails extends StatefulWidget {
  @override
  _MyProductDetailsState createState() => _MyProductDetailsState();
}

class _MyProductDetailsState extends State<MyProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    final MyProductDetailArguments routeArgs =
        ModalRoute.of(context).settings.arguments;
    return Mutation(
        options: MutationOptions(
          document: gql(deleteProduct),
          update: (GraphQLDataProxy cache, QueryResult result) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
            var res = resultData['deleteProduct'];
            if (res == true) {
              return Navigator.pop(context, true);
            } else {
              Container(
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    'Delete Failed',
                    style: TextStyle(color: Colors.black87, fontSize: 11),
                  )));
            }
          },
        ),
        builder: (RunMutation runMutationDelete, QueryResult result) {
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

          return Mutation(
              options: MutationOptions(
                document: gql(updateSoldProduct),
                onCompleted: (dynamic resultData) {
                  print(resultData);
                },
              ),
              builder: (RunMutation runMutationSold, QueryResult result) {
                if (result.hasException) {
                  return Container(
                      color: Colors.white,
                      child: Center(
                          child: Text(
                        result.exception.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
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

                      var myProducts = result.data['fetchUser']['myProducts'];

                      var selectedProduct = myProducts.firstWhere(
                          (product) => product['_id'] == routeArgs.productId);
                      print(selectedProduct['_id']);

                      var formattedPrice = NumberFormat.simpleCurrency(
                        locale: 'ko',
                        name: 'KRW',
                      ).format(selectedProduct['price']);

                      return Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          title: Text(
                            'Product Details',
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
                        body: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(left: 0, top: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyProductDetailsTop(
                                  profile: selectedProduct['user']
                                          ['profilePhoto'] ??
                                      '',
                                  username: selectedProduct['user']
                                          ['usernameId'] ??
                                      '',
                                  follow: 'Follow',
                                  images: selectedProduct['images'],
                                  bookmark: true,
                                  description:
                                      selectedProduct['description'] ?? '',
                                ),
                                MyProductDetailsBottom(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                Visibility(
                                  visible: selectedProduct['soldOut'] == false
                                      ? true
                                      : false,
                                  child: Container(
                                    height: 40,
                                    width: width * 0.6,
                                    child: Material(
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
                                              builder: (context) => EditModal(
                                                onPressedEdit: () {
                                                  print('edit');
                                                  Navigator.of(context).pushNamed(
                                                      EditProductRoute,
                                                      arguments:
                                                          EditProductArguments(
                                                              selectedProduct[
                                                                  '_id']));
                                                },
                                                onPressedRemove: () {
                                                  runMutationDelete({
                                                    '_id':
                                                        selectedProduct['_id']
                                                  });
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                onPressedSold: () {
                                                  print(selectedProduct['_id']);
                                                  runMutationSold({
                                                    '_id':
                                                        selectedProduct['_id'],
                                                    'soldOut': !selectedProduct[
                                                        'soldOut']
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                HexColor("#711E97"),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          )),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: selectedProduct['soldOut'] == true
                                      ? true
                                      : false,
                                  child: Container(
                                    height: 40,
                                    width: width * 0.6,
                                    child: Material(
                                      child: TextButton(
                                          child: Text(
                                            '판매완료',
                                            style: TextStyle(
                                              fontFamily: 'Bold',
                                              fontSize: 13,
                                              color: HexColor("#711E97"),
                                            ),
                                          ),
                                          onPressed: () {
                                            showFloatingModalBottomSheet(
                                              context: context,
                                              builder: (context) => SoldModal(
                                                onPressedRemove: () {
                                                  runMutationDelete({
                                                    '_id':
                                                        selectedProduct['_id']
                                                  });
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                onPressedSold: () {
                                                  print(selectedProduct['_id']);
                                                  runMutationSold({
                                                    '_id':
                                                        selectedProduct['_id'],
                                                    'soldOut': !selectedProduct[
                                                        'soldOut']
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: HexColor("#711E97"),
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
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
  }
}
