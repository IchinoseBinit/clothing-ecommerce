import 'dart:developer';

import '/data/app_urls.dart';
import '/utils/request_type.dart';
import 'network/api_manager.dart';

class AuthApi {
  final ApiManager _apiManager = ApiManager();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiManager.request(
          url: AppUrl.loginUrl, parameter: data, requestType: RequestType.post);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerApi(Map<String, dynamic> data) async {
    try {
      dynamic response = await _apiManager.request(
          url: AppUrl.registerApiUrl,
          parameter: data,
          requestType: RequestType.post);
      log(data.toString(), name: "Sign Up Data");
      return response;
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  Future<dynamic> changePasswordApi(dynamic data) async {
    try {
      dynamic response = await _apiManager.request(
          url: AppUrl.changePasswordUrl,
          parameter: data,
          requestType: RequestType.patchWithToken);
      log(data.toString(), name: "Change Password Data");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> forgetPasswordApi(dynamic data) async {
    try {
      dynamic response = await _apiManager.request(
          url: AppUrl.forgetPasswordApiUrl,
          parameter: data,
          requestType: RequestType.post);
      // dynamic response = await _apiServices.getPostApiResponseWithHeader(
      //     AppUrl.registerApiEndPoint, data);
      log(data.toString(), name: "Reset Up Data");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> forgetPasswordOtpApi(dynamic data) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.forgetPasswordVerifyOtpUrl,
        parameter: data,
        requestType: RequestType.post,
      );
      // dynamic response = await _apiServices.getPostApiResponseWithHeader(
      //     AppUrl.registerApiEndPoint, data);
      log(data.toString(), name: "Reset Up Data");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> editProfileApi(dynamic data) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.editProfileApiUrl,
        parameter: data,
        requestType: RequestType.putWithHeaders,
      );
      log(data.toString(), name: "Edit Profile Api Data body");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerOtpApi(dynamic data) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.registerVerifyOtpUrl,
        parameter: data,
        requestType: RequestType.post,
      );
      log(data.toString(), name: "Register Up Data");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerSetPasswordApi(dynamic data,
      {required String userId}) async {
    final url = "${AppUrl.registerSetPasswordUrl}/$userId";
    try {
      dynamic response = await _apiManager.request(
        url: url,
        parameter: data,
        requestType: RequestType.patchWithToken,
      );
      log(data.toString(), name: "Register Set Password Data");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> resentOtpRegisterApi(Map data) async {
    try {
      log(data.toString());

      dynamic response = await _apiManager.request(
          requestType: RequestType.post,
          url: AppUrl.resentOtpRegisterApiUrl,
          parameter: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Future<dynamic> logOutApi() async {
  //   try {
  //     dynamic response = await _apiManager.request(
  //         url: AppUrl.logoutApiUrl, requestType: RequestType.post);
  //     // dynamic response = await _apiServices
  //     //     .getPostApiResponsewithNoData(AppUrl.logoutApiEndPoint);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
