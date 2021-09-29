import 'package:client/graphql/queries.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/home/product-details.dart';
import 'package:client/widgets/user-avatar.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:client/screens/myshop/my-products-details.dart';

class MyShop extends StatefulWidget {
  @override
  _MyShopState createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        '전체 상품',
        style: TextStyle(
          fontSize: 14,
          fontFamily: "Bold",
        ),
      ),
    ),
    Tab(
      child: Text(
        '찜',
        style: TextStyle(
          fontSize: 14,
          fontFamily: "Bold",
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    int _counter = 0;
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
                child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
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

          _refetch() {
            refetch();
          }

          var photo = result.data['fetchUser']['profilePhoto'];
          var username = result.data['fetchUser']['usernameId'];
          var followers = result.data['fetchUser']['followers'];
          var following = result.data['fetchUser']['following'];
          var intro = result.data['fetchUser']['introduction'];
          var products = result.data['fetchUser']['myProducts'];
          var cart = result.data['fetchUser']['myCart'];

          return Query(
              options: QueryOptions(
                document: gql(getSoldProducts),
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
                      valueColor:
                          AlwaysStoppedAnimation<Color>(HexColor("#711E97")),
                    ),
                  ));
                }

                if (result.data == null) {
                  return Container(child: Center(child: Text('null-value')));
                }

                var sold = result.data['getSoldProducts'];

                return WillPopScope(
                  onWillPop: () async => false,
                  child: DefaultTabController(
                    length: myTabs.length,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        title: Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, NotificationsRoute);
                                      },
                                      child: Icon(
                                        MdiIcons.bell,
                                        color: Colors.black87,
                                        size: 20,
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, SettingsRoute);
                                      },
                                      child: Icon(
                                        MdiIcons.cog,
                                        color: Colors.black87,
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: 5, left: 10),
                                color: Colors.white,
                                child: UserAvatar(
                                    image: photo.toString(),
                                    id: username.toString()),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: width * 0.1,
                                    right: width * 0.15,
                                    top: 5),
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, FollowersRoute);
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            followers.length.toString(),
                                            style: TextStyle(
                                                fontFamily: 'Bold',
                                                fontSize: 15,
                                                color: Colors.black87),
                                          ),
                                          Text(
                                            'Followers',
                                            style: TextStyle(
                                                fontFamily: 'Bold',
                                                fontSize: 13,
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, FollowingRoute);
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            following.length.toString(),
                                            style: TextStyle(
                                                fontFamily: 'Bold',
                                                fontSize: 15,
                                                color: Colors.black87),
                                          ),
                                          Text(
                                            'Following',
                                            style: TextStyle(
                                                fontFamily: 'Bold',
                                                fontSize: 13,
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          sold.toString(),
                                          style: TextStyle(
                                              fontFamily: 'Bold',
                                              fontSize: 15,
                                              color: Colors.black87),
                                        ),
                                        Text(
                                          'Sold',
                                          style: TextStyle(
                                              fontFamily: 'Bold',
                                              fontSize: 13,
                                              color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 25, right: 20, top: 10),
                                color: Colors.white,
                                child: Text(
                                  intro.toString(),
                                  style: TextStyle(
                                      fontFamily: 'regular',
                                      fontSize: 13,
                                      color: Colors.grey[700]),
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        toolbarHeight: 300,
                        bottom: TabBar(
                          tabs: myTabs,
                          indicatorColor: Colors.purple[700],
                          labelColor: Colors.purple[700],
                          unselectedLabelColor: Colors.black87,
                        ),
                      ),
                      body: Container(
                        child: TabBarView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                                  itemCount: products.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final myProduct = products[index];
                                    _productFilter() {
                                      if (myProduct['soldOut'] == false) {
                                        return Container(
                                            color: Colors.grey[300],
                                            child: Image(
                                              image: NetworkImage(
                                                  myProduct['images'][0]),
                                              fit: BoxFit.cover,
                                            ));
                                      } else if (myProduct['soldOut'] == true) {
                                        return Container(
                                          child: Stack(
                                            fit: StackFit.expand,
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                  color: Colors.grey[300],
                                                  child: Image(
                                                    image: NetworkImage(
                                                        myProduct['images'][0]),
                                                    fit: BoxFit.cover,
                                                  )),
                                              Positioned(
                                                  top: 60,
                                                  child: Text(
                                                    'SOLD OUT',
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 18),
                                                  )),
                                            ],
                                          ),
                                        );
                                      }
                                    }

                                    return InkResponse(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(MyProductdetailsRoute,
                                                arguments:
                                                    MyProductDetailArguments(
                                                        myProduct['_id']))
                                            .then((value) {
                                          print(value);
                                          setState(() {
                                            refetch();
                                            _refetch();
                                          });
                                          print(_counter);
                                        });
                                      },
                                      child: _productFilter(),
                                    );
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                                  itemCount: cart.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final cartProduct = cart[index];

                                    _cartFilter() {
                                      if (cartProduct['soldOut'] == false) {
                                        return Container(
                                            color: Colors.grey[300],
                                            child: Image(
                                              image: NetworkImage(
                                                  cartProduct['images'][0]),
                                              fit: BoxFit.cover,
                                            ));
                                      } else if (cartProduct['soldOut'] ==
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
                                                        cartProduct['images']
                                                            [0]),
                                                    fit: BoxFit.cover,
                                                  )),
                                              Positioned(
                                                  top: 60,
                                                  child: Text(
                                                    'SOLD OUT',
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 18),
                                                  )),
                                            ],
                                          ),
                                        );
                                      }
                                    }

                                    return InkResponse(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, ProductdetailsRoute,
                                              arguments: ProductDetailArguments(
                                                  cartProduct['_id']));
                                        },
                                        child: _cartFilter());
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
