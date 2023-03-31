import 'package:flutter/foundation.dart';

class CountProvider with ChangeNotifier {
  Map<String, dynamic> _counts = {};

  Map<String, dynamic> getMapData(int index) {
    return _counts[index];
  }

  void addData(String key, dynamic value) {
    _counts[key] = value;
    notifyListeners();
  }

  void removeData(String key) {
    _counts.remove(key);
    notifyListeners();
  }

  void removeAllData() {
    _counts.clear();
    notifyListeners();
  }
}
