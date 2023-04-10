import 'package:clothing_ecommerce/api/product_detail_api.dart';
import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:clothing_ecommerce/utils/show_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/response/api_response.dart';

class ProductDetailProvider extends ChangeNotifier {
  final _productListApi = ProductDetailApi();
  int selectedColorIndex = -1;
  int selectedSizeIndex = -1;
  int selectedQuantity = 1;
  bool isActive = false;

  setSelectedColorIndex(int index) {
    selectedColorIndex = index;
    if (selectedColorIndex != -1 && selectedSizeIndex != -1) {
      verifyStock(
          resetData: true,
          productId: productData.data!.id,
          sizeId: productData.data!.size[selectedColorIndex].id,
          colorId: productData.data!.color[selectedColorIndex].id);
    }
    notifyListeners();
  }

  setSelectedSizeIndex(int index) {
    selectedSizeIndex = index;
    if (selectedColorIndex != -1 && selectedSizeIndex != -1) {
      verifyStock(
          resetData: true,
          productId: productData.data!.id,
          sizeId: productData.data!.size[selectedColorIndex].id,
          colorId: productData.data!.color[selectedColorIndex].id);
    }
    notifyListeners();
  }

  onIncrement() {
    selectedQuantity++;
    notifyListeners();
  }

  onDecrement() {
    if (selectedQuantity > 1) {
      selectedQuantity--;
    }
    notifyListeners();
  }

  resetData() {
    selectedColorIndex = -1;
    selectedSizeIndex = -1;
    selectedQuantity = 1;
    isActive = false;
    selectedQuantity = 1;
  }

  ApiResponse<ProductModel> productData = ApiResponse.loading();
  setProduct(ApiResponse<ProductModel> response) {
    productData = response;
    notifyListeners();
  }

  Future<void> fetchProduct(int productId) async {
    resetData();
    setProduct(ApiResponse.loading());
    await _productListApi.fetchProductApi(productId).then((value) {
      setProduct(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProduct(ApiResponse.error(error.toString()));
    });
  }

  bool _loading = false;
  bool get loading => _loading;

  setVerifyStockLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> verifyStock(
      {required int productId,
      required int sizeId,
      required int colorId,
      bool resetData = false}) async {
    setVerifyStockLoading(true);
    final data = {
      "size": sizeId,
      "color": colorId,
      "product": productId,
    };
    await _productListApi.verifyStockApi(data).then((value) {
      Fluttertoast.cancel();
      if (resetData) {
        isActive = true;
        selectedQuantity = 1;
      }
      setVerifyStockLoading(false);
    }).onError((error, stackTrace) {
      if (resetData) {
        isActive = false;
        selectedQuantity = 1;
      }
      setVerifyStockLoading(false);
      Fluttertoast.cancel();
      showToast("This item is out of stock. Please try another variation.");
    });
  }
}
