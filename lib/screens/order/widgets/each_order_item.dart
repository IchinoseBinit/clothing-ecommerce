import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/models/order_list_model.dart';
import '/screens/order/order_detail_screen.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/navigation_util.dart';

class EachOrderItem extends StatelessWidget {
  final Results olModel;
  final int index;
  const EachOrderItem({Key? key, required this.olModel, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigate(
          context,
          OrderDetailScreen(orderCode: olModel.orderCode),
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: .60.sw,
                      child: Text(
                        olModel.merchantInfo.name,
                        softWrap: true,
                        style: subTitleText.copyWith(
                            height: 1.3, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    SizedBox(
                      width: .60.sw,
                      child: Text(
                        "#${olModel.orderCode}",
                        softWrap: true,
                        style: bodyText.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: .60.sw,
                      child: Text(
                        olModel.orderType == "delivery"
                            ? olModel.deliveryAddress.trim()
                            : olModel.locationAddress.trim(),
                        style: smallText.copyWith(
                            color: AppColors.textSoftGreyColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: 100,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Color(int.parse(
                                olModel.statusColor.replaceAll("#", "0xff")))),
                        child: Text(
                          olModel.status,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: smallText.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.whiteColor,
                          ),
                        )),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "${olModel.currency} ${olModel.grandTotal}",
                      style: subTitleText.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  olModel.orderType == "delivery" ? "Delivery" : "Self PickUp",
                  style: smallText.copyWith(
                    color: AppColors.textSoftGreyColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 5,
                  width: 5,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radius * 2),
                    ),
                  ),
                ),
                Text(
                  olModel.deliveryTime,
                  style: smallText.copyWith(
                    color: AppColors.textSoftGreyColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
