import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/customer/categoryscreen.dart';
import 'package:flutter_application_1/screens/customer/shopbagscreen.dart';
import 'package:flutter_application_1/screens/customer/homescreen.dart';
import 'package:flutter_application_1/screens/customer/profilescreen.dart';

class ControlConsumers extends StatefulWidget {
  @override
  State<ControlConsumers> createState() => _ControlConsumersState();
}

class _ControlConsumersState extends State<ControlConsumers> {
  int currentPageIndex = 0;

  final screen = [
    HomeScreen(),
    CategoryScreen(),
    ShopBagScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen[currentPageIndex],
        backgroundColor: Colors.white,
        bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
                indicatorColor: Colors.pink[300],
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

                  // Category
                  NavigationDestination(
                    icon: Icon(Icons.category_outlined, size: 30),
                    selectedIcon: Icon(
                      Icons.category,
                      size: 30,
                    ),
                    label: 'Category',
                  ),

                  // Shopping Bag
                  NavigationDestination(
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        size: 30,
                      ),
                      selectedIcon: Icon(Icons.shopping_bag, size: 30),
                      label: 'Shopping Bag'),

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
