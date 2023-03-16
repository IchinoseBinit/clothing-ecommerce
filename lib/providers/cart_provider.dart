import 'package:clothing_ecommerce/api/cart_api.dart';
import 'package:clothing_ecommerce/data/response/api_response.dart';
import 'package:clothing_ecommerce/models/cart_model.dart';
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

  final _productListApi = CartApi();
  ApiResponse<List<CartModel>> cartItemList = ApiResponse.loading();
  setCartItemList(ApiResponse<List<CartModel>> response) {
    cartItemList = response;
    notifyListeners();
  }

  increaseCartItemQuantity(index) {
    cartItemList.data![index].product.increaseQuantity();
    notifyListeners();
  }

  decreaseCartItemQuantity(index) {
    if (cartItemList.data![index].product.quantity > 1) {
      cartItemList.data![index].product.decreaseQuantity();
      notifyListeners();
    }
  }

  Future<void> fetchCartItems() async {
    setCartItemList(ApiResponse.loading());
    await _productListApi.fetchViewCart().then((value) {
      setCartItemList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCartItemList(ApiResponse.error(error.toString()));
    });
  }
}
