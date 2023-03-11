import 'dart:developer';

import 'package:clothing_ecommerce/widgets/general_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '/data/constants/image_constants.dart';
import '/models/cart_price_model.dart';
import '/providers/auth_provider.dart';
import '/providers/cart_price_provider.dart';
import '/providers/hive_database_helper.dart';
import '/screens/auth_screen/login_screen.dart';
import '/widgets/general_elevated_button.dart';
import '/screens/payment/payment_screen.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/navigation_util.dart';
import '/widgets/alert_bottom_sheet.dart';
import '/widgets/checkout_guest_bottomsheet.dart';
import '/widgets/each_price_item.dart';
import 'upper_part_bottom_sheet.dart';

class CheckoutBottomNav extends StatelessWidget {
  CheckoutBottomNav(
      {Key? key,
      this.callDeliverySection,
      required this.merchantData,
      required this.merchantId,
      required this.totalPrice,
      required this.notes,
      this.onSubmit})
      : super(key: key);
  final Function? callDeliverySection;
  final Function? onSubmit;
  final Map merchantData;
  late String alertDescription;
  final String notes;
  final int merchantId;
  final double totalPrice;
  // Future<DateTime> getMerchantTime(String timezoneName) async {
  //   await tz.initializeTimeZone('data/latest_all.tzf');
  //   tz.Location detroit = tz.getLocation(timezoneName);
  //   return tz.TZDateTime.now(detroit);
  // }
  // DateTime _getTimeFromLocationName(String locationName) {
  //   initializeTimeZones();
  //   var istanbulTimeZone = getLocation(locationName);
  //   return TZDateTime.now(istanbulTimeZone);
  // }

  _onSubmit(context, {required CartPriceModel model}) async {
    String? token = await DatabaseHelper().getBoxItem(key: "access_token");
    //  DateTime now=
    // await getMerchantTime('America/Detroit');
    if (merchantData["timeslot"] != null) {
      // final now = _getTimeFromLocationName(merchantData["timezoneLoc"]);
      log(
          DateTime.parse(
                  "${(merchantData["timeslot"][0] as DateTime).toIso8601String().substring(0, 19)}${merchantData["timezone"]}")
              .toIso8601String(),
          name: "User Time");
      if (DateTime.parse(
              "${(merchantData["timeslot"][0] as DateTime).toIso8601String().substring(0, 19)}${merchantData["timezone"]}")
          .isBefore(DateTime.now())) {
        alertDescription =
            "Unfortunately, the selected time has expired. Please choose a new time to proceed with checking out the items in your cart.";
        await _showAlert(context, desc: alertDescription);
        return;
      }
    } else {
      alertDescription =
          "It seems that you have not selected a time. Please choose a time to proceed with checking out the items in your cart.";
      await _showAlert(context, desc: alertDescription);
      return;
    }

    if (merchantData["timeslot"] != null && token == null) {
      await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          )),
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const UpperContentBottomSheet(title: "Checkout"),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GeneralElevatedButton(
                          title: "Login / Register",
                          marginH: 0,
                          onPressed: () async {
                            Provider.of<AuthProvider>(context, listen: false)
                                .setIsGuest(true);
                            await navigate(context, const LoginScreen());
                            String? token = await DatabaseHelper()
                                .getBoxItem(key: "access_token");
                            if (token != null) {
                              onSubmit!();
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSizes.paddingLg,
                        ),
                        GeneralTextButton(
                          title: "Checkout As Guest",
                          marginH: 0,
                          onPressed: () async {
                            Provider.of<CartPriceProvider>(context,
                                    listen: false)
                                .setGuestUser(null);

                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              enableDrag: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              )),
                              builder: (context) =>
                                  const CheckoutGuestBottomSheet(),
                            );

                            if (Provider.of<CartPriceProvider>(context,
                                        listen: false)
                                    .guestUser !=
                                null) {
                              navigate(
                                context,
                                PaymentScreen(
                                  notes: notes,
                                  merchantData: merchantData,
                                  merchantName: merchantData["name"],
                                  merchantId: merchantId,
                                  cartPriceModel: model,
                                  isGuest: true,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSizes.padding * 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ));
    }
    if (merchantData["timeslot"] != null && token != null) {
      navigate(
        context,
        PaymentScreen(
          notes: notes,
          merchantData: merchantData,
          merchantName: merchantData["name"],
          merchantId: merchantId,
          cartPriceModel: model,
          isGuest: false,
        ),
      );
    }
    //TODO: call navigate to checkout screen
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartPriceProvider>(builder: (_, cartPriceProvider, __) {
      return Container(
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
            if (cartPriceProvider.cartPriceData.data!.deliveryType ==
                "delivery")
              Column(
                children: [
                  if (cartPriceProvider.cartPriceData.data!.subtotal <
                      cartPriceProvider.cartPriceData.data!.minimumOrder)
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingLg),
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.alertBgColor,
                      child: Text(
                        "${cartPriceProvider.cartPriceData.data!.currency} ${(cartPriceProvider.cartPriceData.data!.minimumOrder - cartPriceProvider.cartPriceData.data!.subtotal).toStringAsFixed(2)} more to min order of ${cartPriceProvider.cartPriceData.data!.currency} ${cartPriceProvider.cartPriceData.data!.minimumOrder.toStringAsFixed(2)}.",
                        style: smallText.copyWith(
                          fontWeight: FontWeight.normal,
                          color: AppColors.alertTextColor,
                        ),
                      ),
                    ),
                  if (cartPriceProvider.cartPriceData.data!.deliveryFee == -1)
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingLg),
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.alertBgColor,
                      child: Text(
                        "No delivery available at selected location.",
                        style: smallText.copyWith(
                          fontWeight: FontWeight.normal,
                          color: AppColors.alertTextColor,
                        ),
                      ),
                    ),
                  if (!(cartPriceProvider.cartPriceData.data!.subtotal <
                      cartPriceProvider.cartPriceData.data!.minimumOrder))
                    if (cartPriceProvider
                                .cartPriceData.data!.freeDeliveryLimit !=
                            -1 &&
                        cartPriceProvider.cartPriceData.data!.subtotal <
                            cartPriceProvider
                                .cartPriceData.data!.freeDeliveryLimit)
                      Container(
                        padding: const EdgeInsets.all(AppSizes.paddingLg),
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.alertBgColor,
                        child: Text(
                          "${cartPriceProvider.cartPriceData.data!.currency} ${(cartPriceProvider.cartPriceData.data!.freeDeliveryLimit - cartPriceProvider.cartPriceData.data!.subtotal).toStringAsFixed(2)} more to get free delivery.",
                          style: smallText.copyWith(
                            fontWeight: FontWeight.normal,
                            color: AppColors.alertTextColor,
                          ),
                        ),
                      ),
                ],
              ),
            const SizedBox(
              height: AppSizes.padding,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(AppSizes.padding),
              width: MediaQuery.of(context).size.width,
              child: EachPriceItem(
                  title: "Total",
                  taxPer: cartPriceProvider.cartPriceData.data!.taxPer,
                  value:
                      "${cartPriceProvider.cartPriceData.data!.currency} ${cartPriceProvider.cartPriceData.data!.total.toStringAsFixed(2)}",
                  isTotal: true,
                  hasTax:
                      (cartPriceProvider.cartPriceData.data!.taxAmt != null &&
                              cartPriceProvider.cartPriceData.data!.taxAmt! > 0)
                          ? true
                          : false),
            ),
            GeneralElevatedButton(
                height: 45.h,
                isDisabled: cartPriceProvider
                                .cartPriceData.data!.deliveryType ==
                            "delivery" &&
                        (cartPriceProvider.cartPriceData.data!.subtotal <
                            cartPriceProvider
                                .cartPriceData.data!.minimumOrder) ||
                    (cartPriceProvider.cartPriceData.data!.deliveryFee == -1),
                title: "Checkout",
                onPressed: () async {
                  await _onSubmit(context,
                      model: cartPriceProvider.cartPriceData.data!);
                  //TODO: Go Payment screen
                  if (onSubmit != null) {
                    onSubmit!();
                  }
                },
                marginH: AppSizes.padding),
            const SizedBox(
              height: AppSizes.padding * 3,
            )
          ],
        ),
      );
    });
  }

  _showAlert(context, {required String desc}) async {
    await AlertBottomSheet.showAlertBottomSheet(
      context,
      title: "Select Time",
      description: desc,
      iconImage: alert,
      cancelTitle: "Cancel",
      okTitle: "Select Time",
      isCancelButton: true,
      okFunc: () {
        if (callDeliverySection != null) {
          callDeliverySection!();
        }
      },
      cancelFunc: () {
        Navigator.pop(context);
      },
    );
  }
}
