import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/data/constants/image_constants.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';

class ErrorInfoWidget extends StatelessWidget {
  final String? errorInfo;
  final double? heightFactor;
  final bool dontShowImage;
  final bool isCart;
  final bool isProductCart;
  const ErrorInfoWidget({
    Key? key,
    this.errorInfo,
    this.dontShowImage = false,
    this.isCart = false,
    this.isProductCart = false,
    this.heightFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: heightFactor ?? 2.8,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.padding * 4,
            right: AppSizes.padding * 4,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isCart)
                Image.asset(
                  cart,
                  height: 100.h,
                ),
              if (!dontShowImage && !isCart)
                SvgPicture.asset(
                  pageNotFound,
                  height: 110.h,
                  color: isProductCart
                      ? null
                      : AppColors.primaryColor,
                ),
              SizedBox(height: 16.h),
              Text(
                errorInfo ??
                    "Dear customer, we are unable to complete the process. Please try again later.",
                style: bodyText.copyWith(
                    color: AppColors.textSoftGreyColor,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
