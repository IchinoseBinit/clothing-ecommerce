import 'dart:developer';

import 'package:flutter/foundation.dart';

import '/models/login_model.dart';
import '/providers/hive_database_helper.dart';

class DatabaseHelperProvider with ChangeNotifier {
  Future<void> saveToken(LoginModel user) async {
    await DatabaseHelper()
        .addBoxItem(key: "access_token", value: user.accessToken.toString());
    await DatabaseHelper()
        .addBoxItem(key: "refresh_token", value: user.refreshToken.toString());
    String? refreshToken = await DatabaseHelper().getBoxItem(
      key: "refresh_token",
    );
    log(refreshToken!, name: "Form saveToken DatabaseHelper Provider");
  }

  Future<LoginModel> getToken() async {
    final String? accessToken = await DatabaseHelper().getBoxItem(
      key: "access_token",
    );
    final String? refreshToken = await DatabaseHelper().getBoxItem(
      key: "refresh_token",
    );

    return LoginModel(
      accessToken: accessToken.toString(),
      refreshToken: refreshToken.toString(),
    );
  }

  Future<bool> deleteToken() async {
    await DatabaseHelper().deleteBoxItem(key: 'access_token');
    await DatabaseHelper().deleteBoxItem(key: 'refresh_token');
    return true;
  }

  Future<bool> hideIntro() async {
    final isHide = await DatabaseHelper().getBoxItem(key: 'hideIntro');
    if (isHide == null) {
      return false;
    }
    return isHide;
  }

  Future<bool> isShowNavigationScreen() async {
    final hasToken = await DatabaseHelper().getBoxItem(key: 'access_token');
    if (hasToken == null) {
      return false;
    }
    return true;
  }
}
