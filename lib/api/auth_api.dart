import 'dart:developer';

import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/utils/request_type.dart';

class AuthApi {
  final RhinoClient _rhino = RhinoClient();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      log(AppUrl.loginUrl.toString(), name: "URL LOgin");
      dynamic response = await _rhino.request(
          url: AppUrl.loginUrl, parameter: data, requestType: RequestType.post);
      // dynamic response = await _apiServices.getPostApiResponseWithHeader(
      //     AppUrl.loginEndPoint, data);
      // log(response.toString(), name: "Response from Login");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUpApi(Map<String, dynamic> data) async {
    try {
      dynamic response = await _rhino.request(
          url: AppUrl.registerApiUrl,
          parameter: data,
          requestType: RequestType.post);

      // dynamic response = await _apiServices.getPostApiResponseWithHeader(
      //     AppUrl.registerApiEndPoint, data);
      log(data.toString(), name: "Sign Up Data");
      return response;
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  Future<dynamic> changePasswordApi(dynamic data) async {
    try {
      dynamic response = await _rhino.request(
          url: AppUrl.changePasswordUrl,
          parameter: data,
          requestType: RequestType.postWithToken);
      log(data.toString(), name: "Change Password Data");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> resetPasswordApi(dynamic data) async {
    try {
      dynamic response = await _rhino.request(
          url: AppUrl.resetPassApiUrl,
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

  Future<dynamic> passwordResetOtpApi(dynamic data) async {
    try {
      dynamic response = await _rhino.request(
        url: AppUrl.passwordResetVerifyOtpUrl,
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
      dynamic response = await _rhino.request(
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
      dynamic response = await _rhino.request(
        url: AppUrl.registerVerifyOtpUrl,
        parameter: data,
        requestType: RequestType.post,
      );
      // dynamic response = await _apiServices.getPostApiResponseWithHeader(
      //     AppUrl.registerApiEndPoint, data);
      log(data.toString(), name: "Register Up Data");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> resentOtpRegisterApi(Map data) async {
    try {
      log(data.toString());

      dynamic response = await _rhino.request(
          requestType: RequestType.post,
          url: AppUrl.resentOtpRegisterApi,
          parameter: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> logOutApi() async {
    try {
      dynamic response = await _rhino.request(
          url: AppUrl.logoutApiUrl, requestType: RequestType.post);
      // dynamic response = await _apiServices
      //     .getPostApiResponsewithNoData(AppUrl.logoutApiEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
