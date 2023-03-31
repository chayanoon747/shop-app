import 'package:flutter/material.dart';

class ShopBagScreen extends StatelessWidget {
  String? docId;
  ShopBagScreen({this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Shop Bag'),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ));
  }
}
