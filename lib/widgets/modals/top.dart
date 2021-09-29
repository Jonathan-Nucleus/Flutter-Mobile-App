import 'package:flutter/material.dart';

class TopModal extends StatefulWidget {
  final Widget child;

  TopModal({@required this.child});
  @override
  _TopModalState createState() => _TopModalState();
}

class _TopModalState extends State<TopModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: EdgeInsets.only(top: 25),
      child: widget.child,
    );
  }
}
