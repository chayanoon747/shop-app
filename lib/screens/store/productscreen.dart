import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/provider/your_product_provider.dart';
import 'package:flutter_application_1/screens/store/addproductscreen.dart';
import 'package:flutter_application_1/screens/store/controlsellers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  String imageUrl = 'null';
  String productId = '';
  @override
  Widget build(BuildContext context) {
    FirebaseAuth? auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? uid = user?.uid;
    ProductProvider provider1 = Provider.of<ProductProvider>(context);
    YourProductProvider provider2 = Provider.of<YourProductProvider>(context);
    print(provider1.getNumProduct());
    print(provider2.getNumProduct());

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Product',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        floatingActionButton: FloatingActionButton.extended(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddProductScreen();
            }));
          },
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          icon: Icon(Icons.add),
          label: Text('Add Products'),
        ),
        body: ListView.builder(
            itemCount: provider2.getNumProduct(),
            itemBuilder: (context, index) {
              return ListTile(
                  title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.purple[400],
                      borderRadius: BorderRadius.circular(10)),
                  height: 165,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ProductID : ${provider2.getMapData(index)['product_id']}",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          "Name : ${provider2.getMapData(index)['name']}",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          "Description : ${provider2.getMapData(index)['description']}",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          "Category : ${provider2.getMapData(index)['category']}",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          "Price : ${provider2.getMapData(index)['price']}",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          "Quantity : ${provider2.getMapData(index)['quantity']}",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            }));
  }

  String removeBrackets(String str) {
    return str.replaceAll('[', '').replaceAll(']', '');
  }
}
