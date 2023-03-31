import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/customer/categoryscreen.dart';
import 'package:flutter_application_1/screens/customer/favoritescreen.dart';
import 'package:flutter_application_1/screens/customer/selectscreen.dart';
import 'package:flutter_application_1/screens/customer/signinscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool click = false;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth? auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? uid = user?.uid;

    return Scaffold(
        appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return SelectScreen();
              }));
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 45,
            width: 267,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Ink(
              decoration: ShapeDecoration(
                color: Colors.grey[100],
                shape: CircleBorder(),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    click = !click;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FavoriteScreen();
                    }));
                  });
                },
                icon: Icon(
                  (click == true) ? Icons.favorite : Icons.favorite_outline,
                  color: Colors.pink[300],
                ),
              ))
        ],
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ));
  }
}
