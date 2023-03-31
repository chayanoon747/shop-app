import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/screens/customer/profilescreen.dart';
import 'package:flutter_application_1/screens/customer/selectscreen.dart';
import 'package:flutter_application_1/screens/customer/signinscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_application_1/object/validate.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  CollectionReference _memberCollection =
      FirebaseFirestore.instance.collection("members");
  var password;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: Consumer<ProductProvider>(
                    builder: (context, ProductProvider provider, child) {
                  return SafeArea(
                    child: Center(
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Icon(
                                Icons.lock,
                                size: 100,
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Text(
                                'Sign Up!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                'Please fill in the information',
                                style: TextStyle(fontSize: 16),
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              // Username TextFormField
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: _usernameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Username is required';
                                    } else if (!value.isValidUsername) {
                                      return 'Username should be alphanumberic (a-Z, 0-9) and between \n4-20 characters.';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: 'Username',
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              // Password TextFormField
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    password = value;
                                    if (value!.isEmpty) {
                                      return 'Password is required';
                                    } else if (!value.isValidPassword) {
                                      return 'Your password must be between 8-16 characters, contain \nat least one lowercase letter (a-z), one uppercase letter (A-Z), \none number (0-9), and one special characters (@\$!%*?&).';
                                    }
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.key,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              // Re-enter password TextFormField
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Re-enter password is required';
                                    } else if (value != password) {
                                      return 'Password do not match';
                                    }
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: 'Re-enter password',
                                    prefixIcon: Icon(
                                      Icons.key,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              // Email TextFormField
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: _emailController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Email is required'),
                                    EmailValidator(
                                        errorText: 'Email is invalid')
                                  ]),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: 'Email',
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              //Phone-number TextFormField
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: _phoneController,
                                  validator: (value) {
                                    if (!value!.isValidPhone) {
                                      return 'Your phone number must contain 10 numbers only';
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: 'Phone number',
                                    prefixIcon: Icon(
                                      Icons.tablet_android,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              //Sign Up Button
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    child: Ink(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[850],
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Center(
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    onTap: (() async {
                                      if (formKey.currentState?.validate() ??
                                          false) {
                                        formKey.currentState?.save();
                                        try {
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: _emailController.text
                                                      .trim(),
                                                  password: _passwordController
                                                      .text
                                                      .trim());
                                          CollectionReference _collectionRef =
                                              FirebaseFirestore.instance
                                                  .collection('products');
                                          Future<void> getData() async {
                                            // Get docs from collection reference
                                            QuerySnapshot querySnapshot =
                                                await _collectionRef.get();

                                            // Get data from docs and convert map to List
                                            final allData = querySnapshot.docs
                                                .map((doc) => doc.data())
                                                .toList();

                                            for (int i = 0;
                                                i < allData.length;
                                                i++) {
                                              try {
                                                Map<String, dynamic> myMap =
                                                    allData.elementAt(i)
                                                        as Map<String, dynamic>;
                                                provider.addProduct(myMap);
                                              } catch (e) {
                                                print(e.toString());
                                              }
                                            }
                                          }

                                          String uid = FirebaseAuth
                                              .instance.currentUser!.uid;
                                          await _memberCollection.doc(uid).set({
                                            "username":
                                                _usernameController.text.trim(),
                                            "password":
                                                _passwordController.text.trim(),
                                            "email":
                                                _emailController.text.trim(),
                                            "phone":
                                                _phoneController.text.trim()
                                          }).then((value) {
                                            getData();
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SelectScreen();
                                            }));
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          String? message;
                                          if (e.code ==
                                              'email-already-in-use') {
                                            message = 'Email already in use!!';
                                          } else {
                                            message = e.message;
                                          }
                                          Fluttertoast.showToast(
                                              msg: message.toString(),
                                              gravity: ToastGravity.CENTER);
                                        }
                                      }
                                    }),
                                  )),

                              SizedBox(
                                height: 5,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an Account?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return SignInScreen();
                                      }));
                                    },
                                    child: Text(
                                      ' Sign In',
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
                    ),
                  );
                }));
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
