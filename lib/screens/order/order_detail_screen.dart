import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '/data/constants/image_constants.dart';
import '/data/response/status.dart';
import '/models/order_detail_model.dart';
import '/providers/order_detail_provider.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/each_price_item.dart';
import '/widgets/error_info_widget.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderCode;
  const OrderDetailScreen({Key? key, required this.orderCode})
      : super(key: key);

  @override
  State<OrderDetailScreen> createState() => OrderDetailScreenState();
}

class OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    Provider.of<OrderDetailProvider>(context, listen: false)
        .fetchOrderDetail(widget.orderCode);
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        title: Provider.of<OrderDetailProvider>(
                  context,
                ).orderDetail.status ==
                Status.COMPLETED
            ? "Order #${Provider.of<OrderDetailProvider>(
                context,
              ).orderDetail.data!.orderCode}"
            : "Order",
      ),
      body:
          Consumer<OrderDetailProvider>(builder: (__, orderDetailProvider, _) {
        switch (orderDetailProvider.orderDetail.status) {
          case Status.ERROR:
            return const ErrorInfoWidget();

          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case Status.COMPLETED:
            return ScrollConfiguration(
              behavior: MyBehaviour(),
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: AppSizes.paddingLg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CollectionInfo(
                        orderDetailModel: orderDetailProvider.orderDetail.data!,
                        colorCode: int.parse(orderDetailProvider
                            .orderDetail.data!.statusColor
                            .replaceAll("#", "0xff")),
                        merchantName: orderDetailProvider
                            .orderDetail.data!.merchantInfo.name,
                        status: orderDetailProvider.orderDetail.data!.status,
                        deliveryTime:
                            orderDetailProvider.orderDetail.data!.deliveryTime,
                        deliveryLocation: orderDetailProvider
                            .orderDetail.data!.deliveryAddress,
                        isDelivery:
                            orderDetailProvider.orderDetail.data!.orderType ==
                                "delivery",
                        merchantLocation: orderDetailProvider
                            .orderDetail.data!.locationAddress,
                        merchantEmail: orderDetailProvider.orderDetail.data!
                                    .merchantInfo.contactEmail ==
                                ""
                            ? null
                            : orderDetailProvider
                                .orderDetail.data!.merchantInfo.contactEmail,
                        merchantNumber: orderDetailProvider.orderDetail.data!
                                    .merchantInfo.contactNumber ==
                                ""
                            ? null
                            : orderDetailProvider
                                .orderDetail.data!.merchantInfo.contactNumber,
                      ),
                      const SizedBox(height: AppSizes.paddingLg),
                      Divider(
                        height: 0.h,
                      ),
                      const SizedBox(height: AppSizes.padding * 1.5),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingLg,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Summary",
                              style: subTitleText.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: AppSizes.padding,
                            ),
                            Column(
                              children: [
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  removeBottom: true,
                                  child: ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                            height: AppSizes.padding),
                                    itemCount: orderDetailProvider
                                        .orderDetail.data!.orderItem.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text.rich(TextSpan(children: [
                                          TextSpan(
                                              text: orderDetailProvider
                                                  .orderDetail
                                                  .data!
                                                  .orderItem[index]
                                                  .quantity
                                                  .toString(),
                                              style: bodyText.copyWith()),
                                          TextSpan(
                                            text: " x ",
                                            style: bodyText.copyWith(
                                                color: AppColors
                                                    .textLightGreyColor),
                                          ),
                                          TextSpan(
                                            text: orderDetailProvider
                                                .orderDetail
                                                .data!
                                                .orderItem[index]
                                                .itemName
                                                .toString(),
                                            style: bodyText.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ])),
                                        Text(
                                          "${orderDetailProvider.orderDetail.data!.currency} ${orderDetailProvider.orderDetail.data!.orderItem[index].billAmount}",
                                          style: bodyText.copyWith(
                                            color: AppColors.textDarkColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),

                                    //     EachPriceItem(
                                    //   title:
                                    //       "${orderDetailProvider.orderDetail.data.items[index].quantity} X ${orderDetailProvider.orderDetail.data.items[index].name}",
                                    //   value:
                                    //       "${orderDetailProvider.orderDetail.data.currency} ${orderDetailProvider.orderDetail.data.items[index].specialPriceTotal != 0.0 ? orderDetailProvider.orderDetail.data.items[index].specialPriceTotal.toStringAsFixed(2) : orderDetailProvider.orderDetail.data.items[index].retailPriceTotal.toStringAsFixed(2)}",
                                    // ),
                                  ),
                                ),
                                const Divider(
                                  height: AppSizes.padding * 3,
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
                                              "${orderDetailProvider.orderDetail.data!.currency} ${orderDetailProvider.orderDetail.data!.subTotal}"),

                                      //TODO: Left to show delivery charge as well as dont show it at
                                      // if (orderDetailProvider
                                      //         .orderDetail.data!.orderType ==
                                      //     "delivery")
                                      //   const SizedBox(
                                      //     height: AppSizes.padding,
                                      //   ),
                                      if (orderDetailProvider
                                              .orderDetail.data!.orderType ==
                                          "delivery")
                                        const SizedBox(
                                          height: AppSizes.padding,
                                        ),

                                      if (orderDetailProvider.orderDetail.data!
                                                  .orderType ==
                                              "delivery" &&
                                          orderDetailProvider.orderDetail.data!
                                                  .deliveryFee !=
                                              "")
                                        EachPriceItem(
                                            title: "Delivery Fee",
                                            value:
                                                "${orderDetailProvider.orderDetail.data!.currency} ${orderDetailProvider.orderDetail.data!.deliveryFee.toString()}",
                                            isDeliveryFree: orderDetailProvider
                                                    .orderDetail
                                                    .data!
                                                    .deliveryFee ==
                                                "0.00"),
                                      // if (orderDetailProvider
                                      //         .orderDetail.data!.orderType ==
                                      //     "delivery")
                                      //   const SizedBox(
                                      //     height: AppSizes.paddingLg,
                                      //   ),

                                      if (orderDetailProvider.orderDetail.data!
                                              .discountAmount !=
                                          "0.00")
                                        const SizedBox(
                                            height: AppSizes.padding),
                                      if (orderDetailProvider.orderDetail.data!
                                              .discountAmount !=
                                          "0.00")
                                        EachPriceItem(
                                          hasPromo: true,
                                          title: "Discount:",
                                          promoCode: orderDetailProvider
                                              .orderDetail.data!.couponCode,
                                          value:
                                              "${orderDetailProvider.orderDetail.data!.currency} ${orderDetailProvider.orderDetail.data!.discountAmount}",
                                        ),
                                      const Divider(
                                        height: AppSizes.padding * 3,
                                      ),
                                      EachPriceItem(
                                        isTotal: true,
                                        title: "Total",
                                        hasTax: orderDetailProvider
                                                .orderDetail.data?.taxAmount !=
                                            null,
                                        taxPer: orderDetailProvider.orderDetail
                                                    .data?.taxPercentage ==
                                                null
                                            ? null
                                            : double.tryParse(
                                                orderDetailProvider.orderDetail
                                                    .data!.taxPercentage),
                                        value:
                                            "${orderDetailProvider.orderDetail.data!.currency} ${orderDetailProvider.orderDetail.data!.grandTotal}",
                                      ),
                                      const SizedBox(
                                        height: AppSizes.padding * 4,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }

  // Column eachItemKeyValue({
  //   required String value,
  //   required String key,
  //   String? subValue,
  //   bool isBold = false,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         key,
  //         textAlign: TextAlign.left,
  //         style: smallText.copyWith(
  //           fontWeight: FontWeight.w300,
  //           color: AppColors.textLightGreyColor,
  //         ),
  //       ),
  //       Text(
  //         value,
  //         style: bodyText.copyWith(
  //           fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
  //         ),
  //       ),
  //       if (subValue != null)
  //         Text(
  //           subValue,
  //           style: bodyText.copyWith(
  //             fontWeight: FontWeight.normal,
  //           ),
  //         ),
  //     ],
  //   );
  // }

  TableRow buildTableRowDivider({
    required int cols,
    double height = 1,
    Color color = Colors.grey,
  }) =>
      TableRow(
        children: [
          for (var i = 0; i < cols; i++)
            Container(
              height: height,
              color: color,
            )
        ],
      );

  Text eachHeader(label) {
    return Text(
      label,
      textAlign: TextAlign.left,
      style: subTitleText.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class CollectionInfo extends StatelessWidget {
  final bool isDelivery;
  final String deliveryLocation;
  final String status;
  final int colorCode;
  final String deliveryTime;
  final String merchantLocation;
  final String merchantName;
  final String? merchantEmail;
  final String? merchantNumber;
  final OrderDetailModel orderDetailModel;
  const CollectionInfo({
    Key? key,
    required this.isDelivery,
    required this.deliveryLocation,
    required this.merchantLocation,
    required this.deliveryTime,
    required this.status,
    required this.merchantName,
    required this.colorCode,
    this.merchantEmail,
    this.merchantNumber,
    required this.orderDetailModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.padding * 1.5,
                horizontal: AppSizes.paddingLg,
              ),
              decoration: BoxDecoration(
                  color: AppColors.lightGreyBgColor,
                  borderRadius: BorderRadius.circular(AppSizes.radius)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Info",
                    style: subTitleText.copyWith(
                        fontWeight: FontWeight.w600, height: 1.5),
                  ),
                  const SizedBox(
                    height: AppSizes.padding,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: AppColors.lightestPrimaryColor,
                        child: Text(
                          orderDetailModel.customerName
                              .split(" ")
                              .toList()
                              .map((String e) => e[0])
                              .toList()
                              .join(),
                          style: bigTitleText.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderDetailModel.customerName,
                            style: subTitleText.copyWith(
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            orderDetailModel.customerEmail,
                            style: bodyText.copyWith(
                                color: AppColors.textSoftGreyColor),
                          ),
                          Text(
                            orderDetailModel.customerMobile,
                            style: bodyText.copyWith(
                                color: AppColors.textSoftGreyColor),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )),
          const SizedBox(
            height: AppSizes.paddingLg,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.padding * 1.5,
              horizontal: AppSizes.paddingLg,
            ),
            decoration: BoxDecoration(
                color: AppColors.lightGreyBgColor,
                borderRadius: BorderRadius.circular(AppSizes.radius)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Merchant Info",
                style: subTitleText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    merchantName.trim(),
                    style: bodyText.copyWith(
                        color: AppColors.textDarkColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  EachInfo(
                    value: merchantLocation.trim(),
                    icons: locationIcon,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  if (merchantEmail != null)
                    EachInfo(
                      value: merchantEmail!.trim(),
                      icons: emailIcon,
                    ),
                  if (merchantEmail != null)
                    SizedBox(
                      height: 2.h,
                    ),
                  if (merchantNumber != null)
                    EachInfo(
                      value: merchantNumber!.trim(),
                      icons: phoneIcon,
                    ),
                ],
              ),
            ]),
          ),
          const SizedBox(
            height: AppSizes.paddingLg,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${isDelivery ? "Delivery" : "Self PickUp"} Info",
                style: subTitleText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Color(colorCode)),
                  child: Text(
                    status,
                    style: smallText.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.whiteColor,
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EachInfo(
                value: deliveryTime,
                icons: timeIcon,
              ),
              SizedBox(
                height: 2.h,
              ),
              EachInfo(
                value: isDelivery ? deliveryLocation : merchantLocation,
                icons: locationIcon,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EachInfo extends StatelessWidget {
  final String value;
  final String icons;
  const EachInfo({
    Key? key,
    required this.value,
    required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icons,
          height: 14.h,
          width: 14.h,
          color: AppColors.primaryColor,
        ),
        const SizedBox(
          width: AppSizes.padding,
        ),
        Expanded(
          child: Text(
            value.trim(),
            style: bodyText.copyWith(
              color: AppColors.textSoftGreyColor,
            ),
          ),
        ),
      ],
    );
  }
}
