// import 'dart:convert';
// import 'dart:developer';

// import 'package:esewa_flutter_sdk/esewa_config.dart';
// import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
// import 'package:esewa_flutter_sdk/esewa_payment.dart';
// import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
// //DO not remove khati one import cause it help to set public key
// import "package:khalti/khalti.dart";
// import 'package:khalti_flutter/khalti_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';

// import '/api/network/rhino_client.dart';
// import '/api/payment_gateway_api.dart';
// import '/data/app_urls.dart';
// import '/data/response/api_response.dart';
// import '/environment_config.dart';
// import '/models/payment_gateway_model.dart';
// import '/styles/app_colors.dart';
// import '/utils/request_type.dart';

// class PaymentGatewayProvider with ChangeNotifier {
//   // String khaltiPublicKey = "";
//   GlobalKey<NavigatorState>? navigationKey;

//   final _paymentGatewayApi = PaymentGatewayApi();
//   ApiResponse<List<PaymentGateway>> paymentListData = ApiResponse.loading();

//   setPaymentGateway(ApiResponse<List<PaymentGateway>> response) {
//     paymentListData = response;
//     notifyListeners();
//   }

//   setNavigationKey(navigatorKey) {
//     navigationKey = navigationKey;
//   }

//   dynamic onPayment(BuildContext context,
//       {required double total,
//       required String merchantName,
//       required String country,
//       required CartPriceModel cpm,
//       required String currency,
//       required String domainkey,
//       required String merchantKey,
//       required String merchantLocation,
//       required int paymentGatewayIndex,
//       required String paymentGatewayCode}) {
//     var uuid = const Uuid();
//     // String firstDecryptKey = AlgorithmUtils.decryptFirstFernet(
//     //     domainkey: "_",
//     //     merchantKey:
//     //         "gAAAAABg2vBSzaboZeQkQUA-sd3Fr18oSMe9DnQSKALHUbn7RPht2UdvKBOo3uZWHYx_NhllYUJF0IZGbXyJ4wDSj3bV6HcCqWR-zgObEWRYdFfc4dE_xZVZiY-XFE5WDpb2NO3FjKLc");
//     switch (paymentGatewayCode) {
//       case "esewa":
//         return onEsewaCall(context,
//             cpm: cpm,
//             merchantLocation: merchantLocation,
//             merchantDomain: domainkey,
//             firstDecryptKey: "",
//             total: total,
//             merchantName: merchantName,
//             paymentGatewayIndex: paymentGatewayIndex,
//             uuid: uuid.v4());
//       case "cod":
//         return onGeneralCall(context,
//             cpm: cpm,
//             merchantLocation: merchantLocation,
//             merchantDomain: domainkey,
//             firstDecryptKey: "",
//             total: total,
//             merchantName: merchantName,
//             paymentGatewayIndex: paymentGatewayIndex,
//             uuid: uuid.v4());
//       case "esewa_transfer":
//         return onGeneralCall(context,
//             cpm: cpm,
//             merchantLocation: merchantLocation,
//             merchantDomain: domainkey,
//             firstDecryptKey: "",
//             total: total,
//             merchantName: merchantName,
//             paymentGatewayIndex: paymentGatewayIndex,
//             uuid: uuid.v4());
//       case "khalti":
//         return onKhatiCall(context,
//             merchantLocation: merchantLocation,
//             cpm: cpm,
//             firstDecryptKey: "",
//             total: total,
//             paymentGatewayIndex: paymentGatewayIndex,
//             merchantName: merchantName,
//             uuid: uuid.v4());
//       case "stripe":
//         return onStripeCall(context,
//             cpm: cpm,
//             total: total,
//             merchantLocation: merchantLocation,
//             firstDecryptKey: "",
//             country: country,
//             paymentGatewayIndex: paymentGatewayIndex,
//             merchantName: merchantName,
//             currency: currency,
//             uuid: uuid.v4());
//       default:
//     }
//   }

//   onKhatiCall(
//     BuildContext context, {
//     required double total,
//     required CartPriceModel cpm,
//     required int paymentGatewayIndex,
//     required String merchantName,
//     required String merchantLocation,
//     required String uuid,
//     required String firstDecryptKey,
//   }) {
//     String decryptedSecretKey = "secret_key";
//     KhaltiService.publicKey = decryptedSecretKey;
//     final config = PaymentConfig(
//       returnUrl: "www.google.com",
//       amount: total.toInt() * 100,
//       productName: merchantName,
//       productIdentity: uuid,
//     );
//     String paymentPreferences = paymentListData
//         .data![paymentGatewayIndex].details
//         .where((element) => element.key == "payment_preference")
//         .first
//         .value;
//     log(paymentPreferences.toString(), name: "khati");
//     KhaltiScope.of(context).pay(
//       config: config,
//       preferences: [
//         if (paymentPreferences.contains("khalti")) PaymentPreference.khalti,
//         if (paymentPreferences.contains("eBanking")) PaymentPreference.eBanking,
//         if (paymentPreferences.contains("connectIPS"))
//           PaymentPreference.connectIPS,
//         if (paymentPreferences.contains("mobileBanking"))
//           PaymentPreference.mobileBanking,
//         if (paymentPreferences.contains("sct")) PaymentPreference.sct,
//       ],
//       onSuccess: (PaymentSuccessModel value) {
//         log("Khalti Payment Successful");
//         Provider.of<PlaceOrderProvider>(context, listen: false).placeFinalOrder(
//             context,
//             cartPriceData: cpm,
//             merchantLocation: merchantLocation,
//             paymentExtensionTxnCode: value.idx,
//             paymentExtensionCode:
//                 paymentListData.data![paymentGatewayIndex].code,
//             status: paymentListData.data![paymentGatewayIndex].details
//                 .firstWhere((element) => element.key == "success_status",
//                     orElse: () =>
//                         Details(key: "success_status", value: "new_order"))
//                 .value);
//       },
//       onFailure: (PaymentFailureModel value) {
//         log("Khalti Payment Failure: ${value.message}");
//       },
//       onCancel: () {
//         log("Khalti Payment OnCancel");
//       },
//     );
//   }

//   calculateAmount(double amount) {
//     final calculatedAmout = (amount.ceil()) * 100;
//     return calculatedAmout.toString();
//   }

//   onStripeCall(
//     BuildContext context, {
//     required double total,
//     required int paymentGatewayIndex,
//     required String merchantName,
//     required String uuid,
//     required String country,
//     required String currency,
//     required CartPriceModel cpm,
//     required String merchantLocation,
//     required String firstDecryptKey,
//   }) async {
//     String decryptedPublicKey = "stripe_publishable_key";
//     Stripe.publishableKey = decryptedPublicKey;
//     String decryptedSecretKey = "stripe_client_secret";
//     Stripe.publishableKey = decryptedPublicKey;
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     try {
//       RhinoClient _apiManagerClient = RhinoClient();

//       // 1. create payment intent on the server
//       final response = await _apiManagerClient.request(
//           url: AppUrl.stripePaymentUrl,
//           requestType: RequestType.postWithOnlyHeaders,
//           headers: {
//             'Authorization': 'Bearer $decryptedSecretKey',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           },
//           parameter: {
//             "amount": calculateAmount(total),
//             "currency": currency,
//           });

//       // 2. initialize the payment sheet
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: response['client_secret'],
//           merchantDisplayName: merchantName,
//           style: ThemeMode.light,
//           appearance: const PaymentSheetAppearance(
//             colors: PaymentSheetAppearanceColors(
//               primary: AppColors.primaryColor,
//             ),
//           ),
//         ),
//       );

//       await Stripe.instance.presentPaymentSheet();
//       Provider.of<PlaceOrderProvider>(context, listen: false).placeFinalOrder(
//           context,
//           cartPriceData: cpm,
//           merchantLocation: merchantLocation,
//           paymentExtensionTxnCode: response["id"],
//           paymentExtensionCode: paymentListData.data![paymentGatewayIndex].code,
//           status: paymentListData.data![paymentGatewayIndex].details
//               .firstWhere((element) => element.key == "success_status",
//                   orElse: () =>
//                       Details(key: "success_status", value: "new_order"))
//               .value);
//       scaffoldMessenger.showSnackBar(
//         const SnackBar(content: Text('Success: Payment completed!')),
//       );
//     } catch (e) {
//       if (e is StripeException) {
//         scaffoldMessenger.showSnackBar(
//           SnackBar(
//             content: Text('Error: ${e.error.localizedMessage}'),
//           ),
//         );
//       } else {
//         scaffoldMessenger.showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }
//     }
//   }

//   onEsewaCall(
//     BuildContext context, {
//     required String firstDecryptKey,
//     required double total,
//     required CartPriceModel cpm,
//     required String merchantName,
//     required String merchantLocation,
//     required String merchantDomain,
//     required int paymentGatewayIndex,
//     required String uuid,
//   }) async {
//     String decryptedSecretKey = "secret_key";
//     String decryptedClientId = "client_id";

//     try {
//       log(decryptedClientId, name: "decryptedClientId");
//       log(decryptedSecretKey, name: "decryptedSecretKey");
//       EsewaFlutterSdk.initPayment(
//         esewaConfig: EsewaConfig(
//           environment: paymentListData.data![paymentGatewayIndex].details
//                       .firstWhere((element) => element.key == "mode")
//                       .value
//                       .toString() ==
//                   "live"
//               ? Environment.live
//               : Environment.test,
//           clientId: decryptedClientId,
//           secretId: decryptedSecretKey,
//         ),
//         esewaPayment: EsewaPayment(
//           productId: uuid,
//           productName: merchantName,
//           productPrice: total.toString(),
//           callbackUrl:
//               "${(EnvironmentConfig.isProd == "true") ? AppUrl.prodCallbackUrl : AppUrl.stagCallbackUrl}/extension/${paymentListData.data![paymentGatewayIndex].code}-success/$merchantDomain/$merchantLocation/${Provider.of<PlaceOrderProvider>(context, listen: false).firstPlaceOrderData.data!.orderCode}/",
//         ),
//         onPaymentSuccess: (EsewaPaymentSuccessResult data) {
//           Provider.of<PlaceOrderProvider>(context, listen: false)
//               .placeFinalOrder(context,
//                   cartPriceData: cpm,
//                   merchantLocation: merchantLocation,
//                   paymentExtensionTxnCode: data.refId,
//                   paymentExtensionCode:
//                       paymentListData.data![paymentGatewayIndex].code,
//                   status: paymentListData.data![paymentGatewayIndex].details
//                       .firstWhere((element) => element.key == "success_status",
//                           orElse: () => Details(
//                               key: "success_status", value: "new_order"))
//                       .value);
//           debugPrint(":::SUCCESS::: => $data");
//         },
//         onPaymentFailure: (data) {
//           debugPrint(":::FAILURE::: => $data");
//         },
//         onPaymentCancellation: (data) {
//           debugPrint(":::CANCELLATION::: => $data");
//         },
//       );
//     } on Exception catch (e) {
//       debugPrint("EXCEPTION : ${e.toString()}");
//     }
//   }

//   onGeneralCall(
//     BuildContext context, {
//     required String firstDecryptKey,
//     required double total,
//     required CartPriceModel cpm,
//     required String merchantName,
//     required String merchantLocation,
//     required String merchantDomain,
//     required int paymentGatewayIndex,
//     required String uuid,
//   }) async {
//     //TODO: Make paymentExtensionTxnCode dynamic
//     Provider.of<PlaceOrderProvider>(context, listen: false).placeFinalOrder(
//         context,
//         cartPriceData: cpm,
//         merchantLocation: merchantLocation,
//         paymentExtensionTxnCode: "",
//         paymentExtensionCode: paymentListData.data![paymentGatewayIndex].code,
//         status: paymentListData.data![paymentGatewayIndex].details
//             .firstWhere((element) => element.key == "success_status",
//                 orElse: () =>
//                     Details(key: "success_status", value: "new_order"))
//             .value);
//   }

//   Future<void> fetchPaymentGetway(
//     Map body, {
//     required int merchantId,
//   }) async {
//     setPaymentGateway(ApiResponse.loading());
//     await _paymentGatewayApi
//         .fetchPaymentGateway(body, merchantId: merchantId)
//         .then((value) {
//       // khaltiPublicKey = AppUrl.khaltiLiveKey;
//       // List<PaymentGateway> temp = [...value];
//       // List<PaymentGateway> data =
//       //     temp.where((element) => element.code == "khalti").toList();
//       // if (data.isNotEmpty) {
//       //   khaltiPublicKey = data.first.details
//       //       .firstWhere((element) => element.key == "secret_key")
//       //       .value;
//       // }
//       setPaymentGateway(ApiResponse.completed(value));
//     }).onError((error, stackTrace) {
//       log(error.toString());
//       setPaymentGateway(ApiResponse.error(error.toString()));
//     });
//   }

//   createPaymentIntent(
//       {required double amount,
//       required String currency,
//       required String secretKey}) async {
//     try {
//       //Request body
//       Map<String, dynamic> body = {
//         "amount": amount.toString(),
//         "currency": currency,
//       };

//       //Make post request to Stripe
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $secretKey',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       log(response.body);
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }
// }
