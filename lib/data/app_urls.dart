import 'dart:io';

import 'package:clothing_ecommerce/environment_config.dart';

class AppUrl {
  static final String apiKey = Platform.isAndroid ? androidKey : androidKey;
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
  static var baseUrl =
      EnvironmentConfig.isProd == "true" ? "" : 'http://127.0.0.1:8000/api/v1';
  static const String androidKey = 'AIzaSyDfjyHuSMqkLHM-vw9Dvj71yJ9MqoF3d20';
  static String loginUrl = '$baseUrl/users/login/';
  static String registerApiUrl = '$baseUrl/users/register/';

  static String logoutApiUrl = '$baseUrl/auth/logout/';

  static String resetPassApiUrl =
      '$baseUrl/auth/customers/password-reset/get-opt/';
  static String changePasswordUrl = '$baseUrl/auth/customers/password-change/';
  static String profileApiUrl = '$baseUrl/customers/info/';
  static String passChangeApiUrl = '$baseUrl/auth/password/change/';
  static String editProfileApiUrl = '$baseUrl/customers/update/';

  static String merchantListUrl = '$baseUrl/merchants/list/';
  static String merchantInfoUrl = '$baseUrl/merchants/{id}/info/';
  static String merchantItemListUrl = '$baseUrl/items/list/';
  static String categoryItemListUrl = '$baseUrl/item-groups/list/';
  static String timeSlotUrl = '$baseUrl/merchants/time-slot/';

  static var cityUrl = '$baseUrl/merchants/countries/';

  static var couponUrl = '$baseUrl/merchants/coupons/name/';
  static var cartPriceUrl = '$baseUrl/orders/cart-price/';
  static var directionUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";
  static var paymentGetwayUrl = "$baseUrl/merchants/payment-gateways/name/";
  static var placefirstOrderUrl = "$baseUrl/orders/place-order/";
  static var placefinalOrderUrl = "$baseUrl/orders/success/";
  static var orderListUrl = "$baseUrl/customers/orders/";
  static var getTokenUrl = "$baseUrl/auth/customers/jwt/refresh/";
  static var passwordResetVerifyOtpUrl =
      "$baseUrl/auth/customers/password-reset-with-otp/";
  static var registerVerifyOtpUrl = "$baseUrl/auth/customers/verify-email/";
  static var resentOtpRegisterApi =
      "$baseUrl/auth/customers/email-verification/get-opt/";
  static var setFavouriteRestaurantUrl =
      "$baseUrl/customers/favourite/merchants/name/";
  static var favouriteRestaurantListUrl =
      "$baseUrl/customers/favourite/merchants/";
  static var announcementMerchantDetailUrl =
      "$baseUrl/merchants/announcements/name/";
  static var stripePaymentUrl = "https://api.stripe.com/v1/payment_intents";
  static var kStripePaymentUrl =
      "https://us-central1-stripe-checkout-flutter.cloudfunctions.net/stripePaymentIntentRequest";

  static var stagCallbackUrl = "https://myfood.indulgemall.com/";
  static var prodCallbackUrl = "https://app.rhinopass.com/";
}
