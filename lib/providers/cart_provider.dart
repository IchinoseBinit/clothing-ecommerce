import 'package:clothing_ecommerce/api/add_to_cart_api.dart';
import 'package:clothing_ecommerce/utils/show_toast.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final _myRepo = CartApi();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addToCart(
    BuildContext context, {
    required int quantity,
    required int productId,
  }) async {
    setLoading(true);

    Map body = {
      'quantity': quantity,
      'product': productId,
    };
    _myRepo.addToCartApi(body).then((value) async {
      setLoading(false);
      showToast(value["message"]);
    }).onError((error, stackTrace) {
      setLoading(false);
      showToast(error.toString());
    });
  }
}
