import 'dart:developer';

import 'package:clothing_ecommerce/models/product_model.dart';

import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/utils/request_type.dart';

class ProductSearchApi {
  final _rhino = RhinoClient();

  Future<List<ProductModel>> fetchSearchProductApi(String query) async {
    try {
      dynamic response = await _rhino.request(
        url: AppUrl.productSearchUrl.replaceAll("name", query),
        requestType: RequestType.getWithToken,
      );
      List<ProductModel> responseData = (response["data"] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return responseData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
