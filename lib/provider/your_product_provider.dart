import 'package:flutter/foundation.dart';

class YourProductProvider with ChangeNotifier {
  List<Map<String, dynamic>> _yourProducts = [];

  Map<String, dynamic> getMapData(int index) {
    return _yourProducts[index];
  }

  void addProduct(Map<String, dynamic> mapPrd) {
    _yourProducts.add(mapPrd);
    notifyListeners();
  }

  void removeItem(int index) {
    _yourProducts.removeAt(index);
    notifyListeners();
  }

  void removeAllData() {
    _yourProducts.clear();
    notifyListeners();
  }

  int getNumProduct() {
    return _yourProducts.length;
  }
}
