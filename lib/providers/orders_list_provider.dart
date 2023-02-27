import 'package:flutter/cupertino.dart';

import '/api/orders_list_api.dart';
import '/data/response/api_response.dart';
import '/models/order_list_model.dart';
import '/utils/order_list_type.dart';

class OrderListProvider with ChangeNotifier {
  final _orderListApi = OrderListApi();

  ApiResponse<OrderListModel> orderList = ApiResponse.loading();

  setOrderList(ApiResponse<OrderListModel> response) {
    orderList = response;
    notifyListeners();
  }

  Future<void> fetchOrderList({required OrderListType orderListType}) async {
    setOrderList(ApiResponse.loading());
    await _orderListApi
        .fetchOrderList(orderListType: orderListType)
        .then((value) {
      setOrderList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOrderList(ApiResponse.error(error.toString()));
    });
  }
}
