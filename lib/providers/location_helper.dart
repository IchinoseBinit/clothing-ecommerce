import 'dart:convert';

import '../api/network/api_manager.dart';
import '/data/app_urls.dart';
import '/utils/request_type.dart';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$longitude,$latitude&zoom=16&size=1080x320&maptype=roadmap&markers=color:red%7Clabel:N%7C$latitude,$longitude&key=${AppUrl.apiKey}";
  }

  static Future<String> getPlaceAddress(
      {required double longitude, required double latitude}) async {
    ApiManager _rhinoClient = ApiManager();
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${AppUrl.apiKey}';
    final response = await _rhinoClient.request(
      url: url,
      requestType: RequestType.get,
    );
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
