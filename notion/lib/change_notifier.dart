import 'package:flutter/material.dart';

class UIChangeNotifier extends ChangeNotifier {
  bool loading = true;

  void setLoading(bool loading) {
    this.loading = loading;
    notifyListeners();
  }
}
