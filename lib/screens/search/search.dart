import 'package:client/graphql/queries.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/search/search-results.dart';
import 'package:client/widgets/search-bar.dart';
import 'package:client/widgets/search-category.dart';
import 'package:client/widgets/section-title.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';



class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(getCategories),
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

          var top = result.data['getCategories'][0]['sub_categories'];
          var bottom = result.data['getCategories'][1]['sub_categories'];
          var outer = result.data['getCategories'][2]['sub_categories'];
          var set = result.data['getCategories'][3]['sub_categories'];
          var bagName = result.data['getCategories'][4]['name'];
          var bagImage = result.data['getCategories'][4]['image'];
          var bagId = result.data['getCategories'][4]['_id'];
          var shoesName = result.data['getCategories'][5]['name'];
          var shoesImage = result.data['getCategories'][5]['image'];
          var shoesId = result.data['getCategories'][5]['_id'];
          var accessoryName = result.data['getCategories'][6]['name'];
          var accessoryImage = result.data['getCategories'][6]['image'];
          var accessoryId = result.data['getCategories'][6]['_id'];

          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Container(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Image(
                      image: AssetImage("lib/assets/images/logo_main.png"),
                      height: 40,
                      width: 40),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                iconTheme: IconThemeData(color: Colors.black),
                toolbarHeight: 70,
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Center(child: SearchBar()),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            SectionTitle(title: '상의'),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 10),
                          children: top.getRange(0, 5).map<Widget>((value) {
                            return SearchCategory(
                              category: value['name'],
                              image: value['image'],
                              onPressed: () {
                                Navigator.pushNamed(context, SearchresultsRoute,
                                    arguments: SearchResultsRouteArguments(
                                        value['_id']));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 10),
                          children: top.getRange(5, 9).map<Widget>((value) {
                            return SearchCategory(
                              category: value['name'],
                              image: value['image'],
                              onPressed: () {
                                Navigator.pushNamed(context, SearchresultsRoute,
                                    arguments: SearchResultsRouteArguments(
                                        value['_id']));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: SectionTitle(title: '하의'),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 10),
                          children: bottom.getRange(0, 5).map<Widget>((value) {
                            return SearchCategory(
                              category: value['name'],
                              image: value['image'],
                              onPressed: () {
                                Navigator.pushNamed(context, SearchresultsRoute,
                                    arguments: SearchResultsRouteArguments(
                                        value['_id']));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 10),
                          children: bottom.getRange(5, 9).map<Widget>((value) {
                            return SearchCategory(
                              category: value['name'],
                              image: value['image'],
                              onPressed: () {
                                Navigator.pushNamed(context, SearchresultsRoute,
                                    arguments: SearchResultsRouteArguments(
                                        value['_id']));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: SectionTitle(title: '아우터'),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 10),
                          children: outer.getRange(0, 5).map<Widget>((value) {
                            return SearchCategory(
                              category: value['name'],
                              image: value['image'],
                              onPressed: () {
                                Navigator.pushNamed(context, SearchresultsRoute,
                                    arguments: SearchResultsRouteArguments(
                                        value['_id']));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 10),
                          children: outer.getRange(5, 9).map<Widget>((value) {
                            return SearchCategory(
                              category: value['name'],
                              image: value['image'],
                              onPressed: () {
                                Navigator.pushNamed(context, SearchresultsRoute,
                                    arguments: SearchResultsRouteArguments(
                                        value['_id']));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: SectionTitle(title: '원피스/세트'),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 10),
                          children: set.map<Widget>((value) {
                            return SearchCategory(
                              category: value['name'],
                              image: value['image'],
                              onPressed: () {
                                Navigator.pushNamed(context, SearchresultsRoute,
                                    arguments: SearchResultsRouteArguments(
                                        value['_id']));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: SectionTitle(title: '기타'),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 10),
                          children: [
                            SearchCategory(
                              category: bagName,
                              image: bagImage,
                              onPressed: () {
                                Navigator.pushNamed(context, SearchresultsRoute,
                                    arguments:
                                        SearchResultsRouteArguments(bagId));
                              },
                            ),
                            SearchCategory(
                              category: shoesName,
                              image: shoesImage,
                              onPressed: () {
                                Navigator.pushNamed(context, SearchresultsRoute,
                                    arguments:
                                        SearchResultsRouteArguments(shoesId));
                              },
                            ),
                            SearchCategory(
                              category: accessoryName,
                              image: accessoryImage,
                              onPressed: () {
                                Navigator.pushNamed(context, SearchresultsRoute,
                                    arguments:
                                        SearchResultsRouteArguments(accessoryId));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
