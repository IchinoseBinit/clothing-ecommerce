import 'dart:developer';

import 'package:clothing_ecommerce/data/app_urls.dart';
import 'package:clothing_ecommerce/screens/auth/otp_screen.dart';
import 'package:clothing_ecommerce/screens/auth/set_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '/data/constants/routes_name.dart';
import '/models/login_model.dart';
import '/providers/database_provider.dart';
import '/providers/intro_notifier.dart';
import '/utils/navigation_util.dart';
import '/utils/show_toast.dart';
import '../api/auth_api.dart';
import 'hive_database_helper.dart';

class AuthProvider with ChangeNotifier {
  final _myRepo = AuthApi();
  bool _loginIsLoading = true;
  bool get loginIsLoading => _loginIsLoading;
  bool _loading = false;
  bool get loading => _loading;
  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;
  bool _forgetPasswordLoading = false;
  bool get forgetPasswordLoading => _forgetPasswordLoading;
  bool _registerOtpLoading = false;
  bool get registerOtpLoading => _registerOtpLoading;
  bool _setPassLoading = false;
  bool get setPassLoading => _setPassLoading;
  bool _editLoading = false;
  bool get editLoading => _editLoading;
  bool _changePasswordLoading = false;
  bool get changePasswordLoading => _changePasswordLoading;
  bool _isGuest = false;
  bool get isGuest => _isGuest;

  String? _email;
  String? get email => _email;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setIsGuest(bool value) {
    _isGuest = value;
  }

  setEditLoading(bool value) {
    _editLoading = value;
    notifyListeners();
  }

  setOtpLoading(bool value) {
    _registerOtpLoading = value;
    notifyListeners();
  }

  setPasswordLoading(bool value) {
    _setPassLoading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  setChangePasswordLoading(bool value) {
    _changePasswordLoading = value;
    notifyListeners();
  }

  setForgetPasswordLoading(bool value) {
    _forgetPasswordLoading = value;
    notifyListeners();
  }

  getEmailRememberMe() async {
    _loginIsLoading = true;
    _email = await DatabaseHelper().getBoxItem(
      key: "email",
    );
    _loginIsLoading = false;
    notifyListeners();
  }

  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
    required bool rememberMe,
    required bool isFromRefreshToken,
  }) async {
    setLoading(true);

    Map body = {
      'email': email.trim(),
      'password': password.trim(),
    };
    _myRepo.loginApi(body).then((value) async {
      setLoading(false);

      await DatabaseHelper().addBoxItem(key: "email", value: email.trim());
      final dbHelper =
          Provider.of<DatabaseHelperProvider>(context, listen: false);
      await dbHelper.saveToken(LoginModel(
        accessToken: value['data']["access"],
        refreshToken: value['data']["refresh"],
      ));
      await Provider.of<IntroProvider>(context, listen: false).call();
      showToast("Login Successfully");
      log(_isGuest.toString(), name: "Is Guest");
      if (isFromRefreshToken) {
        Navigator.of(context).pop();
      } else {
        navigateNamedReplacement(context, RoutesName.navigationRoute);
      }

      if (kDebugMode) {
        log(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);

      if (kDebugMode) {
        showToast(error.toString());
        log(error.toString());
      }
    });
  }

  Future<void> register(BuildContext context,
      {required Map<String, dynamic> data,
      bool isFromOtpScreen = false}) async {
    setSignUpLoading(true);

    _myRepo.registerApi(data).then((value) {
      setSignUpLoading(false);
      navigate(context, OptScreen(email: data["email"]));
      showToast("Send Code Successfully");
    }).onError((error, stackTrace) {
      setSignUpLoading(false);

      showToast(error.toString());

      if (kDebugMode) {
        log(error.toString());
      }
    });
  }

  Future<void> changePassword(dynamic data, BuildContext context) async {
    setChangePasswordLoading(true);
    _myRepo.changePasswordApi(data).then((value) {
      setChangePasswordLoading(false);
      showToast("Changed password successfully");
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setChangePasswordLoading(false);
      showToast("Server Error! Please Try again after sometime.");
    });
  }

  Future<void> forgetPassword(
    BuildContext context,
    dynamic data,
  ) async {
    setForgetPasswordLoading(true);

    _myRepo.forgetPasswordApi(data).then((value) {
      setForgetPasswordLoading(false);
      showToast("Sent OTP Successfully");
      navigate(
          context, OptScreen(email: data["email"], isFromForgetPassword: true));
    }).onError((error, stackTrace) {
      setForgetPasswordLoading(false);
      showToast(error.toString());
    });
  }

  Future<void> editProfile(dynamic data, BuildContext context) async {
    setEditLoading(true);
    _myRepo.editProfileApi(data).then((value) {
      setEditLoading(false);
      showToast("Profile changed Successfully");
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setEditLoading(false);
      showToast(error.toString());
    });
  }

  Future<void> resentOtpApiCall(Map data, BuildContext context) async {
    _myRepo.resentOtpApi(data).then((value) {
      log(value.toString());
      showToast("successfully resent the code");
    }).onError((error, stackTrace) {
      showToast(error.toString());
    });
  }

  Future<void> verifyOtp(BuildContext context, dynamic data,
      {bool isFromForgetPassword = false}) async {
    setOtpLoading(true);
    _myRepo
        .verifyOtpApi(data,
            url: isFromForgetPassword
                ? AppUrl.forgetPasswordVerifyOtpUrl
                : AppUrl.registerVerifyOtpUrl)
        .then((value) {
      setOtpLoading(false);
      showToast("Otp Verified");
      navigate(
          context,
          SetPasswordScreen(
            email: data["email"].toString(),
            userId: value["user_id"].toString(),
            isFromForgetPassword: isFromForgetPassword,
          ));
    }).onError((error, stackTrace) {
      setOtpLoading(false);
      showToast(error.toString());
    });
  }

  Future<void> setPasswordAfterOtp(BuildContext context,
      {required Map data,
      required String userId,
      required bool isFromForgetPassword}) async {
    setPasswordLoading(true);
    _myRepo.setPasswordApi(data, userId: userId).then((value) {
      setPasswordLoading(false);
      if (isFromForgetPassword) {
        showToast("Reset Password successfully");
      } else {
        showToast("User registered successfully");
      }
      navigateNamedReplacement(context, RoutesName.loginRoute);
    }).onError((error, stackTrace) {
      setPasswordLoading(false);
      showToast(error.toString());
    });
  }

  Future<void> logout(BuildContext context) async {
    DatabaseHelperProvider userPreference = DatabaseHelperProvider();
    showToast("Logout Successfully");
    userPreference.deleteToken();
    await Provider.of<IntroProvider>(context, listen: false).call();
    navigateNamedReplacement(context, RoutesName.loginRoute);
  }
}
