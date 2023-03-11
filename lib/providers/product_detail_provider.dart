import 'package:clothing_ecommerce/api/product_detail_api.dart';
import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

import '../data/response/api_response.dart';

class ProductDetailProvider extends ChangeNotifier {
  final _productListApi = ProductDetailApi();
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

  ApiResponse<ProductModel> productData = ApiResponse.loading();
  setProduct(ApiResponse<ProductModel> response) {
    productData = response;
    notifyListeners();
  }

  Future<void> fetchProduct(int productId) async {
    setProduct(ApiResponse.loading());
    await _productListApi.fetchProductApi(productId).then((value) {
      setProduct(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProduct(ApiResponse.error(error.toString()));
    });
  }
}
