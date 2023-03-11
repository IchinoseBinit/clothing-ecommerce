import 'dart:async';
import 'dart:developer';
import 'package:clothing_ecommerce/widgets/general_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/data/constants/image_constants.dart';
import '/providers/conectivity_provider.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';

/* 
This screen shows availability of internet
 */
class ConnectivityCheckWidget extends StatefulWidget {
  const ConnectivityCheckWidget({Key? key}) : super(key: key);

  @override
  State<ConnectivityCheckWidget> createState() =>
      _ConnectivityCheckWidgetState();
}

class _ConnectivityCheckWidgetState extends State<ConnectivityCheckWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConnectivityProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              noInternet,
              height: 160.h,
              color: AppColors.lightPrimaryColor,
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
                  Timer(const Duration(seconds: 3), () {
                    // var route = ModalRoute.of(context)?.settings.name ?? "";
                    // while (route == connectivityRoute) {
                    log(provider.count.toString());
                    Navigator.popUntil(context, (_) => (provider.count-- <= 0));
                    provider.resetCounter();
                    //   route = ModalRoute.of(context)?.settings.name ?? "";
                    // }
                  });
                }
              },
              isSmallText: true,
              title: "Try Again",
            ),
          ],
        ),
      ),
    );
  }
}
