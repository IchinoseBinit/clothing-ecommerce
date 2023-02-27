import 'dart:developer';

import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/models/cart_price_model.dart';
import '/utils/request_type.dart';

class CartPriceApi {
  final _rhino = RhinoClient();

  Future<CartPriceModel> fetchCartPrice(Map body) async {
    try {
      dynamic response = await _rhino.request(
        url: AppUrl.cartPriceUrl,
        requestType: RequestType.postWithToken,
        parameter: body,
      );
      return CartPriceModel.fromJson(response);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
