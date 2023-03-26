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
  static const String esewaTestSecretKey =
      "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==";
  // static String baseUrl =
  //     EnvironmentConfig.isProd == "true" ? "" : 'http://192.168.12.33:8000';
  // static String baseUrl =
  //     EnvironmentConfig.isProd == "true" ? "" : 'http://192.168.1.67:8000';
  static const String baseUrl =
      EnvironmentConfig.isProd == "true" ? _productionUrl : _stagingUrl;
  static const String _stagingUrl = "http://202.79.60.83:8000";
  static const String _productionUrl = "";
  static const String loginUrl = '$baseUrl/users/login/';
  static const String registerApiUrl = '$baseUrl/users/register/';
  static const String changePasswordUrl = '$baseUrl/users/change-password/';
  static const String getTokenUrl = "$baseUrl/auth/customers/jwt/refresh/";
  static const String registerVerifyOtpUrl = "$baseUrl/users/verify-otp/";
  static const String forgetPasswordVerifyOtpUrl = "$baseUrl/users/verify-otp-reset/";
  static const String setPasswordUrl = "$baseUrl/users/change-password-after-otp";
  static const String forgetPasswordApiUrl = '$baseUrl/users/reset-password/';
  //TODO: left api
  static const String resentOtpRegisterApiUrl = "$baseUrl/";
  static const String profileApiUrl = '$baseUrl/';
  static const String editProfileApiUrl = '$baseUrl/';

  //Stripe Url
  static const String stripePaymentUrl = "https://api.stripe.com/v1/payment_intents";
  static const String kStripePaymentUrl =
      "https://us-central1-stripe-checkout-flutter.cloudfunctions.net/stripePaymentIntentRequest";

//Product apis
  static const String productListUrl = "$baseUrl/product/product-list/";
  static const String categoryListUrl = "$baseUrl/product/categories-list/";
  static const String categorySpecificProductsUrl =
      "$baseUrl/product/category-product/name/";
  static const String productDetailUrl = "$baseUrl/product/product-detail/name/";
  static const String productSearchUrl = "$baseUrl/product/product-search/name/";

  //Add to cart url
  static const String addToCartUrl = "$baseUrl/order/add-to-cart/";
  static const String viewCartUrl = "$baseUrl/order/list-cart-items-by-user/";

  //Order apis
  static const String orderUrl = "$baseUrl/order/order-products/";
  static const String orderListUrl = "$baseUrl/order/list-user-order/";
}
