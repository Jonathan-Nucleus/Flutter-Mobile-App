import 'package:flutter/material.dart';

class NoResults extends StatefulWidget {
  @override
  _NoResultsState createState() => _NoResultsState();
}

class _NoResultsState extends State<NoResults> {
  @override
  Widget build(BuildContext context) {
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
        body: Center(
          child: Text('No Results',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
              )),
        ));
  }
}
