import 'dart:developer';

import 'network/api_manager.dart';
import '/data/app_urls.dart';
import '/models/payment_gateway_model.dart';
import '/utils/request_type.dart';

class PaymentGatewayApi {
  final _rhino = ApiManager();

  Future<dynamic> fetchPaymentGateway(Map body,
      {required int merchantId}) async {
    try {
      dynamic response = await _rhino.request(
        url: AppUrl.paymentGetwayUrl.replaceAll("name", merchantId.toString()),
        requestType: RequestType.post,
        parameter: body,
      );

      List<PaymentGateway> value =
          (response as List).map((e) => PaymentGateway.fromJson(e)).toList();
      return value;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
