import 'dart:developer';

import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/utils/request_type.dart';

class CouponApi {
  final _rhino = RhinoClient();

  Future<dynamic> fetchCouponApi(int merchantId) async {
    try {
      dynamic response = await _rhino.request(
        url: AppUrl.couponUrl.replaceAll("name", merchantId.toString()),
        requestType: RequestType.get,
      );
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
