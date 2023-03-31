import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/provider/your_product_provider.dart';
import 'package:flutter_application_1/screens/customer/signinscreen.dart';
import 'package:flutter_application_1/screens/store/profile/myaccountscreen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        titleTextStyle: TextStyle(
            fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black),
        elevation: 5,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Consumer2<ProductProvider, YourProductProvider>(
        builder: (context, ProductProvider provider1,
            YourProductProvider provider2, child) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                ),

                //Avatar Profile
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(
                          width: 5, color: Colors.lightBlue.shade200)),
                  height: 140,
                  width: 140,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('lib/icons/user.png'),
                        backgroundColor: Colors.white,
                      ),
                      Positioned(
                        bottom: 0,
                        right: -10,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFFE3E3E3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: (BorderRadius.circular(50)),
                                      side: BorderSide(color: Colors.white))),
                              child: Icon(Icons.camera_alt_outlined)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // TextButton Order
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[850],
                          foregroundColor: Colors.white),
                      onPressed: () {},
                      child: Row(children: [
                        ImageIcon(AssetImage('lib/icons/box.png')),
                        Expanded(child: Text('  My Order')),
                        Icon(Icons.arrow_forward),
                      ])),
                ),

                // TextButton Account
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[850],
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MyAccountScreen();
                        }));
                      },
                      child: Row(children: [
                        Icon(Icons.person_outline),
                        Expanded(child: Text('  My Account')),
                        Icon(Icons.arrow_forward)
                      ])),
                ),

                SizedBox(
                  height: 20,
                ),

                // Button Sign Out
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: InkWell(
                      child: Ink(
                        padding: EdgeInsets.all(17),
                        decoration: BoxDecoration(
                            color: Colors.red[700],
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            'Sign Out',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: (() {
                        FirebaseAuth.instance.signOut().then((value) {
                          provider1.removeAllData();
                          provider2.removeAllData();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignInScreen();
                          }));
                        });
                      }),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
