import 'package:client/screens/home/feed.dart';
import 'package:client/screens/home/main.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        'Main',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Feed',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Image(
                image: AssetImage("lib/assets/images/logo_main.png"),
                height: 40,
                width: 40),
            centerTitle: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            bottom: TabBar(
              tabs: myTabs,
              indicatorColor: Colors.purple[700],
              labelColor: Colors.purple[700],
              unselectedLabelColor: Colors.black87,
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Main(),
              Feed(),
            ],
          ),
        ),
      ),
    );
  }
}
