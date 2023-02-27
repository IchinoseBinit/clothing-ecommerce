import 'package:flutter/material.dart';

import '/models/login_model.dart';
import '/providers/database_provider.dart';

class IntroProvider extends ChangeNotifier {
  final DatabaseHelperProvider _preference = DatabaseHelperProvider();
  Future<LoginModel> getUserData() => DatabaseHelperProvider().getToken();
  bool _isHide = false;
  bool get getisSeenWelcomeScreen => _isHide;
  bool _hasToken = false;
  bool get hasAppToken => _hasToken;

  call() async {
    await hasIntro();
    await hasToken();
  }

  hasIntro() async {
    _isHide = await _preference.hideIntro();
  }

  hasToken() async {
    _hasToken = await _preference.isShowNavigationScreen();
  }
}
