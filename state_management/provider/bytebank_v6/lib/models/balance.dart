import 'package:flutter/material.dart';

class Balance extends ChangeNotifier {
  double balanceValue;

  Balance(this.balanceValue);

  void add(double value) {
    balanceValue += value;
    notifyListeners();
  }

  void remove(double value) {
    balanceValue -= value;
    notifyListeners();
  }

  @override
  String toString() {
    return 'R\$ $balanceValue';
  }
}
