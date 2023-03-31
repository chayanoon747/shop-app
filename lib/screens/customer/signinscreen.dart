import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/member_model.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/provider/your_product_provider.dart';
import 'package:flutter_application_1/screens/customer/selectscreen.dart';
import 'package:flutter_application_1/screens/customer/signupscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  CollectionReference _memberCollection =
      FirebaseFirestore.instance.collection("members");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Consumer2<ProductProvider, YourProductProvider>(
        builder: (context, ProductProvider provider1,
            YourProductProvider provider2, child) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Icon(
                      Icons.shopify,
                      size: 150,
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      'Sign In!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    // Email Textfield
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ),

                    // Password Textfield
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              prefixIcon: Icon(
                                Icons.key,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    //Sign In Button
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          child: Ink(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: (() async {
                            if (formKey.currentState?.validate() ?? true) {
                              formKey.currentState?.save();
                              try {
                                Future<void> getData() async {
                                  CollectionReference _collectionRef =
                                      FirebaseFirestore.instance
                                          .collection('products');
                                  // Get docs from collection reference
                                  QuerySnapshot querySnapshot =
                                      await _collectionRef.get();

                                  // Get data from docs and convert map to List
                                  final allData = querySnapshot.docs
                                      .map((doc) => doc.data())
                                      .toList();
                                  for (int i = 0; i < allData.length; i++) {
                                    try {
                                      Map<String, dynamic> myMap = allData
                                          .elementAt(i) as Map<String, dynamic>;
                                      provider1.addProduct(myMap);
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  }
                                }

                                void fetchData(String uid) async {
                                  await Future.delayed(Duration(seconds: 2));

                                  for (int i = 0;
                                      i < provider1.getNumProduct();
                                      i++) {
                                    if (provider1
                                            .getMapData(i)['uid']
                                            .toString() ==
                                        uid.toString()) {
                                      provider2
                                          .addProduct(provider1.getMapData(i));
                                    }
                                  }
                                }

                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim())
                                    .then((value) {
                                  getData();

                                  var uid =
                                      FirebaseAuth.instance.currentUser?.uid;
                                  fetchData(uid.toString());
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SelectScreen();
                                    }));
                                  });
                                });
                              } on FirebaseAuthException catch (e) {
                                print(e.code);
                                Fluttertoast.showToast(
                                  msg: e.message.toString(),
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            }
                          }),
                        )),

                    SizedBox(
                      height: 5,
                    ),

                    // Sign Up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an Account?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignUpScreen();
                            }));
                          },
                          child: Text(
                            ' Sign Up',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
