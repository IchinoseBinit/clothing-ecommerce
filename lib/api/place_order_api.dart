import 'dart:developer';

import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/models/order_success_model.dart';
import '/utils/request_type.dart';

class OrderApi {
  final _rhino = RhinoClient();

  Future<dynamic> placeOrderApi(
      {required Map body, required String url}) async {
    try {
      dynamic response = await _rhino.request(
        url: url,
        requestType: RequestType.postWithToken,
        parameter: body,
      );
      return url == AppUrl.placefinalOrderUrl
          ? response
          : OrderSuccessModel.fromJson(response);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
