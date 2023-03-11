import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/styles/app_sizes.dart';

class GeneralElevatedButton extends StatelessWidget {
  final String title;
  final Widget? leadingAndTrailingWidget;
  final bool isSmallText;
  final bool loading;
  final Color? bgColor;
  final Color? fgColor;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final bool isDisabled;
  final double? height;
  final double? width;
  final BorderRadius? customBorderRadius;
  final double? marginH;
  final double? elevation;
  TextStyle? textStyle;

  GeneralElevatedButton({
    Key? key,
    this.isSmallText = false,
    required this.title,
    this.bgColor,
    this.fgColor,
    this.borderRadius,
    this.isDisabled = false,
    this.onPressed,
    this.height,
    this.width,
    this.marginH,
    this.textStyle,
    this.elevation,
    this.loading = false,
    this.leadingAndTrailingWidget,
    this.customBorderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (textStyle == null) {
      if (isSmallText) {
        textStyle = Theme.of(context).textTheme.subtitle2!.copyWith(
              color: fgColor ?? Colors.white,
              fontWeight: FontWeight.w600,
            );
      } else {
        textStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
              color: fgColor ?? Colors.white,
              fontWeight: FontWeight.w600,
            );
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginH ?? AppSizes.padding),
      height: height ?? 40.h,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        key: key,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation ?? 0),
          backgroundColor: MaterialStateProperty.all(
            isDisabled
                ? Theme.of(context).disabledColor
                : bgColor ?? Theme.of(context).primaryColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: customBorderRadius ??
                  BorderRadius.circular(borderRadius ?? 6.r),
            ),
          ),
        ),
        onPressed: (isDisabled || loading) ? null : onPressed,
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : leadingAndTrailingWidget ??
                Text(
                  title,
                  style: textStyle,
                ),
      ),
    );
  }
}
