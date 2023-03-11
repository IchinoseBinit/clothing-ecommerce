import 'dart:developer';

import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '/providers/auth_provider.dart';
import '/widgets/general_elevated_button.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/show_toast.dart';
import '/utils/validation_mixin.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/general_textfield.dart';
import '/widgets/reusable_widgets.dart';
import 'login_screen.dart';

class ResetPasswordOptScreen extends StatefulWidget {
  final String email;
  const ResetPasswordOptScreen({Key? key, required this.email})
      : super(key: key);

  @override
  State<ResetPasswordOptScreen> createState() => _ResetPasswordOptScreenState();
}

class _ResetPasswordOptScreenState extends State<ResetPasswordOptScreen> {
  bool _dontShowPassword = true;
  bool _dontShowConfirmPassword = true;
  final otpController = OtpFieldController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String otp = "";
  _onSubmit() {
    if (otp.length == 6 && _formKey.currentState!.validate()) {
      Map data = {
        "otp": otp,
        "email": widget.email,
        "password1": _passwordController.text,
        "password2": _confirmPasswordController.text
      };
      Provider.of<AuthProvider>(context, listen: false)
          .resetPasswordVerifyOtp(data, context);
    } else {
      showToast("Please enter the valid code");
    }
  }

  final bool loading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    confirmFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar(
            title: "Reset Password",
            centerTitle: false,
            // leadingFunc: () =>
            //     navigate(context,  const NavigationScreen()),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            OTPTextField(
                                controller: otpController,
                                length: 6,
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment:
                                    MainAxisAlignment.spaceBetween,
                                fieldWidth: 40.w,
                                keyboardType: TextInputType.number,
                                margin: EdgeInsets.zero,
                                fieldStyle: FieldStyle.box,
                                otpFieldStyle: OtpFieldStyle(
                                  backgroundColor:
                                      AppColors.textFieldInputColor,
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
                                dynamic data = {
                                  'email': widget.email.trim().toString(),
                                };
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .resetPassword(data, context,
                                        isFromOtpScreen: true);
                                log(data.toString(),
                                    name: "reset forget password");
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
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  GeneralTextField(
                                    obscureText: _dontShowPassword,
                                    suffixIcon: _dontShowPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    onClickSuffixToggle: () {
                                      setState(() {
                                        _dontShowPassword = !_dontShowPassword;
                                      });
                                    },
                                    textInputAction: TextInputAction.go,
                                    validate: Validation().validatePassword,
                                    keywordType: TextInputType.text,
                                    focusNode: passwordFocusNode,
                                    labelText: 'Password',
                                    controller: _passwordController,
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  GeneralTextField(
                                    obscureText: _dontShowConfirmPassword,
                                    suffixIcon: _dontShowConfirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    onClickSuffixToggle: () {
                                      setState(() {
                                        _dontShowConfirmPassword =
                                            !_dontShowConfirmPassword;
                                      });
                                    },
                                    textInputAction: TextInputAction.done,
                                    validate: (value) => Validation()
                                        .validatePassword(
                                            _passwordController.text,
                                            confirmValue: value,
                                            isConfirmPassword: true),
                                    keywordType: TextInputType.text,
                                    focusNode: confirmFocusNode,
                                    labelText: 'Confirm Password',
                                    controller: _confirmPasswordController,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    //Button Login
                    Consumer<AuthProvider>(builder: (__, authProvider, _) {
                      return GeneralElevatedButton(
                        title: "Confirm",
                        marginH: 0,
                        loading: authProvider.resetPsOtpLoading,
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
        if (Provider.of<AuthProvider>(context).resetPasswordLoading)
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
