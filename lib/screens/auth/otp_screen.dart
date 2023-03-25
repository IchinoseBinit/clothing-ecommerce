import 'dart:developer';

import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/screens/auth/widgets/auth_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '/providers/auth_provider.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/show_toast.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/reusable_widgets.dart';

class OptScreen extends StatefulWidget {
  final bool isFromForgetPassword;
  final String email;
  const OptScreen(
      {Key? key, required this.email, this.isFromForgetPassword = false})
      : super(key: key);

  @override
  State<OptScreen> createState() => _OptScreenState();
}

class _OptScreenState extends State<OptScreen> {
  final otpController = OtpFieldController();
  String otp = "";
  _onSubmit() {
    if (otp.length == 6) {
      Map data = {
        "otp": otp,
        "email": widget.email,
      };
      Provider.of<AuthProvider>(context, listen: false).verifyOtp(context, data,
          isFromForgetPassword: widget.isFromForgetPassword);
    } else {
      showToast("Please enter the valid Code");
    }
  }

  // _onsubmitResetOtp() {
  //   log(widget.email);

  //   try {
  //     Map data = {
  //       "email": widget.email,
  //     };
  //     Provider.of<AuthProvider>(context, listen: false)
  //         .resentOtpApiCall(data, context);
  //   } catch (e) {
  //     showToast(e.toString());
  //   }
  // }

  final bool loading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar(
            title: "Verify Email",
          ),
          body: ScrollConfiguration(
            behavior: MyBehaviour(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    AuthTemplate(
                      title: "Enter Code",
                      subTitle: "Code has been sent to ${widget.email}.",
                      image: otpIcon,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    OTPTextField(
                        controller: otpController,
                        length: 6,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceEvenly,
                        fieldWidth: 40.w,
                        keyboardType: TextInputType.number,
                        margin: EdgeInsets.zero,
                        fieldStyle: FieldStyle.box,
                        otpFieldStyle: OtpFieldStyle(
                          backgroundColor: AppColors.textFieldInputColor,
                          borderColor: AppColors.greyColor,
                          focusBorderColor: AppColors.primaryColor,
                          enabledBorderColor: AppColors.greyColor,
                        ),
                        outlineBorderRadius: AppSizes.radius,
                        style: bodyText,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (pin) {
                          log("Changed: $pin");
                          otp = pin;
                        },
                        onCompleted: (pin) {
                          log("Completed: $pin");
                          otp = pin;
                        }),
                    SizedBox(
                      height: 8.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        // _onsubmitResetOtp();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Didn't get code in email ? "),
                          Text(
                            "Send Code",
                            style: bodyText.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    //Button Login
                    Consumer<AuthProvider>(builder: (__, authProvider, _) {
                      return GeneralElevatedButton(
                        title: "Verify",
                        marginH: 0,
                        loading: authProvider.registerOtpLoading,
                        onPressed: () {
                          _onSubmit();
                        },
                      );
                    }),
                    SizedBox(
                      height: 8.h,
                    ),
                    eachHelpText(),
                    SizedBox(
                      height: 32.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (Provider.of<AuthProvider>(context).signUpLoading)
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
  }
}
