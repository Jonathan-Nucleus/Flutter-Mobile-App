import 'package:flutter/material.dart';

class CategoriesModal extends StatefulWidget {
  final Widget child;

  CategoriesModal({@required this.child});
  @override
  _CategoriesModalState createState() => _CategoriesModalState();
}

class _CategoriesModalState extends State<CategoriesModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: EdgeInsets.only(top: 25),
      child: widget.child,
    );
  }
}
