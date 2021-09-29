
import 'package:client/widgets/main-products.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MainProducts(),
    );
  }
}
