import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/screens/merchant_list/widgets/general_elevated_button.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';

class AlertBottomSheet {
  static showAlertBottomSheet(
    BuildContext context, {
    required String title,
    required String description,
    Widget? descriptionWidget,
    required String iconImage,
    // required List<String> list,
    VoidCallback? cancelFunc,
    VoidCallback? okFunc,
    String? okTitle,
    String? cancelTitle,
    bool isCancelButton = false,
    bool isDismissible = true,
    bool enableDrag = false,
  }) async {
    // var header = context.locale == const Locale("en", "US")
    //     ? "${LocaleKeys.select.tr()} $title"
    //     : "$title ${LocaleKeys.select.tr()}";
    Widget okButton = GeneralElevatedButton(
      marginH: 0,
      height: 33.h,
      elevation: 0,
      onPressed: okFunc,
      width: 145.w,
      borderRadius: 8.r,
      isSmallText: true,
      bgColor: const Color(0xff1E944E),
      title: okTitle ?? "Ok",
    );

    Widget cancelButton = GeneralElevatedButton(
      marginH: 0,
      elevation: 0,
      borderRadius: 8.r,
      isSmallText: true,
      height: 33.h,
      width: 145.w,
      fgColor: const Color(0xffFF0000),
      bgColor: const Color(0xffFFEBEB),
      onPressed: cancelFunc ?? () => Navigator.pop(context),
      title: cancelTitle ?? "Cancel",
    );
    return await showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      context: context,
      builder: (bContext) => WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                    ),
                    child: Text(
                      title,
                      style: subTitleText.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  if (descriptionWidget != null) descriptionWidget,
                  if (descriptionWidget == null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: smallText.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSoftGreyColor),
                      ),
                    ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isCancelButton == true) cancelButton,
                      if (isCancelButton == true)
                        SizedBox(
                          width: 12.w,
                        ),
                      okButton,
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.padding * 6,
                  ),
                ],
              ),
              Positioned(
                top: -26,
                right: (MediaQuery.of(context).size.width / 2) - (28),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50.r,
                    ),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(AppSizes.padding / 2),
                  child: Image.asset(
                    iconImage,
                    width: 56,
                    // color: const Color(primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
