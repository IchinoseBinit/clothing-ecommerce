import 'dart:developer';

import 'package:clothing_ecommerce/models/checkout_model.dart';
import 'package:clothing_ecommerce/models/product_model.dart';

import '/data/app_urls.dart';
import '/utils/request_type.dart';
import 'network/api_manager.dart';

class CheckoutApi {
  final _apiManager = ApiManager();

  Future<CheckoutModel> fetchCheckoutApi(dynamic body) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.checkoutUrl,
        requestType: RequestType.postWithToken,
        parameter: body
      );

      return CheckoutModel.fromJson(response);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
