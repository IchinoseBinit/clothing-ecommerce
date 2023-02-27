import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';

class EachPriceItem extends StatelessWidget {
  String title;
  String value;
  bool hasPromo;
  Color? textColor;
  bool isDeliveryFree;
  bool isTotal;
  bool isSubTotal;
  double? taxPer;
  bool hasTax;
  String? promoCode;
  EachPriceItem(
      {Key? key,
      required this.title,
      required this.value,
      this.textColor,
      this.isTotal = false,
      this.hasTax = false,
      this.isDeliveryFree = false,
      this.hasPromo = false,
      this.isSubTotal = false,
      this.promoCode,
      this.taxPer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: bodyText.copyWith(
                color: textColor ?? AppColors.blackColor,
                fontSize: isTotal ? 17.sp : 14.sp,
                height: 0,
                fontWeight: (isSubTotal || isTotal)
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            if (hasPromo && promoCode != null)
              Text(
                " (",
                style: bodyText.copyWith(
                  fontWeight: FontWeight.w500,
                  color: textColor ?? AppColors.blackColor,
                ),
              ),
            if (hasPromo && promoCode != null)
              Text(
                promoCode!,
                style: bodyText.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            if (hasPromo && promoCode != null)
              Text(
                ")",
                style: bodyText.copyWith(
                  fontWeight: FontWeight.w500,
                  color: textColor ?? AppColors.blackColor,
                ),
              ),
            if (hasTax && taxPer != null)
              Text(
                "(incl. ${taxPer!.toInt()}% VAT)",
                style: verySmallText.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 9.sp,
                  color: AppColors.textSoftGreyColor,
                  height: 2.5,
                ),
              ),
            if (hasTax && taxPer == null)
              Text(
                "(incl.VAT)",
                style: verySmallText.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 9.sp,
                  color: AppColors.textSoftGreyColor,
                  height: 2.5,
                ),
              ),
          ],
        ),
        if (!isDeliveryFree)
          Text(
            hasPromo
                ? value == ""
                    ? "-"
                    : "- $value"
                : value,
            style: bodyText.copyWith(
              color: textColor ??
                  ((isSubTotal || isTotal)
                      ? AppColors.textDarkColor
                      : AppColors.textSoftGreyColor),
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight:
                  (isSubTotal || isTotal) ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        if (isDeliveryFree == true)
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
    );
  }
}
