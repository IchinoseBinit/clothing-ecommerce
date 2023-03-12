import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '/data/app_exceptions.dart';
import '/data/app_urls.dart';
import '/main.dart';
import '/models/login_model.dart';
import '/models/refresh_token_model.dart';
import '/providers/database_provider.dart';
import '/providers/hive_database_helper.dart';
import '../../screens/auth/login_screen.dart';
import '/utils/navigation_util.dart';
import '/utils/request_type.dart';
import '/utils/request_type_exception.dart';

class ApiManager {
  late final Dio _client;
  dynamic responseJson;

  final timeoutDuration = const Duration(seconds: 60);
  ApiManager() {
    _client = Dio();
    _client.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        requestBody: true,
      ),
    );

    _client.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if (error.response?.statusCode != null && error.response!.statusCode ==  401) {
        if (error.response?.data != null) {
          if (error.response!.data["messages"] != null) {
            if (error.response!.data["messages"][0]["token_type"] != null &&
                error.response!.data["messages"][0]["token_type"].toString() ==
                    "access") {
              String? token = await _getRefreshToken();
              if (token != null) {
                Map<String, String> headingWithToken = {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                  'Accept': '*/*',
                };
                error.requestOptions.headers = headingWithToken;
                return handler.resolve(await _retry(error.requestOptions));
              }
            }
          }
        }
      }
      return handler.next(error);
    }));
  }
  Future request({
    required RequestType requestType,
    // dynamic heading = Nothing,
    required String url,
    dynamic parameter,
    dynamic headers,
    ResponseType? responseType,
  }) async {
    String? token = await DatabaseHelper().getBoxItem(key: "access_token");
    Map<String, String> heading = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map<String, String> headingWithToken = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      'Accept': '*/*',
    };

    Response? resp;
    // if (!UtilityProvider.canCallApi()) {
    //   throw "Inactive for too long, Please login";
    // }

    try {
      switch (requestType) {
        case RequestType.get:
          resp = await _client
              .get(
                url,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.getWithToken:
          resp = await _client
              .get(
                url,
                options: Options(
                  headers: headingWithToken,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.post:
          resp = await _client
              .post(
                url,
                data: parameter,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.patch:
          resp = await _client
              .patch(
                url,
                data: parameter,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.postWithHeaders:
          log("From Post with postWithHeaders!!!");
          log({...heading, ...headers}.toString());
          log("From Post with postWithHeaders!!!");
          resp = await _client
              .post(
                url,
                data: parameter,
                options: Options(
                  headers: {...heading, ...headers},
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.postWithOnlyHeaders:
          log("From Post with postWithHeaders!!!");
          log({...heading, ...headers}.toString());
          log("From Post with postWithHeaders!!!");
          resp = await _client
              .post(
                url,
                data: parameter,
                options: Options(
                  headers: headers,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.postWithToken:
          resp = await _client
              .post(
                url,
                data: parameter,
                options: Options(
                  headers: headingWithToken,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.patchWithToken:
          resp = await _client
              .patch(
                url,
                data: parameter,
                options: Options(
                  headers: headingWithToken,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.putWithHeaders:
          resp = await _client
              .put(
                url,
                data: parameter,
                options: Options(
                  headers: headingWithToken,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.delete:
          resp = await _client
              .delete(
                url,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        default:
          return throw RequestTypeNotFoundException(
            "The HTTP request method is not found",
          );
      }
      return returnResponse(resp);
    } on DioError catch (ex) {
      // if (ex.response!.statusCode == 401) {
      //   await _getRefreshToken();
      //   // navKey.currentState!.pushReplacementNamed(RoutesName.login);
      //   // DatabaseHelperProvider().deleteToken();
      // }

      // if (ex.response!.statusCode == 400) {
      // if (ex.response!.data["coupon_code"] != null) {
      //   throw ex.response!.data["coupon_code"][0];
      // } else if (ex.response!.data["coupon"] != null) {
      //   throw ex.response!.data["coupon"];
      // } else if (ex.response!.data["email"] != null) {
      //   throw ex.response!.data["email"][0];
      // } else
      // log((ex.response!.data[0]), name: "rhino client");
      // if (ex.response!.data[0] != null) {
      // throw ex.response!.data[0];
      // }
      // }

      throw ex.response?.data?["message"] ??
          "Dear customer, we are unable to complete the process. Please try again later.";
    } catch (ex) {
      rethrow;
    }
  }

  Future<String?> _getRefreshToken() async {
    Dio _rClient = Dio();
    String refreshtoken =
        await DatabaseHelper().getBoxItem(key: "refresh_token");
    String accesstoken = await DatabaseHelper().getBoxItem(key: "access_token");
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accesstoken',
      'Accept': '*/*',
    };

    try {
      Response response = await _rClient.post(
        AppUrl.getTokenUrl,
        data: {"refresh": refreshtoken},
        options: Options(
          headers: header,
        ),
      );
      final dataModel = RefreshTokenModel.fromJson(response.data);
      await DatabaseHelperProvider().saveToken(
        LoginModel(
          accessToken: dataModel.access,
          refreshToken: dataModel.refresh,
        ),
      );
      return dataModel.access;
    } on DioError catch (ex) {
      navigate(
          navKey.currentState!.context,
          const LoginScreen(
            isFromRefreshToken: true,
          ));
      DatabaseHelperProvider().deleteToken();
      log(ex.message ?? "Refresh Token Error");
    }
    return null;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _client.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        log(responseJson.toString(), name: "response json ko value");
        return responseJson;

      case 201:
        dynamic responseJson = response.data;
        log(responseJson.toString());
        return responseJson;

      case 400:
        dynamic responseJson = response.data;
        throw BadRequestException(responseJson
            .toString()
            .split('[')
            .last
            .trim()
            .replaceAll(']}', ""));

      case 403:
        throw ForbidenIp(response.data.toString());

      case 404:
        dynamic responseJson = jsonDecode(response.data);
        throw UnauthorizedException(responseJson['email'][0].toString());

      default:
        throw FetchDataException(
            'Error occurred while communicating with server '
            'with status code {response.statusCode.toString()}');
    }
  }
}
