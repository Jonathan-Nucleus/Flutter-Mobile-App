import 'package:client/screens/home/home.dart';
import 'package:client/screens/message/rooms.dart';
import 'package:client/screens/myshop/myshop.dart';
import 'package:client/screens/search/search.dart';
import 'package:client/screens/upload/upload.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Search(),
    UploadProduct(),
    Rooms(),
    MyShop(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Theme(
        data: ThemeData(),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.only(top: 10),
                child: Icon(MdiIcons.home),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.search),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.add_circle_outline),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.only(top: 10),
                child: Icon(MdiIcons.telegram),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.person),
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple[700],
          unselectedItemColor: Colors.grey[700],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
