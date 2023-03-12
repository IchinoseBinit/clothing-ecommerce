import 'dart:developer';

import 'package:clothing_ecommerce/models/product_model.dart';

import 'network/api_manager.dart';
import '/data/app_urls.dart';
import '/utils/request_type.dart';

class ProductListApi {
  final _rhino = ApiManager();

  Future<List<ProductModel>> fectchProductListApi() async {
    try {
      dynamic response = await _rhino.request(
        url: AppUrl.productListUrl,
        requestType: RequestType.getWithToken,
      );
      List<ProductModel> responseData =
          (response as List).map((e) => ProductModel.fromJson(e)).toList();
      return responseData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
