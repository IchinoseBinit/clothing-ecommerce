import 'package:flutter/material.dart';

class ProductDetailProvider extends ChangeNotifier {
  int selectedColorIndex = 0;
  int selectedSizeIndex = 0;
  int selectedQuantity = 1;

  setSelectedColorIndex(int index) {
    selectedColorIndex = index;
    notifyListeners();
  }

  setSelectedSizeIndex(int index) {
    selectedSizeIndex = index;
    notifyListeners();
  }

  onIncrement() {
    selectedQuantity++;
    notifyListeners();
  }

  onDecrement() {
    if (selectedQuantity > 1) {
      selectedQuantity--;
    }
    notifyListeners();
  }
}
