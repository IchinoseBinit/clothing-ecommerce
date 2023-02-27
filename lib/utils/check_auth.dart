import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/data/constants/routes_name.dart';
import '/models/login_model.dart';
import '/providers/database_provider.dart';

class CheckAuth {
  Future<LoginModel> getUserData() => DatabaseHelperProvider().getToken();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      log(value.accessToken.toString(), name: "Connect access token");
      log(value.refreshToken.toString(), name: "Connect refresh token");
      if (value.accessToken.toString() == 'null' ||
          value.accessToken.toString() == '' ||
          value.refreshToken.toString() == 'null' ||
          value.refreshToken.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.loginRoute);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.navigationRoute);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        log(error.toString());
      }
    });
  }
}
