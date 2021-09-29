import 'package:client/graphql/queries.dart';
import 'package:client/screens/home/product-details.dart';
import 'package:client/screens/home/seller-shop.dart';
import 'package:client/screens/search/search-results.dart';
import 'package:client/widgets/category.dart';
import 'package:client/widgets/ranking.dart';
import 'package:client/widgets/recommended.dart';
import 'package:client/widgets/section-title.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:quiver/iterables.dart';
import 'package:client/routes/routes.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    // return Query(
    //     options: QueryOptions(
    //       document: gql(getCategories),
    //     ),
    //     builder: (QueryResult resultCategories,
    //         {VoidCallback refetch, FetchMore fetchMore}) {
    //       if (resultCategories.hasException) {
    //         return Container(
    //             child:
    //                 Center(child: Text(resultCategories.exception.toString())));
    //       }

    //       if (resultCategories.isLoading) {
    //         return Container(
    //             child: Center(
    //           child: CircularProgressIndicator(
    //             valueColor: AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
    //           ),
    //         ));
    //       }

    //       var top = resultCategories.data['getCategories'][0]['sub_categories'];
    //       var bottom =
    //           resultCategories.data['getCategories'][1]['sub_categories'];
    //       var outer =
    //           resultCategories.data['getCategories'][2]['sub_categories'];
    //       var set = resultCategories.data['getCategories'][3]['sub_categories'];

    return Query(
        options: QueryOptions(
          document: gql(getRecommendedProducts),
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
                document: gql(fetchPopularUsers),
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

                return Query(
                    options: QueryOptions(
                      document: gql(getPopularCategories),
                    ),
                    builder: (QueryResult result3,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result3.hasException) {
                        return Container(
                            child: Center(
                                child: Text(result3.exception.toString())));
                      }

                      if (result3.isLoading) {
                        return Container(
                            child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                HexColor("#711E97")),
                          ),
                        ));
                      }

                      return Query(
                          options: QueryOptions(
                            document: gql(getAllProducts),
                          ),
                          builder: (QueryResult result4,
                              {VoidCallback refetch, FetchMore fetchMore}) {
                            if (result4.hasException) {
                              return Container(
                                  child: Center(
                                      child:
                                          Text(result4.exception.toString())));
                            }

                            if (result4.isLoading) {
                              return Container(
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
                                builder: (QueryResult resultFetchUser,
                                    {VoidCallback refetch,
                                    FetchMore fetchMore}) {
                                  if (resultFetchUser.hasException) {
                                    return Container(
                                        child: Center(
                                            child: Text(
                                                result4.exception.toString())));
                                  }

                                  if (resultFetchUser.isLoading) {
                                    return Container(
                                        child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                HexColor("#711E97")),
                                      ),
                                    ));
                                  }
                                  var recommendedProducts =
                                      result.data['getRecommendedProducts'];
                                  var recommendedProductsParts =
                                      partition(recommendedProducts, 5);

                                  var popularUsers =
                                      result2.data['fetchPopularUsers'];
                                  var popularCategories =
                                      result3.data['getPopularCategories'];

                                  var allProducts =
                                      result4.data['getAllProducts'];

                                  final currentUser =
                                      resultFetchUser.data['fetchUser'];

                                  return SingleChildScrollView(
                                    physics: ScrollPhysics(),
                                    child: Column(
                                      children: [
                                        SectionTitle(title: '디피가 추천해드릴게요'),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 150,
                                          child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              children: recommendedProductsParts
                                                      .isEmpty
                                                  ? []
                                                  : recommendedProductsParts
                                                      .elementAt(0)
                                                      .map((product) {
                                                      var formattedPrice =
                                                          NumberFormat
                                                              .simpleCurrency(
                                                        locale: 'ko',
                                                        name: 'KRW',
                                                      ).format(
                                                              product['price']);
                                                      return Recommended(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                ProductdetailsRoute,
                                                                arguments:
                                                                    ProductDetailArguments(
                                                                        product[
                                                                            '_id']));
                                                          },
                                                          product: product[
                                                                      'images']
                                                                  .isEmpty
                                                              ? ''
                                                              : product[
                                                                  'images'][0],
                                                          profile: product[
                                                                          'user']
                                                                      [
                                                                      'profilePhoto'] ==
                                                                  null
                                                              ? ''
                                                              : product['user'][
                                                                  'profilePhoto'],
                                                          price:
                                                              formattedPrice);
                                                    }).toList()),
                                        ),
                                        SizedBox(height: 15),
                                        Container(
                                          height: 150,
                                          child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              children: recommendedProductsParts
                                                          .length <
                                                      2
                                                  ? []
                                                  : recommendedProductsParts
                                                      .elementAt(1)
                                                      .map((product) {
                                                      var formattedPrice =
                                                          NumberFormat
                                                              .simpleCurrency(
                                                        locale: 'ko',
                                                        name: 'KRW',
                                                      ).format(
                                                              product['price']);
                                                      return Recommended(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                ProductdetailsRoute,
                                                                arguments:
                                                                    ProductDetailArguments(
                                                                        product[
                                                                            '_id']));
                                                          },
                                                          product: product[
                                                                      'images']
                                                                  .isEmpty
                                                              ? ''
                                                              : product[
                                                                  'images'][0],
                                                          profile: product[
                                                                          'user']
                                                                      [
                                                                      'profilePhoto'] ==
                                                                  null
                                                              ? ''
                                                              : product['user'][
                                                                  'profilePhoto'],
                                                          price:
                                                              formattedPrice);
                                                    }).toList()),
                                        ),
                                        SectionTitle(title: '셀러 랭킹'),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 110,
                                          child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              children: popularUsers
                                                  .map<Widget>((popular) {
                                                return Ranking(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          SellershopRoute,
                                                          arguments:
                                                              SellerShopRouteArguments(
                                                                  popular[
                                                                      '_id']));
                                                    },
                                                    profile:
                                                        popular['profilePhoto'] ==
                                                                null
                                                            ? ''
                                                            : popular[
                                                                'profilePhoto'],
                                                    id: popular['usernameId']
                                                            .isEmpty
                                                        ? ''
                                                        : popular[
                                                            'usernameId']);
                                              }).toList()),
                                        ),
                                        SectionTitle(title: '인기 카테고리'),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 150,
                                          child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              children: popularCategories
                                                  .map<Widget>((popular) {
                                                return Category(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          SearchresultsRoute,
                                                          arguments:
                                                              SearchResultsRouteArguments(
                                                                  popular[
                                                                      '_id']));
                                                    },
                                                    image: popular['image'],
                                                    category:
                                                        popular['name'] == null
                                                            ? ''
                                                            : popular['name'],
                                                    productsCount: popular[
                                                        'productsCount']);
                                              }).toList()),
                                        ),
                                        SizedBox(height: 15),
                                        SectionTitle(title: '최근 등록된 상품'),
                                        SizedBox(height: 10),
                                        GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5,
                                            ),
                                            itemCount: allProducts.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final product =
                                                  allProducts[index];
                                              return InkResponse(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      ProductdetailsRoute,
                                                      arguments:
                                                          ProductDetailArguments(
                                                              product['_id']));
                                                },
                                                child: Container(
                                                    color: Colors.grey[300],
                                                    child: Image(
                                                      image: NetworkImage(
                                                          product['images']
                                                                  .isEmpty
                                                              ? ''
                                                              : product[
                                                                  'images'][0]),
                                                      fit: BoxFit.cover,
                                                    )),
                                              );
                                            }),
                                        SizedBox(height: 30),
                                      ],
                                    ),
                                  );
                                });
                          });
                    });
              });
        });
    // });
  }
}
