import 'dart:developer';
import 'package:clothing_ecommerce/models/category_model.dart';
import 'network/api_manager.dart';
import '/data/app_urls.dart';
import '/utils/request_type.dart';

class CategoryListApi {
  final _apiManager = ApiManager();

  Future<List<CategoryModel>> fetchCategoryListApi() async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.categoryListUrl,
        requestType: RequestType.getWithToken,
      );
      List<CategoryModel> responseData =
          (response as List).map((e) => CategoryModel.fromJson(e)).toList();
      return responseData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
