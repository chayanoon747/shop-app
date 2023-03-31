import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/provider/your_product_provider.dart';
import 'package:flutter_application_1/screens/store/controlsellers.dart';
import 'package:flutter_application_1/screens/store/productscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  CollectionReference _productCollection =
      FirebaseFirestore.instance.collection("products");
  CollectionReference _storeCollection =
      FirebaseFirestore.instance.collection("stores");
  final formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _priceController = TextEditingController();

  final _quantityController = TextEditingController();

  String imageUrl = '';
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth? auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? uid = user?.uid;
    ProductProvider provider1 = Provider.of<ProductProvider>(context);
    YourProductProvider provider2 = Provider.of<YourProductProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) {
              return ControlSellers();
            }));
          },
          icon: Icon(
            Icons.cancel_outlined,
            size: 30,
            color: Colors.red,
          ),
          label: Text('Cancel'),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Form Add Product',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Name Product   ',
                        style: TextStyle(fontSize: 17),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey.shade600),
                                    borderRadius: BorderRadius.circular(15)),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(15)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Description   ',
                        style: TextStyle(fontSize: 17),
                      ),
                      Expanded(
                        child: Container(
                          height: 135,
                          child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey.shade600),
                                    borderRadius: BorderRadius.circular(15)),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(15)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Price of Product   ',
                        style: TextStyle(fontSize: 17),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey.shade600),
                                    borderRadius: BorderRadius.circular(15)),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(15)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Quantity   ',
                        style: TextStyle(fontSize: 17),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey.shade600),
                                    borderRadius: BorderRadius.circular(15)),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(15)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                    child: Column(children: [
                  Text(
                    'Category',
                    style: TextStyle(fontSize: 17),
                  ),
                  CheckboxListTile(
                    title: Text('Beauty'),
                    value: _isChecked1,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked1 = newValue!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Clothes'),
                    value: _isChecked2,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked2 = newValue!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Electrical Machines'),
                    value: _isChecked3,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked3 = newValue!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Other'),
                    value: _isChecked4,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked4 = newValue!;
                      });
                    },
                  ),
                ])),

                SizedBox(
                  height: 70,
                  width: 70,
                  child: TextButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        imageUrl = '${file?.path}';
                        //debugPrint('${file?.path}');
                        if (file == null) {
                          return;
                        }
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);
                        try {
                          await referenceImageToUpload.putFile(File(file.path));
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } on FirebaseException catch (e) {}
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFE3E3E3),
                          shape: RoundedRectangleBorder(
                              borderRadius: (BorderRadius.circular(50)),
                              side: BorderSide(color: Colors.white))),
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 40,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Add image for product'),
                SizedBox(
                  height: 20,
                ),

                // Button Add Product
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: InkWell(
                    child: Ink(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Add Product',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: (() async {
                      List<String> selectedOptions = [];
                      if (_isChecked1) {
                        selectedOptions.add('Beauty');
                      }
                      if (_isChecked2) {
                        selectedOptions.add('Clothes');
                      }
                      if (_isChecked3) {
                        selectedOptions.add('Electrical Machines');
                      }
                      if (_isChecked4) {
                        selectedOptions.add('Other');
                      }

                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      String product_id = 'P${uniqueFileName}';
                      //await _storeCollection.doc(uid).
                      await _productCollection.doc(product_id).set({
                        "uid": uid,
                        "product_id": product_id,
                        "name": _nameController.text,
                        "description": _descriptionController.text,
                        "price": _priceController.text,
                        "quantity": _quantityController.text,
                        "category": selectedOptions.toString(),
                        "url": imageUrl
                      }).then((value) async {
                        await _storeCollection
                            .doc(uid)
                            .update({"product_id": product_id});
                        Map<String, dynamic> mapPrd = {
                          'uid': uid,
                          "quantity": _quantityController.text,
                          "price": _priceController.text,
                          "product_id": product_id,
                          "name": _nameController.text,
                          "description": _descriptionController.text,
                          "category": selectedOptions.toString(),
                          "url": imageUrl
                        };
                        provider1.addProduct(mapPrd);
                        provider2.addProduct(mapPrd);

                        _nameController.clear();
                        _descriptionController.clear();
                        _priceController.clear();
                        _quantityController.clear();
                        imageUrl = '';

                        Navigator.pop(context,
                            MaterialPageRoute(builder: (context) {
                          return ProductScreen();
                        }));
                      });
                    }),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
