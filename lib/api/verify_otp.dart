import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/utils/request_type.dart';

class PasswordResetVerifyOtpApi {
  final RhinoClient _rhino = RhinoClient();

  Future<dynamic> verifyOtpApi(dynamic data) async {
    try {
      dynamic response = await _rhino.request(
        url: AppUrl.passwordResetVerifyOtpUrl,
        parameter: data,
        requestType: RequestType.postWithToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
