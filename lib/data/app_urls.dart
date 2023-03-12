import 'dart:io';

import 'package:clothing_ecommerce/environment_config.dart';

class AppUrl {
  static final String apiKey = Platform.isAndroid ? androidKey : androidKey;
  static const String androidKey = 'AIzaSyDfjyHuSMqkLHM-vw9Dvj71yJ9MqoF3d20';
  // static final String iosKey = 'YOUR_API_KEY_HERE';

//Khati keys
  static const String khaltiPublicKey =
      "test_public_key_5904412e4d6243c6aaebe2de1969b623";
  static const String khaltiLiveKey =
      "live_secret_key_85e87407b40c44b7bb423632f62163c6";

  //Esewa Keys
  static const String esewaTestclientID =
      "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R";
  // static const String esewaTestSecretKey =
  //     "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==";
  static String baseUrl =
      EnvironmentConfig.isProd == "true" ? "" : 'http://192.168.1.92:8000';
  static String stagCallbackUrl = "";
  static String prodCallbackUrl = "";

  // EnvironmentConfig.isProd == "true" ? "" : 'http://127.0.0.1:8000';
  static String loginUrl = '$baseUrl/users/login/';
  static String registerApiUrl = '$baseUrl/users/register/';
  static String changePasswordUrl = '$baseUrl/users/change-password/';
  static String getTokenUrl = "$baseUrl/auth/customers/jwt/refresh/";
  static String registerVerifyOtpUrl = "$baseUrl/users/verify-otp/";
  //TODO: set register set password url
  static String registerSetPasswordUrl = "$baseUrl/users/change-password-after-otp";
  //TODO: left api
  static String forgetPasswordApiUrl = '$baseUrl/';
  static String resentOtpRegisterApiUrl = "$baseUrl/";
  static String forgetPasswordVerifyOtpUrl = "$baseUrl/";
  static String profileApiUrl = '$baseUrl/';
  static String editProfileApiUrl = '$baseUrl/';

  //Stripe Url
  static String stripePaymentUrl = "https://api.stripe.com/v1/payment_intents";
  static String kStripePaymentUrl =
      "https://us-central1-stripe-checkout-flutter.cloudfunctions.net/stripePaymentIntentRequest";

//Product apis
  static String productListUrl = "$baseUrl/product/product-list/";
  static String productDetailUrl = "$baseUrl/product/product-detail/name/";
  static String productSearchUrl = "$baseUrl/product/product-search/name/";
}
