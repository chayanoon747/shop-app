import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/provider/product.dart';

class ProductProvider with ChangeNotifier {
  List<Map<String, dynamic>> _products = [];

  Map<String, dynamic> getMapData(int index) {
    return _products[index];
  }

  void addProduct(Map<String, dynamic> mapPrd) {
    _products.add(mapPrd);
    notifyListeners();
  }

  void removeItem(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  void removeAllData() {
    _products.clear();
    notifyListeners();
  }

  int getNumProduct() {
    return _products.length;
  }
}
