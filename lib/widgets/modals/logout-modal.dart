import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:client/graphql/graphql.dart';

class LogoutModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Container(
      height: 160,
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Text(
            '로그아웃',
            style: TextStyle(
              fontFamily: "Bold",
              fontSize: 20,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '정말 로그아웃하시겠습니까?',
            style: TextStyle(
              fontFamily: "medium",
              fontSize: 14,
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.25,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '취소',
                        style: TextStyle(
                          fontFamily: "medium",
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey)),
                ),
                SizedBox(width: 15),
                Container(
                  width: width * 0.25,
                  child: TextButton(
                      onPressed: () {
                        GraphQLConfiguration.removeToken();
                        Navigator.pushNamed(context, LoginRoute);
                      },
                      child: Text(
                        '확인',
                        style: TextStyle(
                          fontFamily: "medium",
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black87)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
