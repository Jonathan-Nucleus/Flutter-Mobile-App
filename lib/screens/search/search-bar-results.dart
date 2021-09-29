import 'package:client/graphql/queries.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/home/product-details.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class MySearchArguments {
  final String searchValue;

  MySearchArguments(this.searchValue);
}

class SearchBarResuts extends StatefulWidget {
  @override
  _SearchBarResutsState createState() => _SearchBarResutsState();
}

class _SearchBarResutsState extends State<SearchBarResuts> {
  @override
  Widget build(BuildContext context) {
    final MySearchArguments routeArgs =
        ModalRoute.of(context).settings.arguments;

    return Query(
        options: QueryOptions(
            document: gql(searchProducts),
            variables: {'searchText': routeArgs.searchValue}),
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
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
                  ),
                ));
          }

          var results = result.data['searchProducts'];

          _results() {
            if (results.isEmpty) {
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
                  itemCount: results.length,
                  itemBuilder: (BuildContext context, int index) {
                    final products = results[index];
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
