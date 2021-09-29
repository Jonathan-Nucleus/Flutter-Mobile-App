import 'package:client/widgets/modals/delete-prod.dart';
import 'package:client/widgets/modals/floating-modal.dart';
import 'package:flutter/material.dart';

class EditModal extends StatelessWidget {
  final Function onPressedEdit;
  final Function onPressedRemove;
  final Function onPressedSold;

  const EditModal(
      {this.onPressedEdit, this.onPressedRemove, this.onPressedSold});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            onTap: onPressedEdit,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '내용 수정하기',
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            onTap: () {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => DeleteModal(
                  onPressedDelete: onPressedRemove,
                ),
              );
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '삭제하기',
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            onTap: onPressedSold,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '판매완료',
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
