import 'package:clothing_ecommerce/api/product_search_api.dart';
import 'package:clothing_ecommerce/data/response/api_response.dart';
import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductSearchProvider extends ChangeNotifier {
  bool showClearButton = false;
  final _productListApi = ProductSearchApi();
  ApiResponse<List<ProductModel>> productSearchList =
      ApiResponse.error("Please type something...");
  setProductList(ApiResponse<List<ProductModel>> response) {
    productSearchList = response;
    notifyListeners();
  }

  setShowClearButton(bool val) {
    showClearButton = val;
    notifyListeners();
  }

  Future<void> fetchSearchProductList(String query) async {
    setProductList(ApiResponse.loading());
    if (query.isEmpty) {
      setProductList(ApiResponse.error("Item not found"));
    } else {
      await _productListApi.fetchSearchProductApi(query).then((value) {
        setProductList(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        setProductList(
            ApiResponse.error("Item not found. Please try another item."));
      });
    }
  }
}
