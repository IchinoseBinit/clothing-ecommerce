import 'package:clothing_ecommerce/api/checkout_api.dart';
import 'package:clothing_ecommerce/models/cart_model.dart';
import 'package:clothing_ecommerce/models/checkout_model.dart';
import 'package:flutter/material.dart';

import '../data/response/api_response.dart';

class CheckoutProvider extends ChangeNotifier {
  final _checkoutApi = CheckoutApi();
  ApiResponse<CheckoutModel> checkoutData = ApiResponse.loading();

  setCheckout(ApiResponse<CheckoutModel> response, {bool noNotifier = false}) {
    checkoutData = response;
    if (!noNotifier) notifyListeners();
  }

  Future<void> fetchCheckout(
    BuildContext context, {
    required List<CartModel> cartList,
  }) async {
    setCheckout(ApiResponse.loading(), noNotifier: true);
    List<Map> bodyList = cartList
        .map((e) => {
              'quantity': e.quantity,
              'product_id': e.product.id,
              "size_id": e.quantity,
              "color_id": e.color.id
            })
        .toList();
    await _checkoutApi.fetchCheckoutApi(bodyList).then((value) {
      setCheckout(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCheckout(ApiResponse.error(error.toString()));
    });
  }
}
