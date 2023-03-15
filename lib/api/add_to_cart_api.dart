import 'package:clothing_ecommerce/api/network/api_manager.dart';
import 'package:clothing_ecommerce/data/app_urls.dart';
import 'package:clothing_ecommerce/utils/request_type.dart';

class CartApi {
  final ApiManager _apiManager = ApiManager();

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
}
