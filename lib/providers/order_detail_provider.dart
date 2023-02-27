import 'package:flutter/cupertino.dart';

import '/api/order_detail_api.dart';
import '/data/response/api_response.dart';
import '/models/order_detail_model.dart';

class OrderDetailProvider with ChangeNotifier {
  final _orderDetailApi = OrderDetailApi();

  ApiResponse<OrderDetailModel> orderDetail = ApiResponse.loading();

  setOrderDetail(ApiResponse<OrderDetailModel> response) {
    orderDetail = response;
    notifyListeners();
  }

  Future<void> fetchOrderDetail(String orderCode) async {
    setOrderDetail(ApiResponse.loading());
    await _orderDetailApi.fetchOrderDetail(orderCode).then((value) {
      setOrderDetail(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOrderDetail(ApiResponse.error(error.toString()));
    });
  }
}
