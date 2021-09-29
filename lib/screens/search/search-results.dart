import 'package:client/graphql/queries.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/home/product-details.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchResultsRouteArguments {
  final String categoryId;

  SearchResultsRouteArguments(this.categoryId);
}

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    final SearchResultsRouteArguments routeArgs =
        ModalRoute.of(context).settings.arguments;

    return Query(
        options: QueryOptions(
            document: gql(getCategoryById),
            variables: {'_id': routeArgs.categoryId}),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Container(
                color: Colors.white,
                child: Center(
                    child: Text(result.exception.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ))));
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

          final categoryDetail = result.data['getCategoryById']['products'];

          _results() {
            if (categoryDetail.length == 0) {
              return Center(
                child: Text('No Results',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    )),
              );
            } else {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: categoryDetail.length,
                  itemBuilder: (BuildContext context, int index) {
                    final products = categoryDetail[index];
                    print(products);
                    return InkResponse(
                      onTap: () {
                        Navigator.pushNamed(context, ProductdetailsRoute,
                            arguments: ProductDetailArguments(products['_id']));
                      },
                      child: Container(
                          color: Colors.grey[300],
                          child: Image(
                            image: NetworkImage(products['images'][0]),
                            fit: BoxFit.cover,
                          )),
                    );
                  });
            }
          }

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Container(
                  child: Text(
                    'Search Results',
                    style: TextStyle(color: Colors.black87, fontSize: 15),
                  ),
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
                centerTitle: true,
                toolbarHeight: 70,
              ),
              body: _results());
        });
  }
}
