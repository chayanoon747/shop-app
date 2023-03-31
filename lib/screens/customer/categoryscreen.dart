import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screens/customer/favoritescreen.dart';
import 'package:flutter_application_1/screens/customer/signinscreen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  Icon _iconFav = Icon(Icons.favorite_outline);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(
              height: 45,
              width: 300,
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
                    _iconFav = Icon(Icons.favorite);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FavoriteScreen();
                    }));
                  });
                },
                icon: _iconFav,
                color: Colors.pink[300],
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(padding: EdgeInsets.only(left: 20), children: [
        SizedBox(
          height: 15,
        ),
        Text(
          'Categories',
          style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.grey[350],
            isScrollable: true,
            labelPadding: EdgeInsets.only(right: 45),
            tabs: [
              Tab(
                child: Text(
                  'All Products',
                  style: TextStyle(fontSize: 21),
                ),
              ),
              Tab(
                child: Text(
                  'Beauty',
                  style: TextStyle(fontSize: 21),
                ),
              ),
              Tab(
                child: Text(
                  'Clothes',
                  style: TextStyle(fontSize: 21),
                ),
              ),
              Tab(
                child: Text(
                  'Electrical Machines',
                  style: TextStyle(fontSize: 21),
                ),
              ),
              Tab(
                child: Text(
                  'Other',
                  style: TextStyle(fontSize: 21),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
