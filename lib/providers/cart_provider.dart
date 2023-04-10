import 'dart:developer';

import 'package:clothing_ecommerce/api/cart_api.dart';
import 'package:clothing_ecommerce/data/response/api_response.dart';
import 'package:clothing_ecommerce/models/cart_model.dart';
import 'package:clothing_ecommerce/providers/product_detail_provider.dart';
import 'package:clothing_ecommerce/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final _myRepo = CartApi();
  bool _loading = false;
  bool get loading => _loading;

  late int _totalSelectedCart = 0;
  get totalSelectedCart => _totalSelectedCart;

  List<CartModel> _selectCartItemList = [];
  get selectCartItemList => _selectCartItemList;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setTotalSelectedCount() {
    _selectCartItemList =
        cartItemList.data!.where((e) => e.isSelected).toList();
    if (_selectCartItemList.isNotEmpty) {
      _totalSelectedCart =
          _selectCartItemList.map((e) => e.quantity).reduce((p, n) => p + n);
    } else {
      _totalSelectedCart = 0;
    }
  }

  selectAllCartItem(bool val) {
    _totalSelectedCart = cartItemList.data!
        .map((e) => e.quantity)
        .toList()
        .reduce((value, element) => _totalSelectedCart = value + element);
    for (CartModel cartItem in cartItemList.data!) {
      cartItem.setSelectedCart(value: val);
    }
    notifyListeners();
  }

  Future<void> addToCart(
    BuildContext context, {
    required int quantity,
    required int size,
    required int color,
    required int productId,
  }) async {
    setLoading(true);

    Map body = {
      'quantity': quantity,
      'product': productId,
      'size': size,
      'color': color,
    };
    if (Provider.of<ProductDetailProvider>(context, listen: false).isActive) {
      _myRepo.addToCartApi(body).then((value) async {
        setLoading(false);
        showToast(value["message"]);
      }).onError((error, stackTrace) {
        setLoading(false);
        showToast(error.toString());
      });
    } else {
      showToast("This item is out of stock. Please try another variation.");
      setLoading(false);
    }
  }

  final _productListApi = CartApi();
  ApiResponse<List<CartModel>> cartItemList = ApiResponse.loading();

  setCartItemList(ApiResponse<List<CartModel>> response,
      {bool noNotifier = false}) {
    cartItemList = response;
    if (!noNotifier) notifyListeners();
  }

  increaseCartItemQuantity(index) {
    cartItemList.data![index].increaseQuantity();
    setTotalSelectedCount();
    notifyListeners();
  }

  deleteProduct(index) {
    cartItemList.data!.removeAt(index);
    setTotalSelectedCount();
    notifyListeners();
  }

  selectedSingleCartItem(index) {
    cartItemList.data![index].setSelectedCart();
    setTotalSelectedCount();
    notifyListeners();
  }

  decreaseCartItemQuantity(index) {
    if (cartItemList.data![index].quantity > 1) {
      cartItemList.data![index].decreaseQuantity();
      setTotalSelectedCount();
      notifyListeners();
    }
  }

  Future<void> fetchCartItems() async {
    setCartItemList(ApiResponse.loading(), noNotifier: true);
    await _productListApi.fetchViewCart().then((value) {
      setCartItemList(ApiResponse.completed(value));
      setTotalSelectedCount();
    }).onError((error, stackTrace) {
      setCartItemList(ApiResponse.error(error.toString()));
    });
  }
}
