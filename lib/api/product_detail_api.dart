import 'dart:developer';

import 'package:clothing_ecommerce/models/product_model.dart';

import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/utils/request_type.dart';

class ProductDetailApi {
  final _rhino = RhinoClient();

  Future<ProductModel> fetchProductApi(int productId) async {
    try {
      dynamic response = await _rhino.request(
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
