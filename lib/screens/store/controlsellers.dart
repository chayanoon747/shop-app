import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/store/homescreen.dart';
import 'package:flutter_application_1/screens/store/orderscreen.dart';
import 'package:flutter_application_1/screens/store/productscreen.dart';
import 'package:flutter_application_1/screens/store/profilescreen.dart';

class ControlSellers extends StatefulWidget {
  @override
  State<ControlSellers> createState() => _ControlSellersState();
}

class _ControlSellersState extends State<ControlSellers> {
  int currentPageIndex = 0;

  final screen = [
    HomeScreen(),
    OrderScreen(),
    ProductScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen[currentPageIndex],
        backgroundColor: Colors.white,
        bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
                indicatorColor: Color.fromARGB(255, 1, 230, 255),
                labelTextStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
            child: Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0,
                )
              ]),
              child: NavigationBar(
                height: 65,
                backgroundColor: Colors.white,
                destinations: [
                  // Home
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined, size: 30),
                    selectedIcon: Icon(Icons.home, size: 30),
                    label: 'Home',
                  ),

                  // Order
                  NavigationDestination(
                    icon: ImageIcon(
                      AssetImage('lib/icons/clipboard.png'),
                    ),
                    selectedIcon: ImageIcon(
                      AssetImage('lib/icons/clipboard_1.png'),
                    ),
                    label: 'Order',
                  ),

                  // Product
                  NavigationDestination(
                      icon: ImageIcon(
                        AssetImage('lib/icons/cubes.png'),
                      ),
                      selectedIcon: ImageIcon(
                        AssetImage('lib/icons/cubes_1.png'),
                      ),
                      label: 'Product'),

                  // Profile
                  NavigationDestination(
                      icon: Icon(Icons.person_outline, size: 30),
                      selectedIcon: Icon(Icons.person, size: 30),
                      label: 'Profile'),
                ],
                selectedIndex: currentPageIndex,
                onDestinationSelected: onDestination,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              ),
            )));
  }

  void onDestination(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }
}
