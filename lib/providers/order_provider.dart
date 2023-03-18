import 'package:clothing_ecommerce/api/cart_api.dart';
import 'package:clothing_ecommerce/api/order_provider.dart';
import 'package:clothing_ecommerce/models/cart_model.dart';
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

  // final _orderApi = OrderApi();
  // ApiResponse<List<CartModel>> cartItemList = ApiResponse.loading();
  // setCartItemList(ApiResponse<List<CartModel>> response) {
  //   cartItemList = response;
  //   notifyListeners();
  // }

  // Future<void> fetchCartItems() async {
  //   setCartItemList(ApiResponse.loading());
  //   await _productListApi.fetchViewCart().then((value) {
  //     setCartItemList(ApiResponse.completed(value));
  //     setTotalSelectedCart();
  //   }).onError((error, stackTrace) {
  //     setCartItemList(ApiResponse.error(error.toString()));
  //   });
  // }
}
