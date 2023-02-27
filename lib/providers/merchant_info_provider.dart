import 'package:flutter/cupertino.dart';

import '/api/merchant_info_api.dart';
import '/data/response/api_response.dart';
import '/models/announcement_model.dart';
import '/models/merchant_info_model.dart';

class MerchantInfoProvider with ChangeNotifier {
  final _merchantInfoApi = MerchantInfoApi();

  bool isLoadingDetailScreen = true;
  setLoadingOfDetailScreen(bool value, {bool noNotifier = false}) {
    isLoadingDetailScreen = value;
    if (!noNotifier) notifyListeners();
    // return isLoadingDetailScreen;
  }

  ApiResponse<MerchantInfoModel> merchantInfo = ApiResponse.loading();
  setMerchantList(ApiResponse<MerchantInfoModel> response) {
    merchantInfo = response;
  }

  Future<void> fetchMerchantInfo({required int merchantLocCode}) async {
    setMerchantList(ApiResponse.loading());
    await _merchantInfoApi.fetchMerchantList(id: merchantLocCode).then((value) {
      setMerchantList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMerchantList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<AnnouncementModel>> anouncementData = ApiResponse.loading();
  setAnnouncementList(ApiResponse<List<AnnouncementModel>> response) {
    anouncementData = response;
  }

  Future<void> fetchAnnouncement(String locationCode) async {
    setAnnouncementList(ApiResponse.loading());
    await _merchantInfoApi.fetchAnnouncementList(locationCode).then((value) {
      setAnnouncementList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setAnnouncementList(ApiResponse.error(error.toString()));
    });
  }
}
