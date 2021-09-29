import 'package:flutter/material.dart';

class OuterModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Text(
            '아우터',
            style: TextStyle(
              fontFamily: "Bold",
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          Column(
            children: [
              Divider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {},
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '트레이닝',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {},
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '후드집업',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {},
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '블루종',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {},
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '라이더재킷',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {},
                title: Text(
                  '트러커재킷',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {},
                title: Text(
                  '블레이저',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {},
                title: Text(
                  '아노락',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {},
                title: Text(
                  '플리스',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -4),
                onTap: () {},
                title: Text(
                  '기타',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ),
              Divider(),
            ],
          )
        ],
      ),
    );
  }
}
