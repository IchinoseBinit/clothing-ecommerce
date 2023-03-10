import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '/data/constants/image_constants.dart';
import '/models/cart_price_model.dart';
import '/providers/cart_price_provider.dart';
import '/providers/place_order_provider.dart';
import '/screens/merchant_list/widgets/general_elevated_button.dart';
import '/screens/navigation_screen.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/navigation_util.dart';
import '/utils/will_pop_scope.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/each_price_item.dart';
import '../payment/payment_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceOrderProvider>(builder: (_, orderProvider, __) {
      final bool isDelivery =
          orderProvider.firstPlaceOrderData.data!.orderType == "delivery";
      return WillPopScope(
        onWillPop: () async =>
            await WillPopScopeClass.willPopCallback(context) ?? false,
        child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 12,
                  spreadRadius: 8,
                  color: Colors.grey.withOpacity(0.25),
                ),
              ],
              color: Colors.white,
            ),
            // height: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: AppSizes.paddingLg,
                ),
                GeneralElevatedButton(
                  title: "Done",
                  marginH: AppSizes.paddingLg,
                  onPressed: () {
                    navigate(context, const NavigationScreen());
                  },
                ),
                const SizedBox(
                  height: AppSizes.padding * 3,
                )
              ],
            ),
          ),
          appBar: CustomAppBar(
            title: "Order Confirmed",
            disableLeading: true,
          ),
          body: ScrollConfiguration(
            behavior: MyBehaviour(),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSizes.padding * 4,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        isDelivery ? delivery : selfCollection,
                        height: 120.h,
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.paddingLg,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingLg,
                      ),
                      child: Text.rich(
                        TextSpan(
                          text:
                              "Hi ${orderProvider.firstPlaceOrderData.data!.customerName},\nThanks for ordering from ",
                          style: bodyText.copyWith(
                            color: AppColors.textSoftGreyColor,
                          ),
                          children: [
                            TextSpan(
                              text: orderProvider
                                  .firstPlaceOrderData.data!.merchantInfo.name,
                              style: bodyText.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.paddingLg,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingLg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Reference",
                            style: subTitleText.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "#${orderProvider.firstPlaceOrderData.data!.orderCode}",
                            style: bodyText.copyWith(
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.paddingLg,
                    ),
                    CollectionInfo(merchantData: {
                      "address": orderProvider
                          .firstPlaceOrderData.data!.deliveryAddress,
                      "deliveryType":
                          orderProvider.firstPlaceOrderData.data!.orderType,
                    }),
                    const SizedBox(
                      height: AppSizes.paddingLg,
                    ),
                    Divider(
                      height: 0.h,
                    ),
                    const SizedBox(height: AppSizes.padding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppSizes.padding),
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.padding),
                          child: Text(
                            "Order Summary",
                            style: subTitleText.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppSizes.padding),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.padding,
                            ),
                            child: Column(
                              children: [
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: AppSizes.padding),
                                  itemCount: Provider.of<CartPriceProvider>(
                                          context,
                                          listen: false)
                                      .cartPriceData
                                      .data!
                                      .items
                                      .length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                            text:
                                                Provider.of<CartPriceProvider>(
                                                        context,
                                                        listen: false)
                                                    .cartPriceData
                                                    .data!
                                                    .items[index]
                                                    .quantity
                                                    .toString(),
                                            style: bodyText.copyWith()),
                                        TextSpan(
                                          text: " x ",
                                          style: bodyText.copyWith(
                                              color:
                                                  AppColors.textLightGreyColor),
                                        ),
                                        TextSpan(
                                          text: Provider.of<CartPriceProvider>(
                                                  context,
                                                  listen: false)
                                              .cartPriceData
                                              .data!
                                              .items[index]
                                              .name
                                              .toString(),
                                          style: bodyText.copyWith(
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ])),
                                      Text(
                                        "${Provider.of<CartPriceProvider>(context, listen: false).cartPriceData.data!.currency} ${Provider.of<CartPriceProvider>(context, listen: false).cartPriceData.data!.items[index].specialPriceTotal != 0.0 ? Provider.of<CartPriceProvider>(context, listen: false).cartPriceData.data!.items[index].specialPriceTotal.toStringAsFixed(2) : Provider.of<CartPriceProvider>(context, listen: false).cartPriceData.data!.items[index].retailPriceTotal.toStringAsFixed(2)}",
                                        style: bodyText.copyWith(
                                          color: AppColors.textDarkColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),

                                  //     EachPriceItem(
                                  //   title:
                                  //       "${Provider.of<CartPriceProvider>(context,
                                  //       listen: false)
                                  //   .cartPriceData
                                  //   .data!
                                  // .items[index].quantity} X ${Provider.of<CartPriceProvider>(context,
                                  //       listen: false)
                                  //   .cartPriceData
                                  //   .data!
                                  // .items[index].name}",
                                  //   value:
                                  //       "${widget.cartPriceModel.currency} ${Provider.of<CartPriceProvider>(context,
                                  //       listen: false)
                                  //   .cartPriceData
                                  //   .data!
                                  // .items[index].specialPriceTotal != 0.0 ? Provider.of<CartPriceProvider>(context,
                                  //       listen: false)
                                  //   .cartPriceData
                                  //   .data!
                                  // .items[index].specialPriceTotal.toStringAsFixed(2) : Provider.of<CartPriceProvider>(context,
                                  //       listen: false)
                                  //   .cartPriceData
                                  //   .data!
                                  // .items[index].retailPriceTotal.toStringAsFixed(2)}",
                                  // ),
                                )

                                // ...Provider.of<CartPriceProvider>(context,
                                //         listen: false)
                                //     .cartPriceData
                                //     .data!
                                //     .items
                                //     .map(
                                //       (e) => Padding(
                                //         padding: const EdgeInsets.only(
                                //           bottom: AppSizes.padding,
                                //         ),
                                //         child: EachPriceItem(
                                //           title: "${e.quantity} x ${e.name}",
                                //           value:
                                //               "${orderProvider.firstPlaceOrderData.data!.currency} ${(e.specialPriceTotal == 0.0 ? e.retailPriceTotal : e.specialPriceTotal).toStringAsFixed(2)}",
                                //         ),
                                //       ),
                                //     )
                                //     .toList(),
                                ,
                                Divider(
                                  height: 16.h,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      EachPriceItem(
                                          isSubTotal: true,
                                          title: "Subtotal",
                                          value:
                                              "${Provider.of<CartPriceProvider>(context, listen: false).cartPriceData.data!.currency} ${Provider.of<CartPriceProvider>(context, listen: false).cartPriceData.data!.subtotal.toStringAsFixed(2)}"),
                                      const SizedBox(height: AppSizes.padding),
                                      if (Provider.of<CartPriceProvider>(
                                                      context,
                                                      listen: false)
                                                  .cartPriceData
                                                  .data!
                                                  .deliveryType ==
                                              "delivery" &&
                                          Provider.of<CartPriceProvider>(
                                                      context,
                                                      listen: false)
                                                  .cartPriceData
                                                  .data!
                                                  .deliveryFee !=
                                              -1)
                                        EachPriceItem(
                                            title: "Delivery Fee",
                                            value:
                                                "${Provider.of<CartPriceProvider>(context, listen: false).cartPriceData.data!.currency} ${Provider.of<CartPriceProvider>(context, listen: false).cartPriceData.data!.deliveryFee.toStringAsFixed(2)}",
                                            isDeliveryFree:
                                                Provider.of<CartPriceProvider>(
                                                            context,
                                                            listen: false)
                                                        .cartPriceData
                                                        .data!
                                                        .deliveryFee ==
                                                    0),
                                      if (Provider.of<CartPriceProvider>(
                                                      context,
                                                      listen: false)
                                                  .cartPriceData
                                                  .data!
                                                  .deliveryType ==
                                              "delivery" &&
                                          Provider.of<CartPriceProvider>(
                                                      context,
                                                      listen: false)
                                                  .cartPriceData
                                                  .data!
                                                  .deliveryFee !=
                                              -1)
                                        if (Provider.of<CartPriceProvider>(
                                                    context,
                                                    listen: false)
                                                .cartPriceData
                                                .data!
                                                .discount >
                                            0)
                                          const SizedBox(
                                            height: AppSizes.padding,
                                          ),
                                      if (Provider.of<CartPriceProvider>(
                                                  context,
                                                  listen: false)
                                              .cartPriceData
                                              .data!
                                              .discount >
                                          0)
                                        EachPriceItem(
                                            title: "Discount:",
                                            value:
                                                "${Provider.of<CartPriceProvider>(context, listen: false).cartPriceData.data!.currency} ${Provider.of<CartPriceProvider>(context, listen: false).cartPriceData.data!.discount.toStringAsFixed(2)}",
                                            hasPromo: true,
                                            promoCode:
                                                Provider.of<CartPriceProvider>(
                                                        context,
                                                        listen: false)
                                                    .cartPriceData
                                                    .data!
                                                    .couponCode),
                                      Divider(
                                        height: 16.h,
                                      ),
                                      EachPriceItem(
                                          title: "Total",
                                          isTotal: true,
                                          hasTax: true,
                                          taxPer:
                                              Provider.of<CartPriceProvider>(
                                                      context,
                                                      listen: false)
                                                  .cartPriceData
                                                  .data!
                                                  .taxPer,
                                          value:
                                              "${orderProvider.firstPlaceOrderData.data!.currency} ${orderProvider.firstPlaceOrderData.data!.grandTotal}")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSizes.padding * 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingLg),
                          child: Center(
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                  text: "For more enquires, call us at ",
                                  style: smallText.copyWith(
                                    color: AppColors.textSoftGreyColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launchUrl(Uri.parse(
                                              "tel:${orderProvider.firstPlaceOrderData.data!.merchantInfo.contactNumber}"));
                                        },
                                      text: orderProvider.firstPlaceOrderData
                                          .data!.merchantInfo.contactNumber,
                                      style: smallText.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: "\n",
                                      style: smallText.copyWith(
                                        color: AppColors.textSoftGreyColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " or\n",
                                      style: smallText.copyWith(
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.textSoftGreyColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Email to ",
                                      style: smallText.copyWith(
                                        color: AppColors.textSoftGreyColor,
                                      ),
                                    ),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launchUrl(Uri.parse(
                                              "mailto:${orderProvider.firstPlaceOrderData.data!.merchantInfo.contactEmail}"));
                                        },
                                      text: orderProvider.firstPlaceOrderData
                                          .data!.merchantInfo.contactEmail,
                                      style: smallText.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSizes.padding * 4,
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      );
    });
  }

  SizedBox eachPriceItem(context,
      {required String title,
      required String value,
      bool isTotal = false,
      bool isDeliveryFree = false,
      bool hasPromo = false,
      CartPriceModel? model,
      bool hasTax = false,
      String? promoCode}) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                child: Text(title,
                    style: smallText.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: isTotal ? 14.sp : 12.sp,
                      fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
                    )),
              ),
              if (hasPromo && promoCode != null)
                Text(
                  " ( ",
                  style: smallText.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor),
                ),
              if (hasPromo && promoCode != null)
                Text(
                  promoCode,
                  style: smallText.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor),
                ),
              if (hasPromo && promoCode != null)
                Text(
                  " )",
                  style: smallText.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor),
                ),
              if (hasTax)
                Text(
                  " (incl. ${model!.taxPer.toInt()}% VAT)",
                  style: smallText.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700),
                ),
            ],
          ),
          if (!isDeliveryFree)
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Text(
                hasPromo ? "- $value" : value,
                textAlign: TextAlign.end,
                style: smallText.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: isTotal ? 14.sp : 12.sp,
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          if (isDeliveryFree)
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightPrimaryColor,
                borderRadius: BorderRadius.circular(AppSizes.radius),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding, vertical: AppSizes.padding / 2),
              child: const Text(
                "Free",
                style: TextStyle(color: AppColors.primaryColor),
              ),
            )
        ],
      ),
    );
  }
}
