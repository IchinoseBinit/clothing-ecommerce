import 'dart:developer';

import 'package:clothing_ecommerce/api/network/api_manager.dart';
import 'package:clothing_ecommerce/data/enums/payment_methods.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
//DO not remove khati one import cause it help to set public key
import "package:khalti/khalti.dart";
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:uuid/uuid.dart';

import '/data/app_urls.dart';
import '/data/response/api_response.dart';
import '/environment_config.dart';
import '/models/payment_gateway_model.dart';
import '/styles/app_colors.dart';
import '/utils/request_type.dart';

class PaymentProvider with ChangeNotifier {
  // String khaltiPublicKey = "";
  GlobalKey<NavigatorState>? navigationKey;

  ApiResponse<List<PaymentGateway>> paymentListData = ApiResponse.loading();

  setPaymentGateway(ApiResponse<List<PaymentGateway>> response) {
    paymentListData = response;
    notifyListeners();
  }

  setNavigationKey(navigatorKey) {
    navigationKey = navigationKey;
  }

  dynamic onPayment(BuildContext context,
      {required double total, required PaymentMethodEnum paymentMethod}) {
    var uuid = const Uuid();
    String merchantName = "E Clothing";
    switch (paymentMethod) {
      case PaymentMethodEnum.eSewa:
        return onEsewaCall(context, total: total, uuid: uuid.v4());
      case PaymentMethodEnum.cod:
        return onGeneralCall(context);
      case PaymentMethodEnum.khalti:
        return onKhatiCall(context,
            total: total, merchantName: merchantName, uuid: uuid.v4());
      case PaymentMethodEnum.creditCard:
        return onStripeCall(context,
            total: total, merchantName: merchantName, uuid: uuid.v4());
      default:
    }
  }

  onKhatiCall(
    BuildContext context, {
    required double total,
    required String merchantName,
    required String uuid,
  }) {
    String decryptedSecretKey = "secret_key";
    KhaltiService.publicKey = decryptedSecretKey;
    final config = PaymentConfig(
      returnUrl: "www.google.com",
      amount: (total * 100).toInt(),
      productName: merchantName,
      productIdentity: uuid,
    );
    KhaltiScope.of(context).pay(
      config: config,
      preferences: [
        PaymentPreference.khalti,
        PaymentPreference.eBanking,
        PaymentPreference.connectIPS,
        PaymentPreference.mobileBanking,
        PaymentPreference.sct,
      ],
      onSuccess: (PaymentSuccessModel value) {
        log("Khalti Payment Successful");
      },
      onFailure: (PaymentFailureModel value) {
        log("Khalti Payment Failure: ${value.message}");
      },
      onCancel: () {
        log("Khalti Payment OnCancel");
      },
    );
  }

  calculateAmount(double amount) {
    final calculatedAmout = (amount.ceil()) * 100;
    return calculatedAmout.toString();
  }

  onStripeCall(
    BuildContext context, {
    required double total,
    required String merchantName,
    required String uuid,
  }) async {
    //TODO: yo need to have secret key
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      ApiManager _apiManagerClient = ApiManager();
      const String currency = "NPR";
      //1. create payment intent on the server
      final response = await _apiManagerClient.request(
          url: AppUrl.stripePaymentUrl,
          //TODO:Use different live secret key for production
          requestType: RequestType.postWithOnlyHeaders,
          headers: {
            'Authorization': 'Bearer ${AppUrl.stripeTestSecretUrl}',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          parameter: {
            "amount": calculateAmount(total),
            "currency": currency,
          });
      Navigator.pop(context);
      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: response['client_secret'],
          merchantDisplayName: merchantName,
          style: ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: AppColors.primaryColor,
            ),
          ),
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Success: Payment completed!')),
      );
    } catch (e) {
      if (e is StripeException) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Error: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  onEsewaCall(
    BuildContext context, {
    required double total,
    required String uuid,
  }) async {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: EnvironmentConfig.isProd == "true"
              ? Environment.live
              : Environment.test,
          clientId: AppUrl.esewaTestclientID,
          secretId: AppUrl.esewaTestSecretKey,
        ),
        esewaPayment: EsewaPayment(
          productId: uuid,
          productName: "E clothing",
          callbackUrl: "",
          productPrice: total.toString(),
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          debugPrint(":::SUCCESS::: => $data");
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }

  onGeneralCall(
    BuildContext context,
  ) async {
    //TODO: Make paymentExtensionTxnCode dynamic
  }
}
