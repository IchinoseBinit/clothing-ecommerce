// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// import '/data/constants/image_constants.dart';
// import '/data/response/api_response.dart';
// import '/data/response/status.dart';
// import '/models/cart_price_model.dart';
// import '/models/payment_gateway_model.dart';
// import '/models/profile_model.dart';
// import '/providers/cart_price_provider.dart';
// import '/providers/payment_gateway_provider.dart';
// import '/providers/place_order_provider.dart';
// import '/providers/profile_provider.dart';
// import '/styles/app_colors.dart';
// import '/styles/app_sizes.dart';
// import '/styles/styles.dart';
// import '/widgets/checkout_guest_bottomsheet.dart';
// import '/widgets/custom_appbar.dart';
// import '/widgets/each_price_item.dart';
// import '/widgets/error_info_widget.dart';

// class PaymentScreen extends StatefulWidget {
//   final bool isGuest;
//   final int merchantId;
//   final String merchantName;
//   final String notes;
//   final bool isFromDetail;
//   final Map merchantData;
//   final CartPriceModel cartPriceModel;
//   const PaymentScreen({
//     Key? key,
//     required this.merchantName,
//     required this.merchantId,
//     this.isFromDetail = false,
//     this.isGuest = false,
//     required this.cartPriceModel,
//     required this.merchantData,
//     required this.notes,
//   }) : super(key: key);

//   @override
//   State<PaymentScreen> createState() => PaymentScreenState();
// }

// class PaymentScreenState extends State<PaymentScreen> {
//   bool isInit = true;
//   bool isDataUpdate = true;
//   String name = "";
//   String email = "";
//   String phoneNumber = "";
//   _apiCall() async {
//     PaymentGatewayProvider paymentGatewayProvider =
//         Provider.of<PaymentGatewayProvider>(context, listen: false);
//     paymentGatewayProvider.setPaymentGateway(ApiResponse.loading());
//     if (!widget.isGuest) {
//       await Provider.of<ProfileProvider>(context, listen: false)
//           .fetchProfileApi(noNotifer: false);
//     }
//     await paymentGatewayProvider.fetchPaymentGetway(
//       {
//         "total_price": widget.cartPriceModel.total.toString(),
//       },
//       merchantId: widget.merchantId,
//     );
//   }

//   @override
//   void didChangeDependencies() async {
//     super.didChangeDependencies();

//     if (isInit) {
//       await _apiCall();
//       isInit = false;
//     }
//   }

//   _onPayment(
//       {required PaymentGatewayProvider paymentGatewayProvider,
//       required int index}) async {
//     bool continueProgram = await Provider.of<PlaceOrderProvider>(context,
//             listen: false)
//         .placeInitialOrder(
//             name: name,
//             email: email,
//             phoneNumber: phoneNumber,
//             notes: widget.notes,
//             status: paymentGatewayProvider.paymentListData.data![index].details
//                 .firstWhere(
//                   (element) => element.key == "initial_status",
//                   orElse: () => Details(
//                       key: "initial_status", value: "to_payment_gateway"),
//                 )
//                 .value,
//             cartPriceData: widget.cartPriceModel,
//             merchantData: widget.merchantData,
//             paymentExtension: paymentGatewayProvider
//                 .paymentListData.data![index].id
//                 .toString(),
//             deliveryLocation:
//                 "Koteshowr Kathmandu");
//     if (continueProgram) {
//       paymentGatewayProvider.onPayment(
//         context,
//         merchantLocation: widget.merchantId.toString(),
//         cpm: widget.cartPriceModel,
//         domainkey: widget.merchantData["domain"],
//         merchantKey: widget.merchantData["merchantKey"],
//         country: widget.merchantData["country"],
//         currency: widget.merchantData["currency"],
//         paymentGatewayIndex: index,
//         paymentGatewayCode:
//             paymentGatewayProvider.paymentListData.data![index].code,
//         merchantName: widget.merchantName,
//         total: widget.cartPriceModel.total,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PaymentGatewayProvider>(
//         builder: (_, paymentGatewayProvider, __) {
//       return Consumer<ProfileProvider>(builder: (_, profileProvider, __) {
//         return Scaffold(
//           bottomNavigationBar: (paymentGatewayProvider.paymentListData.status ==
//                       Status.LOADING ||
//                   paymentGatewayProvider.paymentListData.status == Status.ERROR)
//               ? const SizedBox.shrink()
//               : Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         offset: const Offset(0, 0),
//                         blurRadius: 12,
//                         spreadRadius: 8,
//                         color: Colors.grey.withOpacity(0.25),
//                       ),
//                     ],
//                     color: Colors.white,
//                   ),
//                   child: Container(
//                     padding: const EdgeInsets.all(AppSizes.paddingLg),
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.white,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         EachPriceItem(
//                             taxPer: widget.cartPriceModel.taxPer,
//                             hasTax: (widget.cartPriceModel.taxAmt != null &&
//                                     widget.cartPriceModel.taxAmt! > 0)
//                                 ? true
//                                 : false,
//                             isTotal: true,
//                             title: "Total",
//                             value:
//                                 "${widget.cartPriceModel.currency.toString()} ${widget.cartPriceModel.total.toStringAsFixed(2)}"),
//                         const SizedBox(
//                           height: AppSizes.paddingLg,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//           appBar: CustomAppBar(
//             titleWidget: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AutoSizeText(
//                   widget.merchantName,
//                   maxFontSize: 22,
//                   minFontSize: 16,
//                   maxLines: 1,
//                 ),
//                 Text(
//                   "Payment",
//                   style: bodyText.copyWith(color: Colors.white),
//                 )
//               ],
//             ),
//             // toolbarHeight: 100,
//           ),
//           body: Builder(
//             builder: (_) {
//               switch (paymentGatewayProvider.paymentListData.status) {
//                 case Status.LOADING:
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );

//                 case Status.COMPLETED:

//                   return SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: AppSizes.paddingLg,
//                         ),
//                         Consumer<CartPriceProvider>(
//                             builder: (_, cartPriceProvider, __) {
//                           return Container(
//                               margin: const EdgeInsets.symmetric(
//                                 horizontal: AppSizes.paddingLg,
//                               ),
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: AppSizes.padding * 1.5,
//                                 horizontal: AppSizes.paddingLg,
//                               ),
//                               decoration: BoxDecoration(
//                                   color: AppColors.lightGreyBgColor,
//                                   borderRadius:
//                                       BorderRadius.circular(AppSizes.radius)),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(
//                                     height: AppSizes.padding,
//                                   ),
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 40.r,
//                                         backgroundColor:
//                                             AppColors.lightestPrimaryColor,
//                                         child: Text(
//                                           name
//                                               .split(" ")
//                                               .toList()
//                                               .map((String e) => e[0])
//                                               .toList()
//                                               .join(),
//                                           style: bigTitleText.copyWith(
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 8.w,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             name,
//                                             style: subTitleText.copyWith(
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                           SizedBox(
//                                             height: 2.h,
//                                           ),
//                                           Text(
//                                             email,
//                                             style: bodyText.copyWith(
//                                                 color: AppColors
//                                                     .textSoftGreyColor),
//                                           ),
//                                           Text(
//                                             phoneNumber,
//                                             style: bodyText.copyWith(
//                                                 color: AppColors
//                                                     .textSoftGreyColor),
//                                           ),
//                                           SizedBox(
//                                             height: 2.h,
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ));
//                         }),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: AppSizes.paddingLg),
//                           child: CollectionInfo(
//                             merchantData: widget.merchantData,
//                           ),
//                         ),
//                         Divider(
//                           height: 0.h,
//                         ),
//                         const SizedBox(height: AppSizes.padding),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.symmetric(
//                                   horizontal: AppSizes.padding),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: AppSizes.padding),
//                               child: Text(
//                                 "Order Summary",
//                                 style: subTitleText.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 4.h,
//                             ),
//                             Container(
//                               margin: const EdgeInsets.symmetric(
//                                   horizontal: AppSizes.padding),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: AppSizes.padding,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     ListView.separated(
//                                       physics:
//                                           const NeverScrollableScrollPhysics(),
//                                       separatorBuilder: (context, index) =>
//                                           const SizedBox(
//                                               height: AppSizes.padding),
//                                       itemCount:
//                                           widget.cartPriceModel.items.length,
//                                       shrinkWrap: true,
//                                       itemBuilder: (context, index) => Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text.rich(TextSpan(children: [
//                                             TextSpan(
//                                                 text: widget.cartPriceModel
//                                                     .items[index].quantity
//                                                     .toString(),
//                                                 style: bodyText.copyWith()),
//                                             TextSpan(
//                                               text: " x ",
//                                               style: bodyText.copyWith(
//                                                   color: AppColors
//                                                       .textLightGreyColor),
//                                             ),
//                                             TextSpan(
//                                               text: widget.cartPriceModel
//                                                   .items[index].name
//                                                   .toString(),
//                                               style: bodyText.copyWith(
//                                                 fontWeight: FontWeight.w500,
//                                                 height: 0,
//                                               ),
//                                             ),
//                                           ])),
//                                           Text(
//                                             "${widget.cartPriceModel.currency} ${widget.cartPriceModel.items[index].specialPriceTotal != 0.0 ? widget.cartPriceModel.items[index].specialPriceTotal.toStringAsFixed(2) : widget.cartPriceModel.items[index].retailPriceTotal.toStringAsFixed(2)}",
//                                             style: bodyText.copyWith(
//                                               color: AppColors.textDarkColor,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ],
//                                       ),

//                                       //     EachPriceItem(
//                                       //   title:
//                                       //       "${widget.cartPriceModel.items[index].quantity} X ${widget.cartPriceModel.items[index].name}",
//                                       //   value:
//                                       //       "${widget.cartPriceModel.currency} ${widget.cartPriceModel.items[index].specialPriceTotal != 0.0 ? widget.cartPriceModel.items[index].specialPriceTotal.toStringAsFixed(2) : widget.cartPriceModel.items[index].retailPriceTotal.toStringAsFixed(2)}",
//                                       // ),
//                                     ),
//                                     Divider(
//                                       height: 24.h,
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           EachPriceItem(
//                                               isSubTotal: true,
//                                               title: "Subtotal",
//                                               value:
//                                                   "${widget.cartPriceModel.currency} ${widget.cartPriceModel.subtotal.toStringAsFixed(2)}"),
//                                           const SizedBox(
//                                               height: AppSizes.padding),
//                                           if (widget.cartPriceModel.deliveryType ==
//                                                   "delivery" &&
//                                               widget.cartPriceModel
//                                                       .deliveryFee !=
//                                                   -1)
//                                             EachPriceItem(
//                                                 title: "Delivery Fee",
//                                                 value:
//                                                     "${widget.cartPriceModel.currency} ${widget.cartPriceModel.deliveryFee.toStringAsFixed(2)}",
//                                                 isDeliveryFree: widget
//                                                         .cartPriceModel
//                                                         .deliveryFee ==
//                                                     0),
//                                           if (widget.cartPriceModel
//                                                       .deliveryType ==
//                                                   "delivery" &&
//                                               widget.cartPriceModel
//                                                       .deliveryFee !=
//                                                   -1)
//                                             const SizedBox(
//                                               height: AppSizes.padding,
//                                             ),
//                                           if (widget.cartPriceModel.discount >
//                                               0)
//                                             EachPriceItem(
//                                                 title: "Discount:",
//                                                 value:
//                                                     "${widget.cartPriceModel.currency} ${widget.cartPriceModel.discount.toStringAsFixed(2)}",
//                                                 hasPromo: true,
//                                                 promoCode: widget
//                                                     .cartPriceModel.couponCode),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(
//                           height: 16.h,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: AppSizes.paddingLg,
//                           ),
//                           child: Text(
//                             "Select Payment Method",
//                             style: subTitleText.copyWith(
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 6.h,
//                         ),
//                         Consumer<CartPriceProvider>(
//                             builder: (_, cartPriceProvider, __) {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ListView.separated(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 separatorBuilder: (context, index) =>
//                                     const Divider(
//                                   height: 0,
//                                 ),
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) => ListTile(
//                                   onTap: () async {
//                                     _onPayment(
//                                       paymentGatewayProvider:
//                                           paymentGatewayProvider,
//                                       index: index,
//                                     );
//                                   },
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       vertical: AppSizes.padding / 2,
//                                       horizontal: AppSizes.paddingLg),
//                                   tileColor: Colors.white,
//                                   title: Text(
//                                       paymentGatewayProvider
//                                           .paymentListData.data![index].name,
//                                       style: bodyText),
//                                   trailing: const Icon(
//                                     Icons.arrow_forward_ios,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 itemCount: paymentGatewayProvider
//                                     .paymentListData.data!.length,
//                               ),
//                             ],
//                           );
//                         }),
//                       ],
//                     ),
//                   );
//                 case Status.ERROR:
//                   return const ErrorInfoWidget();

//                 default:
//                   return const SizedBox.shrink();
//               }
//             },
//           ),
//         );
//       });
//     });
//   }

// }

// class CollectionInfo extends StatelessWidget {
//   const CollectionInfo({
//     Key? key,
//     required this.merchantData,
//   }) : super(key: key);

//   final Map merchantData;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
//           padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
//           child: Text(
//             "${merchantData["deliveryType"] == "delivery" ? "Delivery" : "Self PickUp"} Information",
//             style: subTitleText.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 4.h,
//         ),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
//           padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               EachInfo(
//                 value: "Tue, Feb22 ,2023",
//                 icons: timeIcon,
//               ),
//               SizedBox(
//                 height: 2.h,
//               ),
//               EachInfo(
//                 value:
//                     "Koteshowr",
//                 icons: locationIcon,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class EachInfo extends StatelessWidget {
//   final String value;
//   final String icons;
//   const EachInfo({
//     Key? key,
//     required this.value,
//     required this.icons,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SvgPicture.asset(
//           icons,
//           height: 14.h,
//           width: 14.h,
//           color: AppColors.primaryColor,
//         ),
//         const SizedBox(
//           width: AppSizes.padding,
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: bodyText.copyWith(
//               color: AppColors.textSoftGreyColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
