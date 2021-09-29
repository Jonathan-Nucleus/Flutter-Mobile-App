import 'package:client/routes/routes.dart';
import 'package:client/widgets/modals/floating-modal.dart';
import 'package:client/widgets/modals/logout-modal.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black87, fontSize: 15),
        ),
        centerTitle: true,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: Colors.black87,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.pushNamed(context, EditprofileRoute);
                },
                title: Text(
                  '프로필 수정',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: "Medium"),
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.pushNamed(context, EditinfoRoute);
                },
                title: Text(
                  '개인정보 수정',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: "Medium"),
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.pushNamed(context, EditnotiRoute);
                },
                title: Text(
                  '알림 설정',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: "Medium"),
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  showFloatingModalBottomSheet(
                    context: context,
                    builder: (context) => LogoutModal(),
                  );
                },
                title: Text(
                  '로그아웃',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: "Medium"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
