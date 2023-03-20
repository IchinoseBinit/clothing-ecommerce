import 'dart:io';
import 'package:clothing_ecommerce/providers/location_provider.dart';
import 'package:clothing_ecommerce/widgets/alert_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '/data/constants/image_constants.dart';
import '/providers/conectivity_provider.dart';
import '/providers/intro_notifier.dart';
import '/screens/auth/login_screen.dart';
import '/screens/auth/welcome_screen.dart';
import '/screens/navigation_screen.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/navigation_util.dart';
import '/widgets/no_internet_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      Provider.of<ConnectivityProvider>(context, listen: false)
          .monitorConnection(context);

      if (mounted) {
        _onSubmit();
      }
      isInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onSubmit() async {
    IntroProvider introProvider =
        Provider.of<IntroProvider>(context, listen: false);
    await introProvider.call();

    if (await Permission.location.request().isGranted || Platform.isIOS) {
      if (mounted) {
        if (introProvider.hasAppToken) {
          navigateReplacement(context, const NavigationScreen());
        } else if (introProvider.getisSeenWelcomeScreen) {
          navigateReplacement(context, const LoginScreen());
        } else {
          navigateReplacement(context, const WelcomeScreen());
        }
      }
    } else {
      if (mounted) {
        AlertBottomSheet.showAlertBottomSheet(context,
            iconImage: alert,
            isDismissible: false,
            enableDrag: false,
            title: "Handle Permisson",
            description:
                "Please press OK to accept the required permission in settings",
            okFunc: () async {
          if (await Permission.location.request().isGranted) {
            Navigator.pop(context);
            _onSubmit();
          } else {
            await openAppSettings().whenComplete(() async {
              if (await Permission.location.isGranted) {
                Navigator.pop(context);
              }
            });
          }
        }, isCancelButton: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<ConnectivityProvider>(builder: (_, v, __) {
        if (v.isOnline) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.primaryColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    padding: const EdgeInsets.all(AppSizes.padding),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Image.asset(appLogo),
                  ),
                  Text(
                    "E-Clothing",
                    style: bigTitleText.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const NoInternetScreen();
      }),
    );
  }
}
