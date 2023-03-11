import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  // final _myRepo = ProfileApi();

  // //fetching profile
  // ApiResponse<ProfileModel> profileList = ApiResponse.loading();
  // setProfileList(ApiResponse<ProfileModel> response,
  //     {required bool noNotifer}) {
  //   profileList = response;
  //   if (!noNotifer) notifyListeners();
  // }

  // Future<void> fetchProfileApi({required bool noNotifer}) async {
  //   setProfileList(ApiResponse.loading(), noNotifer: noNotifer);
  //   await _myRepo.fetchProfileDetail().then((value) {
  //     log(value.name.toString(), name: "View Model name");
  //     setProfileList(ApiResponse.completed(value), noNotifer: noNotifer);
  //   }).onError((error, stackTrace) {
  //     setProfileList(ApiResponse.error(error.toString()), noNotifer: noNotifer);
  //   });
  // }
}
