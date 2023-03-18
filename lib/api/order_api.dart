import 'dart:developer';
import 'package:clothing_ecommerce/api/network/api_manager.dart';
import 'package:clothing_ecommerce/data/app_urls.dart';
import 'package:clothing_ecommerce/models/order_model.dart';
import 'package:clothing_ecommerce/utils/request_type.dart';

class OrderApi {
  final ApiManager _apiManager = ApiManager();

  Future<dynamic> orderApi(dynamic data) async {
    try {
      dynamic response = await _apiManager.request(
          url: AppUrl.orderUrl,
          parameter: data,
          requestType: RequestType.postWithToken);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchViewOrderList() async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.orderListUrl,
        requestType: RequestType.getWithToken,
      );
      List<OrderModel> responseData = (response["data"] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();
      return responseData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
