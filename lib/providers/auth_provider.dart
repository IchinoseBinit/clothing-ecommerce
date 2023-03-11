import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '/data/constants/routes_name.dart';
import '/models/login_model.dart';
import '/providers/database_provider.dart';
import '/providers/intro_notifier.dart';
import '../screens/auth/reset_password_opt_screen.dart';
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
  bool _resetPsOtpLoading = false;
  bool get resetPsOtpLoading => _resetPsOtpLoading;
  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;
  bool _resetPasswordLoading = false;
  bool get resetPasswordLoading => _resetPasswordLoading;
  bool _registerOtpLoading = false;
  bool get registerOtpLoading => _registerOtpLoading;
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

  setResetPsOtpLoading(bool value) {
    _resetPsOtpLoading = value;
    notifyListeners();
  }

  setEditLoading(bool value) {
    _editLoading = value;
    notifyListeners();
  }

  setRegisterOtpLoading(bool value) {
    _registerOtpLoading = value;
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

  setResetLoading(bool value) {
    _resetPasswordLoading = value;
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

      // await DatabaseHelper().addBoxItem(key: "email", value: email.trim());
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
        // Navigator.pushReplacementNamed(context, RoutesName.navigationRoute);
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
      required bool isFromCheckout,
      bool isFromOtpScreen = false}) async {
    setSignUpLoading(true);

    _myRepo.registerApi(data).then((value) {
      setSignUpLoading(false);
      showToast("Registered Successfully");
      navigateNamedReplacement(context, RoutesName.loginRoute);
      // showToast("Send Code Successfully");
      // if (!isFromOtpScreen) {
      //   navigate(context,
      //       screen: RegisterOptScreen(
      //         email: data["email"],
      //         data: data,
      //       ));
      // }
      if (kDebugMode) {
        log(value.toString());
      }
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

      showToast("There was error on changing password");
    });
  }

  Future<void> resetPassword(dynamic data, BuildContext context,
      {bool isFromOtpScreen = false}) async {
    setResetLoading(true);

    _myRepo.resetPasswordApi(data).then((value) {
      setResetLoading(false);

      showToast("Sent OTP Successfully");
      if (!isFromOtpScreen) {
        navigate(
            context,
            ResetPasswordOptScreen(
              email: data["email"],
            ));
      }
      if (kDebugMode) {
        log(value.toString());
      }
    }).onError((error, stackTrace) {
      setResetLoading(false);

      showToast(error.toString());

      if (kDebugMode) {
        log(error.toString());
      }
    });
  }

  Future<void> resetPasswordVerifyOtp(
      dynamic data, BuildContext context) async {
    setResetPsOtpLoading(true);
    _myRepo.passwordResetOtpApi(data).then((value) {
      setResetPsOtpLoading(false);
      showToast("Changed Password Successfully");
      if (_isGuest) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.loginRoute);
      }
    }).onError((error, stackTrace) {
      setResetPsOtpLoading(false);
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
    _myRepo.resentOtpRegisterApi(data).then((value) {
      log(value.toString());
      showToast("successfully resent the code");
    }).onError((error, stackTrace) {
      showToast(error.toString());
    });
  }

  Future<void> registerVerifyOtp(dynamic data, BuildContext context) async {
    setRegisterOtpLoading(true);
    _myRepo.registerOtpApi(data).then((value) {
      setRegisterOtpLoading(false);
      showToast("User registered successfully");
      if (isGuest) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
      Navigator.pushReplacementNamed(context, RoutesName.loginRoute);
    }).onError((error, stackTrace) {
      setRegisterOtpLoading(false);
      showToast(error.toString());
    });
  }

  Future<void> logout(BuildContext context) async {
    DatabaseHelperProvider userPreference = DatabaseHelperProvider();
    showToast("Logout Successfully");
    userPreference.deleteToken();
    await Provider.of<IntroProvider>(context, listen: false).call();
    Navigator.pushNamed(context, RoutesName.loginRoute);
  }
}
