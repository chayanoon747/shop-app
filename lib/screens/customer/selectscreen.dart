import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/screens/customer/controlconsumers.dart';
import 'package:flutter_application_1/screens/customer/homescreen.dart';
import 'package:flutter_application_1/screens/customer/profilescreen.dart';
import 'package:flutter_application_1/screens/customer/signupscreen.dart';
import 'package:flutter_application_1/screens/store/controlsellers.dart';
import 'package:flutter_application_1/screens/store/signupstore.dart';
import 'package:provider/provider.dart';

import '../../provider/your_product_provider.dart';

class SelectScreen extends StatefulWidget {
  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  CollectionReference _storesCollection =
      FirebaseFirestore.instance.collection("storess");

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth? auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? uid = user?.uid;
    ProductProvider provider1 = Provider.of<ProductProvider>(context);
    YourProductProvider provider2 = Provider.of<YourProductProvider>(context);

    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: (() async {
              debugPrint(uid);
              var snapshot = await FirebaseFirestore.instance
                  .collection('stores')
                  .doc(uid)
                  .get();
              if (snapshot.exists) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ControlSellers();
                }));
              }
              if (!snapshot.exists) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUpStoreScreen();
                }));
              }
            }),
            child: Container(
              height: 270,
              width: 270,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(50)),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/icons/shop.png'),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    height: 200,
                    width: 200,
                    padding: EdgeInsets.all(10),
                  ),
                  Text(
                    'Store',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ControlConsumers();
              }));
            }),
            child: Container(
              height: 270,
              width: 270,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(50)),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/icons/user.png'),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    height: 200,
                    width: 200,
                    padding: EdgeInsets.all(10),
                  ),
                  Text(
                    'Customer',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    ));
  }
}
