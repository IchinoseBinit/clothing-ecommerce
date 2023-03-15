import 'dart:developer';

import 'package:clothing_ecommerce/api/network/api_manager.dart';
import 'package:clothing_ecommerce/data/app_urls.dart';
import 'package:clothing_ecommerce/models/cart_model.dart';
import 'package:clothing_ecommerce/utils/request_type.dart';

class CartApi {
  final ApiManager _apiManager = ApiManager();

  Future<dynamic> addToCartApi(dynamic data) async {
    try {
      dynamic response = await _apiManager.request(
          url: AppUrl.addToCartUrl,
          parameter: data,
          requestType: RequestType.postWithToken);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CartModel>> fetchViewCart() async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.viewCartUrl,
        requestType: RequestType.getWithToken,
      );
      List<CartModel> responseData =
          (response["data"] as List).map((e) => CartModel.fromJson(e)).toList();
      return responseData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
