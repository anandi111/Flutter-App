import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int counter = 0;

  increment() {
    counter++;
    notifyListeners();
  }

  decrement() {
    counter--;
    notifyListeners();
  }
}
