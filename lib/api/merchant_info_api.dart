import 'dart:developer';

import '/api/network/rhino_client.dart';
import '/data/app_urls.dart';
import '/models/announcement_model.dart';
import '/models/merchant_info_model.dart';
import '/utils/request_type.dart';

class MerchantInfoApi {
  final _rhino = RhinoClient();

  Future<MerchantInfoModel> fetchMerchantList({int? id}) async {
    try {
      String url = AppUrl.merchantInfoUrl.replaceAll("{id}", id.toString());
      dynamic response =
          await _rhino.request(url: url, requestType: RequestType.get);
      return MerchantInfoModel.fromJson(response);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<AnnouncementModel>> fetchAnnouncementList(
      String locationCode) async {
    try {
      String url =
          AppUrl.announcementMerchantDetailUrl.replaceAll("name", locationCode);
      List response =
          await _rhino.request(url: url, requestType: RequestType.get);
      log(response.toString());
      return response.map((e) => AnnouncementModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
