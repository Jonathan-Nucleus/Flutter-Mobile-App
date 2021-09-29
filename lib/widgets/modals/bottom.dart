import 'package:flutter/material.dart';

class BottomModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Text(
            '하의',
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
                      '청바지',
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
                      '면바지',
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
                      '슬랙스',
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
                title: Text(
                  '조거',
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
                  '숏팬츠',
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
                  '레깅스',
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
                  '스커트',
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
