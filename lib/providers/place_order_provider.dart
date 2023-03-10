import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '/api/place_order_api.dart';
import '/data/app_urls.dart';
import '/data/response/api_response.dart';
import '/models/cart_price_model.dart';
import '/models/order_success_model.dart';
import '/providers/hive_database_helper.dart';
import '/screens/order/success_screen.dart';
import '/utils/navigation_util.dart';
import '/utils/show_toast.dart';

class PlaceOrderProvider with ChangeNotifier {
  final _orderApi = OrderApi();
  ApiResponse<OrderSuccessModel> firstPlaceOrderData = ApiResponse.loading();

  setOrder(ApiResponse<OrderSuccessModel> response) {
    firstPlaceOrderData = response;
    notifyListeners();
  }

  Future<bool> placeInitialOrder({
    required Map merchantData,
    required CartPriceModel cartPriceData,
    required String paymentExtension,
    required String notes,
    required String status,
    required String deliveryLocation,
    required String name,
    required String phoneNumber,
    required String email,
  }) async {
    setOrder(ApiResponse.loading());
    String latitude = await DatabaseHelper().getBoxItem(
      key: "latitude",
    );
    String longitude = await DatabaseHelper().getBoxItem(
      key: "longitude",
    );
    final body = {
      "items": cartPriceData.items
          .map((e) => {"id": e.id, "quantity": e.quantity})
          .toList(),
      "merchant_location": merchantData["locationId"],
      "delivery_type": cartPriceData.deliveryType,
      "latitude": double.parse(latitude),
      "longitude": double.parse(longitude),
      "customer_name": name,
      "customer_email": email,
      "customer_mobile": phoneNumber,
      "delivery_address": deliveryLocation,
      "delivery_time": DateTime.parse(
              "${(merchantData["timeslot"][0] as DateTime).toIso8601String().substring(0, 19)}${merchantData["timezone"]}")
          .toIso8601String(),
      "notes": notes == "" ? "" : notes,
      "payment_extension_setting": paymentExtension,
      "status": status,
      if (cartPriceData.couponCode != "")
        "coupon_code": cartPriceData.couponCode
    };
    return await _orderApi
        .placeOrderApi(body: body, url: AppUrl.placefirstOrderUrl)
        .then((value) {
      setOrder(ApiResponse.completed(value));
      return true;
    }).onError((error, stackTrace) {
      showToast(error.toString());
      setOrder(ApiResponse.error(error.toString()));
      return false;
    });
  }

  ApiResponse<dynamic> finalorderData = ApiResponse.loading();

  setFinalOrder(ApiResponse<dynamic> response) {
    finalorderData = response;
    notifyListeners();
  }

  Future<void> placeFinalOrder(
    context, {
    required CartPriceModel cartPriceData,
    required String paymentExtensionCode,
    required String paymentExtensionTxnCode,
    required String status,
    required String merchantLocation,
  }) async {
    setFinalOrder(ApiResponse.loading());
    final body = {
      "order_code": firstPlaceOrderData.data!.orderCode,
      "payment_extension_code": paymentExtensionCode,
      "status": status,
      "paid_amount": firstPlaceOrderData.data!.grandTotal,
      "payment_extension_txn_code": paymentExtensionTxnCode,
      if (cartPriceData.couponCode != "")
        "coupon_code": cartPriceData.couponCode
    };
    await _orderApi
        .placeOrderApi(body: body, url: AppUrl.placefinalOrderUrl)
        .then((value) async {
      navigate(context, const SuccessScreen());
      Map databaseData = await DatabaseHelper().getBoxItem(key: "cart");
      log(databaseData.toString(), name: "place success order");

      databaseData.remove(int.parse(merchantLocation));
      log(databaseData.toString());
      if (databaseData == {}) {
        DatabaseHelper().deleteBoxItem(key: "cart");
      } else {
        await DatabaseHelper().addBoxItem(key: "cart", value: databaseData);
      }
      // setOrder(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      showToast(error.toString());
      setOrder(ApiResponse.error(error.toString()));
    });
  }
}
