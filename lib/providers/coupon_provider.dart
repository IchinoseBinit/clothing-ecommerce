import 'package:flutter/cupertino.dart';

import '/api/coupon_api.dart';
import '/data/response/api_response.dart';
import '/models/coupon.dart';

class CouponProvider with ChangeNotifier {
  final _couponApi = CouponApi();

  ApiResponse<List<Coupon>> couponData = ApiResponse.loading();
  String selectedCoupon = "";
  setCoupon(String code, {bool noNotifier = false}) {
    selectedCoupon = code;
    if (!noNotifier) notifyListeners();
  }

  setCouponList(ApiResponse<List<Coupon>> response) {
    couponData = response;
    notifyListeners();
  }

  Future<void> fetchCoupon(int merchantId) async {
    setCouponList(ApiResponse.loading());
    await _couponApi.fetchCouponApi(merchantId).then((value) {
      late List<Coupon> data;
      if ((value as List).isNotEmpty) {
        data = value
            .map(
              (e) => Coupon.fromJson(e),
            )
            .toList();
      } else {
        data = [];
      }
      setCouponList(ApiResponse.completed(data));
    }).onError((error, stackTrace) {
      setCouponList(ApiResponse.error(error.toString()));
    });
  }
}
