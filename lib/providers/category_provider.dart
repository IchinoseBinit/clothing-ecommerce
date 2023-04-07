import 'package:clothing_ecommerce/api/category_list_api.dart';
import 'package:clothing_ecommerce/api/category_specific_products.dart';
import 'package:clothing_ecommerce/data/response/api_response.dart';
import 'package:clothing_ecommerce/models/category_model.dart';
import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final _categoryListApi = CategoryListApi();
  final _categorySpecificProductListApi = CategorySpecificProductsApi();
  ApiResponse<List<ProductModel>> categoryProductList = ApiResponse.loading();
  ApiResponse<List<CategoryModel>> categoryList = ApiResponse.loading();
  setCategoryList(ApiResponse<List<CategoryModel>> response) {
    categoryList = response;
    notifyListeners();
  }

  setCategorySpecificProducts(ApiResponse<List<ProductModel>> response,
      {bool noNotifier = false}) {
    categoryProductList = response;
    if (!noNotifier) notifyListeners();
  }

  Future<void> fetchCategoryList() async {
    await _categoryListApi.fetchCategoryListApi().then((value) {
      setCategoryList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCategoryList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchCategorySpecificProducts(int id) async {
    setCategorySpecificProducts(ApiResponse.loading(),noNotifier: true);
    await _categorySpecificProductListApi
        .fetchCategorySpecificProductsApi(id)
        .then((value) {
      setCategorySpecificProducts(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCategorySpecificProducts(ApiResponse.error(error.toString()));
    });
  }
}
