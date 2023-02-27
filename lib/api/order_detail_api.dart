import 'dart:developer';

import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/models/order_detail_model.dart';
import '/utils/request_type.dart';

class OrderDetailApi {
  final _rhino = RhinoClient();

  Future<dynamic> fetchOrderDetail(String orderCode) async {
    try {
      dynamic response = await _rhino.request(
        url: "${AppUrl.orderListUrl}$orderCode/",
        requestType: RequestType.getWithToken,
      );
      return OrderDetailModel.fromJson(response);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
