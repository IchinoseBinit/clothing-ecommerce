import 'package:clothing_ecommerce/api/product_list_api.dart';
import 'package:clothing_ecommerce/data/response/api_response.dart';
import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductListProvider extends ChangeNotifier {
  final _productListApi = ProductListApi();
  ApiResponse<List<ProductModel>> productList = ApiResponse.loading();
  setProductList(ApiResponse<List<ProductModel>> response,
      {bool noNotifier = false}) {
    productList = response;
    if (!noNotifier) notifyListeners();
  }

  Future<void> fetchProductList() async {
    setProductList(ApiResponse.loading(),noNotifier: true);
    await _productListApi.fectchProductListApi().then((value) {
      setProductList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProductList(ApiResponse.error(error.toString()));
    });
  }
}
