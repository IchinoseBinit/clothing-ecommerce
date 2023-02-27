import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/data/constants/image_constants.dart';
import '/data/response/status.dart';
import '/providers/cart_price_provider.dart';
import '/providers/coupon_provider.dart';
import '/providers/hive_database_helper.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/widgets/checkout_bottom_nav.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/each_price_item.dart';
import '/widgets/error_info_widget.dart';
import '/widgets/general_textfield.dart';
import '/widgets/offer_info.dart';

class CheckoutScreen extends StatefulWidget {
  final int merchantId;
  final bool isFromDetail;
  const CheckoutScreen({
    Key? key,
    required this.merchantId,
    this.isFromDetail = false,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Address? _pickedLocation;

  // void _selectPlace(double lat, double lon) {
  //   _pickedLocation = Address(coordinates: [lat, lon], type: "Point");
  //   print(_pickedLocation!.coordinates.toString());
  //   Provider.of<LocationProvider>(context, listen: false)
  //       .setLocation(address: _pickedLocation);
  // }

  Map? databaseData;
  late dynamic latitude;
  late dynamic longitude;
  bool isInit = true;
  late Map merchantData;

  final _notesController = TextEditingController();

  _apiCall({bool isRefreshContent = false}) async {
    databaseData = await DatabaseHelper().getBoxItem(key: "cart");
    latitude = await DatabaseHelper().getBoxItem(key: "latitude");
    longitude = await DatabaseHelper().getBoxItem(key: "longitude");
    if (databaseData != null) {
      if (databaseData?[widget.merchantId] != null) {
        merchantData = databaseData![widget.merchantId];
        Map body = {
          "items": [
            for (Map item in merchantData["items"])
              {"id": item["itemId"], "quantity": item["quantity"]}
          ],
          "merchant_location": merchantData["locationId"],
          "delivery_type": merchantData["deliveryType"],
          "latitude": double.parse(latitude),
          "longitude": double.parse(longitude),
          if (Provider.of<CouponProvider>(context, listen: false)
                  .selectedCoupon !=
              "")
            "coupon_code": Provider.of<CouponProvider>(context, listen: false)
                .selectedCoupon,
        };
        CartPriceProvider cartPriceProvider =
            Provider.of<CartPriceProvider>(context, listen: false);
        await cartPriceProvider.fetchCartPrice(body,
            isRefreshContent: isRefreshContent);
        if (merchantData["deliveryType"] == "delivery" &&
            cartPriceProvider.cartPriceData.data!.deliveryFee == -1) {
          // _checkDeliveryIsLocationIsValid(isDelivery: true);
        }

        if (cartPriceProvider.cartPriceData.data!.invalidItems.isNotEmpty) {
          // await _checkIsValidItems(cpm: cartPriceProvider.cartPriceData.data!);
        }

      }
    }
  }




  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      Provider.of<CouponProvider>(context, listen: false)
          .setCoupon("", noNotifier: true);
      await _apiCall();

      isInit = false;
    }
  }


  @override
  void dispose() {
    _notesController.clear();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartPriceProvider>(builder: (_, cartPriceProvider, __) {
      switch (cartPriceProvider.cartPriceData.status) {
        case Status.LOADING:
          return Scaffold(
            appBar: CustomAppBar(
              title: "Checkout",
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        case Status.ERROR:
          return Scaffold(
            appBar: CustomAppBar(
              title: "Checkout",
            ),
            body: ErrorInfoWidget(
              isCart: true,
            ),
          );

        case Status.COMPLETED:
          String notes = _notesController.text;
          return Stack(
            children: [
              Scaffold(
                bottomNavigationBar: databaseData?[widget.merchantId] != null
                    ? CheckoutBottomNav(
                        onSubmit: () {
                          //TODO: I have commented this to solve recurrent api call, I shall we need it. Decide if there is error
                          // _apiCall();
                        },
                        notes: notes,
                        merchantId: widget.merchantId,
                        totalPrice:
                            cartPriceProvider.cartPriceData.data!.total,
                        merchantData: merchantData,
                        callDeliverySection: () async {
                          // await _checkTimeIsNotValid();
                        },
                      )
                    : null,
                appBar: CustomAppBar(
                  title: merchantData["name"],
                  leadingFunc: widget.isFromDetail
                      ? () {
                        }
                      : null,
                ),
                body: ScrollConfiguration(
                  behavior: MyBehaviour(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // _selectMap(
                            //     isDelivery: cartPriceProvider
                            //             .cartPriceData.data!.deliveryType ==
                            //         "delivery");
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(right: 32.w, left: 16.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SvgPicture.asset(
                                  locationIcon,
                                  height: AppSizes.iconHeight,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      merchantData["deliveryType"] ==
                                              "delivery"
                                          ? "Delivery Location"
                                          : "Merchant Location",
                                      style: bodyText.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width *
                                              .70,
                                      child: Text(
                                          "Jaybageshowri kathmandu",
                                          softWrap: true,
                                          maxLines: 3,
                                          style: smallText.copyWith(
                                            color:
                                                AppColors.textSoftGreyColor,
                                          )),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.sp,
                                  color: AppColors.primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 20.h,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingLg,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Items",
                                    style: subTitleText.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      _apiCall(isRefreshContent: true);
                                    },
                                    child: Text(
                                      "Add Items",
                                      style: bodyText.copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: AppSizes.paddingLg,
                              ),
                              cartPriceProvider.cartPriceData.data!.items
                                      .where((element) =>
                                          element.selectedQuantity != 0)
                                      .toList()
                                      .isEmpty
                                  ? const ErrorInfoWidget(
                                      heightFactor: 2,
                                      isCart: true,
                                      errorInfo:
                                          "Your cart is currently empty. Please add an item to proceed.",
                                    )
                                  : ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder: (__, _) =>
                                          const SizedBox(
                                              height: AppSizes.paddingLg),
                                      itemBuilder: (context, index) {
                                        return cartPriceProvider
                                                    .cartPriceData
                                                    .data!
                                                    .items[index]
                                                    .selectedQuantity ==
                                                0
                                            ? const SizedBox.shrink()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        cartPriceProvider
                                                            .cartPriceData
                                                            .data!
                                                            .items[index]
                                                            .name,
                                                        style:
                                                            bodyText.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          if (cartPriceProvider
                                                                  .cartPriceData
                                                                  .data!
                                                                  .items[
                                                                      index]
                                                                  .specialPrice !=
                                                              0.0)
                                                            Text(
                                                              "${cartPriceProvider.cartPriceData.data!.currency} ${cartPriceProvider.cartPriceData.data!.items[index].specialPrice.toStringAsFixed(2)}",
                                                              style:
                                                                  TextStyle(
                                                                color: AppColors
                                                                    .textDarkColor,
                                                                fontSize:
                                                                    12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          if (cartPriceProvider
                                                                  .cartPriceData
                                                                  .data!
                                                                  .items[
                                                                      index]
                                                                  .specialPrice !=
                                                              0.0)
                                                            SizedBox(
                                                              width: 4.w,
                                                            ),
                                                          Text(
                                                            "${cartPriceProvider.cartPriceData.data!.currency} ${cartPriceProvider.cartPriceData.data!.items[index].retailPrice.toStringAsFixed(2)}",
                                                            style: smallText.copyWith(
                                                                fontSize: cartPriceProvider.cartPriceData.data!.items[index].specialPrice !=
                                                                        0.0
                                                                    ? 10.sp
                                                                    : 12.sp,
                                                                color: cartPriceProvider.cartPriceData.data!.items[index].specialPrice !=
                                                                        0.0
                                                                    ? AppColors
                                                                        .greyColor
                                                                    : AppColors
                                                                        .textDarkColor,
                                                                fontWeight: cartPriceProvider
                                                                            .cartPriceData
                                                                            .data!
                                                                            .items[
                                                                                index]
                                                                            .specialPrice !=
                                                                        0.0
                                                                    ? FontWeight
                                                                        .normal
                                                                    : FontWeight
                                                                        .w500,
                                                                decoration: cartPriceProvider
                                                                            .cartPriceData
                                                                            .data!
                                                                            .items[index]
                                                                            .specialPrice !=
                                                                        0.0
                                                                    ? TextDecoration.lineThrough
                                                                    : null),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height:
                                                            AppSizes.padding,
                                                      ),
                                                      Container(
                                                        height: 26.h,
                                                        width: 100.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .lightPrimaryColor
                                                              .withOpacity(
                                                                  0.5),
                                                          border: Border.all(
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                AppSizes.radius *
                                                                    6),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            GestureDetector(
                                                              onTap:
                                                                  () async {
                                                                cartPriceProvider
                                                                    .decreaseQuantity(
                                                                  item: cartPriceProvider
                                                                      .cartPriceData
                                                                      .data!
                                                                      .items[index],
                                                                  merchantId:
                                                                      widget
                                                                          .merchantId,
                                                                );

                                                                _apiCall(
                                                                    isRefreshContent:
                                                                        true);
                                                              },
                                                              child:
                                                                  Container(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: AppSizes
                                                                            .padding *
                                                                        1.5),
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        AppSizes
                                                                            .radius),
                                                                  ),
                                                                ),
                                                                child: Icon(
                                                                  cartPriceProvider.cartPriceData.data!.items[index].selectedQuantity ==
                                                                          1
                                                                      ? Icons
                                                                          .delete_sweep_outlined
                                                                      : Icons
                                                                          .remove,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                cartPriceProvider
                                                                    .cartPriceData
                                                                    .data!
                                                                    .items[
                                                                        index]
                                                                    .selectedQuantity
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .primaryColor),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap:
                                                                  () async {
                                                                await cartPriceProvider
                                                                    .increaseQuantity(
                                                                  item: cartPriceProvider
                                                                      .cartPriceData
                                                                      .data!
                                                                      .items[index],
                                                                  merchantId:
                                                                      widget
                                                                          .merchantId,
                                                                );
                                                                _apiCall(
                                                                    isRefreshContent:
                                                                        true);
                                                              },
                                                              child:
                                                                  Container(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    right: AppSizes
                                                                            .padding *
                                                                        1.5),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        AppSizes
                                                                            .radius),
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      if (cartPriceProvider
                                                              .cartPriceData
                                                              .data!
                                                              .items[index]
                                                              .specialPriceTotal !=
                                                          0.0)
                                                        Text(
                                                          "${cartPriceProvider.cartPriceData.data!.currency} ${cartPriceProvider.cartPriceData.data!.items[index].specialPriceTotal.toStringAsFixed(2)}",
                                                          style: bodyText
                                                              .copyWith(
                                                            color: AppColors
                                                                .textDarkColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                          ),
                                                        ),
                                                      if (cartPriceProvider
                                                              .cartPriceData
                                                              .data!
                                                              .items[index]
                                                              .specialPriceTotal ==
                                                          0.0)
                                                        Text(
                                                          "${cartPriceProvider.cartPriceData.data!.currency} ${cartPriceProvider.cartPriceData.data!.items[index].retailPriceTotal.toStringAsFixed(2)}",
                                                          style: bodyText
                                                              .copyWith(
                                                            color: AppColors
                                                                .textDarkColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                          ),
                                                        ),
                                                    ],
                                                  )
                                                ],
                                              );
                                      },
                                      itemCount: cartPriceProvider
                                          .cartPriceData.data!.items
                                          .where((element) =>
                                              element.quantity != 0)
                                          .toList()
                                          .length,
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: AppSizes.paddingLg,
                        ),
                        if (databaseData?[widget.merchantId] != null)
                          Divider(
                            height: 0.h,
                          ),
                        const SizedBox(
                          height: AppSizes.padding,
                        ),
                        if (databaseData?[widget.merchantId] != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.paddingLg),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: AppSizes.padding,
                                ),
                                EachPriceItem(
                                    isSubTotal: true,
                                    title: "Subtotal",
                                    value:
                                        "${cartPriceProvider.cartPriceData.data!.currency} ${cartPriceProvider.cartPriceData.data!.subtotal.toStringAsFixed(2)}"),
                                if (cartPriceProvider
                                        .cartPriceData.data!.deliveryType ==
                                    "delivery")
                                  Column(
                                    children: [
                                      if (cartPriceProvider.cartPriceData
                                              .data!.deliveryFee !=
                                          -1)
                                        const SizedBox(
                                          height: AppSizes.padding,
                                        ),
                                      if (cartPriceProvider.cartPriceData
                                              .data!.deliveryFee !=
                                          -1)
                                        EachPriceItem(
                                            title: "Delivery Fee",
                                            value:
                                                "${cartPriceProvider.cartPriceData.data!.currency} ${cartPriceProvider.cartPriceData.data!.deliveryFee.toStringAsFixed(2)}",
                                            isDeliveryFree: cartPriceProvider
                                                    .cartPriceData
                                                    .data!
                                                    .deliveryFee ==
                                                0),
                                    ],
                                  ),
                                if (cartPriceProvider
                                        .cartPriceData.data!.couponCode !=
                                    "")
                                  const SizedBox(
                                    height: AppSizes.padding,
                                  ),
                                if (cartPriceProvider
                                            .cartPriceData.data!.couponCode !=
                                        "" &&
                                    cartPriceProvider
                                            .cartPriceData.data!.discount
                                            .toStringAsFixed(2) !=
                                        "-1.00")
                                  // if (Provider.of<CouponProvider>(context,
                                  //             listen: false)
                                  //         .selectedCoupon !=
                                  //     "")
                                  EachPriceItem(
                                    hasPromo: true,
                                    // promoCode: cartPriceProvider
                                    //     .cartPriceData.data!.couponCode,
                                    title: "Discount",
                                    value: cartPriceProvider.cartPriceData
                                                .data!.discount ==
                                            0.0
                                        ? ""
                                        : "${cartPriceProvider.cartPriceData.data!.currency} ${cartPriceProvider.cartPriceData.data!.discount.toStringAsFixed(2)}",
                                  ),
                              ],
                            ),
                          ),
                        if (databaseData?[widget.merchantId] != null)
                          Divider(
                            height: 20.h,
                          ),
                        if (databaseData?[widget.merchantId] != null)
                          const SizedBox(
                            height: AppSizes.padding / 2,
                          ),
                        if (databaseData?[widget.merchantId] != null)
                          OfferInfo(
                            merchantId: widget.merchantId,
                            onBtnTap: (value) async {
                              CouponProvider couponProvider =
                                  Provider.of<CouponProvider>(context,
                                      listen: false);
                              if (value != null) {
                                if (value == "") {
                                  couponProvider.setCoupon("");
                                  await _apiCall(isRefreshContent: true);
                                } else {
                                  Navigator.pop(context);
                                  couponProvider.setCoupon(value);
                                  await _apiCall(isRefreshContent: true);
                                }
                              }
                            },
                          ),
                        if (databaseData?[widget.merchantId] != null)
                          const SizedBox(
                            height: AppSizes.padding / 2,
                          ),
                        if (databaseData?[widget.merchantId] != null)
                          Divider(
                            height: 20.h,
                          ),
                        if (databaseData?[widget.merchantId] != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingLg,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Notes",
                                  style: bodyText.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSizes.padding / 2,
                                ),
                                GeneralTextField(
                                  isTextArea: true,
                                  controller: _notesController,
                                  obscureText: false,
                                  keywordType: TextInputType.text,
                                  validate: (_) {},
                                  onFieldSubmit: (_) {},
                                  textInputAction: TextInputAction.done,
                                  onSave: (_) {},
                                  hintText: "Any special request.",
                                  maxLines: 3,
                                  fillColor: AppColors.inputColor,
                                  borderColor: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: AppSizes.padding * 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (cartPriceProvider.contentRefreshLoading)
                Stack(
                  children: const [
                    ModalBarrier(
                      barrierSemanticsDismissible: false,
                      dismissible: false,
                    ),
                    Center(child: CircularProgressIndicator())
                  ],
                ),
            ],
          );
        default:
          return const SizedBox.shrink();
      }
    });
  }
}
