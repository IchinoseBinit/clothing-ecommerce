import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/models/edit_profile_model.dart';
import '/models/profile_model.dart';
import '/utils/request_type.dart';

class ProfileApi {
  final RhinoClient _apiServices = RhinoClient();

  Future<ProfileModel> fetchProfileDetail() async {
    try {
      dynamic response = await _apiServices.request(
          url: AppUrl.profileApiUrl, requestType: RequestType.getWithToken);
      return response = ProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<EditProfileModel> editProfileDetail(dynamic data) async {
    try {
      dynamic response = await _apiServices.request(
          url: AppUrl.editProfileApiUrl,
          parameter: data,
          requestType: RequestType.putWithHeaders);
      // dynamic response =
      //     await _apiServices.putEditData(AppUrl.editProfileApiEndPoint, data);
      return response = EditProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
