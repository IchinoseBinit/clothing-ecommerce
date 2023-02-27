import 'dart:developer';

import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/models/category_model.dart';
import '/models/merchant_item_model.dart' as item;
import '/models/merchant_model.dart';
import '/utils/request_type.dart';

class MerchantListApi {
  final _rhino = RhinoClient();

  Future<MerchantModel> fetchMerchantList(
      {String? latitude, String? longitude, String? merchantName}) async {
    try {
      String url = merchantName != null
          ? "${AppUrl.merchantListUrl}"
              "?diameter=40&latitude=$latitude&longitude=$longitude&q=$merchantName"
          : "${AppUrl.merchantListUrl}"
              "?diameter=40&latitude=$latitude&longitude=$longitude";

      dynamic response =
          await _rhino.request(url: url, requestType: RequestType.get);

      // dynamic response = await _rhino
      //     .getGetPostApiResponseNotToken("${AppUrl.merchantListEndPoint}"
      //         "?latitude=$latitude&longitude=$longitude");
      return response = MerchantModel.fromJson(response);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<item.CategoryGroup>> fetchMerchantItemList(
      {required int locationCode, required String deliveryType}) async {
    try {
      dynamic response = await _rhino.request(
          url:
              '${AppUrl.merchantItemListUrl}$locationCode/?service_available_for=$deliveryType',
          requestType: RequestType.get);
      List<item.CategoryGroup> responseList = (response as List)
          .map(
            (e) => item.CategoryGroup.fromJson(e),
          )
          .toList();
      return responseList;
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoryModel> fetchCategoryList(
      {String? domain, required String deliveryType}) async {
    try {
      dynamic response = await _rhino.request(
          url: '${AppUrl.categoryItemListUrl}'
              '?merchant_domain=$domain&service_available_for=$deliveryType',
          requestType: RequestType.get);
      return response = CategoryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> setFavouriteRestaurantApi(int locationId) async {
    try {
      dynamic response = await _rhino.request(
          url: AppUrl.setFavouriteRestaurantUrl
              .replaceAll("name", locationId.toString()),
          requestType: RequestType.postWithToken);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<MerchantModel> fetchFavouriteMerchantList() async {
    try {
      dynamic response = await _rhino.request(
          url: AppUrl.favouriteRestaurantListUrl,
          requestType: RequestType.getWithToken);
      return MerchantModel.fromJson(response);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
