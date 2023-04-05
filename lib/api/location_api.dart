import 'dart:developer';
import 'package:clothing_ecommerce/models/location_model.dart';
import 'network/api_manager.dart';
import '/data/app_urls.dart';
import '/utils/request_type.dart';

class LocationApi {
  final _apiManager = ApiManager();

  Future<List<LocationModel>> fetchLocationListApi() async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.locationListUrl,
        requestType: RequestType.getWithToken,
      );
      List<LocationModel> responseData = (response["data"] as List)
          .map((e) => LocationModel.fromJson(e))
          .toList();
      return responseData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<dynamic> addToCartApi(dynamic data) async {
    try {
      dynamic response = await _apiManager.request(
          url: AppUrl.addToCartUrl,
          parameter: data,
          requestType: RequestType.postWithToken);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addAddressApi(Map body) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.addLocationUrl,
        requestType: RequestType.postWithToken,
        parameter: body
      );
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
