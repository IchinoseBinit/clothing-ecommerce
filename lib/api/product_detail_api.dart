import 'dart:developer';

import 'package:clothing_ecommerce/models/product_model.dart';

import 'network/api_manager.dart';
import '/data/app_urls.dart';
import '/utils/request_type.dart';

class ProductDetailApi {
  final _apiManager = ApiManager();

   Future<dynamic> verifyStockApi(dynamic data) async {
    try {
      dynamic response = await _apiManager.request(
          url: AppUrl.verifyStockUrl, parameter: data, requestType: RequestType.postWithToken);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> fetchProductApi(int productId) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.productDetailUrl.replaceAll("name", productId.toString()),
        requestType: RequestType.getWithToken,
      );
      return ProductModel.fromJson(response["data"]);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
