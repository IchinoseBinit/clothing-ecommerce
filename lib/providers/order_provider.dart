import 'package:clothing_ecommerce/api/order_api.dart';
import 'package:clothing_ecommerce/data/response/api_response.dart';
import 'package:clothing_ecommerce/models/cart_model.dart';
import 'package:clothing_ecommerce/models/order_model.dart';
import 'package:clothing_ecommerce/utils/show_toast.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  final _myRepo = OrderApi();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> order(BuildContext context,
      {required List<CartModel> cartList}) async {
    setLoading(true);

    Map body = {
      'quantity': cartList.first.quantity,
      'product': cartList.first.product.id,
      "size": "XL",
      "color": "#FF125175"
    };
    _myRepo.orderApi(body).then((value) async {
      setLoading(false);
      showToast(value["message"]);
    }).onError((error, stackTrace) {
      setLoading(false);
      showToast(error.toString());
    });
  }

  ApiResponse<List<OrderModel>> orderList = ApiResponse.loading();
  setOrderList(ApiResponse<List<OrderModel>> response) {
    orderList = response;
    notifyListeners();
  }

  Future<void> fetchOrderList() async {
    setOrderList(ApiResponse.loading());
    await _myRepo.fetchViewOrderList().then((value) {
      setOrderList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOrderList(ApiResponse.error(error.toString()));
    });
  }
}
