import 'dart:developer';

import 'package:clothing_ecommerce/models/product_model.dart';

import '/data/app_urls.dart';
import '/utils/request_type.dart';
import 'network/api_manager.dart';

class CategorySpecificProductsApi {
  final _apiManager = ApiManager();

  Future<List<ProductModel>> fetchCategorySpecificProductsApi(int id) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.categorySpecificProductsUrl
            .replaceAll("name", id.toString()),
        requestType: RequestType.getWithToken,
      );
      List<ProductModel> responseData = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return responseData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
