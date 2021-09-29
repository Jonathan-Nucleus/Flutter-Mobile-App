import 'package:flutter/material.dart';

class SetModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      padding: EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Text(
            '원피스/세트',
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
                      '원피스',
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
                      '세트',
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
                      '기타',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
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
