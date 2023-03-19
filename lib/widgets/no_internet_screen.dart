import 'dart:async';
import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '/providers/conectivity_provider.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import 'general_text_button.dart';

/* 
This screen shows availability of internet
 */
class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Consumer<ConnectivityProvider>(builder: (_, provider, __) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  noInternet,
                  height: 160.h,
                  // color: AppColors.lightPrimaryColor,
                ),
                const SizedBox(
                  height: AppSizes.padding * 4,
                ),
                Text(
                  "No Connection",
                  style: titleText.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: AppSizes.padding,
                ),
                Text(
                  "It appears that you are not connected to the internet at the moment.",
                  textAlign: TextAlign.center,
                  style: subTitleText.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  height: AppSizes.padding * 4,
                ),
                GeneralTextButton(
                  fgColor: AppColors.whiteColor,
                  borderColor: AppColors.whiteColor,
                  marginH: 0,
                  onPressed: () {
                    if (provider.isOnline) {
                      if (provider.count == 1) {
                        Navigator.pop(context);
                      } else if (provider.count > 1) {
                        Navigator.popUntil(
                            context, (_) => (provider.count-- <= 0));
                      }
                      provider.resetCounter();
                    }
                  },
                  isSmallText: true,
                  title: "Try Again",
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
