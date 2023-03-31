import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/member_model.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseFirestore.instance.collection('members');
    final userRef = dbRef.where("username", isEqualTo: "45dsa");

    FirebaseAuth? auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? uid = user?.uid;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Account",
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: StreamBuilder(
          stream: userRef.snapshots(),
          /*FirebaseFirestore.instance
              .collection("members")
              .doc(auth.currentUser?.uid).
              .snapshots(),*/
          builder: (context, snapshot) {
            try {
              if (snapshot.hasData) {
                var userdocument = snapshot.data;
                return Column(
                  children: [
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 2),
                      child: SizedBox(
                        height: 70,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[850],
                            ),
                            onPressed: null,
                            child: Row(children: [
                              Icon(Icons.person_outline, color: Colors.white),
                              Expanded(
                                  child: Text(
                                '  Username: ${userdocument?.docs.first['username']}',
                                style: TextStyle(color: Colors.white),
                              )),
                            ])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 2),
                      child: SizedBox(
                        height: 70,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[850],
                                foregroundColor: Colors.white),
                            onPressed: () {},
                            child: Row(children: [
                              Icon(Icons.key),
                              Expanded(
                                  child: Text(
                                      '  Password: ${userdocument?.docs.first['password']}')),
                              Icon(Icons.arrow_forward),
                            ])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 2),
                      child: SizedBox(
                        height: 70,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[850],
                                foregroundColor: Colors.white),
                            onPressed: () {},
                            child: Row(children: [
                              Icon(Icons.mail),
                              Expanded(
                                  child: Text(
                                      '  Email: ${userdocument?.docs.first['email']}')),
                              Icon(Icons.arrow_forward),
                            ])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 2),
                      child: SizedBox(
                        height: 70,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[850],
                                foregroundColor: Colors.white),
                            onPressed: () {},
                            child: Row(children: [
                              Icon(Icons.tablet_android),
                              Expanded(
                                  child: Text(
                                      '  Phone-number: ${userdocument?.docs.first['phone']}')),
                              Icon(Icons.arrow_forward),
                            ])),
                      ),
                    ),
                  ],
                );
              }
            } catch (e) {}
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Future<String> getProductId() async {
    var snapshot = FirebaseFirestore.instance
        .collection('stores')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    return snapshot.toString();
  }
}
