import 'dart:developer';

import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/data/constants/routes_name.dart';
import '/providers/auth_provider.dart';
import '/screens/merchant_list/widgets/general_elevated_button.dart';
import '/screens/merchant_list/widgets/phone_field.dart';
import '/screens/navigation_screen.dart';
import '/styles/app_colors.dart';
import '/styles/styles.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/navigation_util.dart';
import '/utils/validation_mixin.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/general_textfield.dart';

class RegisterScreen extends StatefulWidget {
  final bool isFromCheckout;
  const RegisterScreen({Key? key, this.isFromCheckout = false})
      : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _dontShowPassword = true;
  bool _dontShowConfirmPassword = true;
  bool _checkBox = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController =
  //     TextEditingController();
  late final PhoneNumberInputController _phoneController;

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  // FocusNode passwordFocusNode = FocusNode();
  // FocusNode confirmFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneController = PhoneNumberInputController(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    emailFocusNode.dispose();
    // _passwordController.dispose();
    // _confirmPasswordController.dispose();
    // passwordFocusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'full_name': _nameController.text.toString().trim(),
        'email': _emailController.text.toString().trim(),
        // 'password1': _passwordController.text.toString().trim(),
        // 'password2': _confirmPasswordController.text.toString().trim(),
        'mobile_number':
            "${_phoneController.selectedCountry.dialCode.trim()}-${_phoneController.phoneNumber.trim()}",
      };

      Provider.of<AuthProvider>(context, listen: false).register(
        context,
        isFromCheckout: widget.isFromCheckout,
        data: data,
      );
      log('Sign Up Api hit');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Register",
        actions: [
          GestureDetector(
            child: IconButton(
              onPressed: () => navigate(
                context,
                screen: const NavigationScreen(),
              ),
              icon: Icon(
                size: 24.r,
                Icons.close,
              ),
            ),
          )
        ],
        disableLeading: true,
      ),
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome!",
                          style: bigTitleText.copyWith(
                              fontWeight: FontWeight.w500, height: 0),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Sign up now to access all the benefits of our services, including easy ordering, saving favorite merchants, and exclusive deals.",
                          style: bodyText.copyWith(
                            color: AppColors.textSoftGreyColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          GeneralTextField(
                            textInputAction: TextInputAction.go,
                            validate: (name) =>
                                Validation().validate(name, title: "Full Name"),
                            keywordType: TextInputType.name,
                            focusNode: nameFocusNode,
                            labelText: 'Full Name',
                            controller: _nameController,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          GeneralTextField(
                            textInputAction: TextInputAction.go,
                            validate: Validation().validateEmail,
                            keywordType: TextInputType.emailAddress,
                            focusNode: emailFocusNode,
                            labelText: 'E-Mail',
                            controller: _emailController,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          PhoneField(phoneController: _phoneController),

                          // SizedBox(
                          //   child: IntlPhoneField(
                          //     flagsButtonMargin: EdgeInsets.only(
                          //       left: 10.w,
                          //     ),
                          //     keyboardType: TextInputType.phone,
                          //     // flagsButtonPadding: EdgeInsets.only(
                          //     //   bottom: 4.h,
                          //     //   top: 4.h,
                          //     // ),
                          //     showCountryFlag: true,
                          //     dropdownTextStyle: smallText.copyWith(
                          //       color: AppColors.textSoftGreyColor,
                          //     ),
                          //     dropdownIconPosition: IconPosition.trailing,
                          //     autovalidateMode: AutovalidateMode.disabled,
                          //     dropdownIcon: const Icon(
                          //       Icons.arrow_drop_down,
                          //       color: AppColors.primaryColor,
                          //     ),
                          //     textAlignVertical: TextAlignVertical.center,
                          //     decoration: InputDecoration(
                          //       contentPadding: EdgeInsets.zero,
                          //       hintStyle: smallText.copyWith(
                          //         color: AppColors.textSoftGreyColor,
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //       labelStyle: smallText.copyWith(
                          //         color: AppColors.textSoftGreyColor,
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //       errorStyle: TextStyle(
                          //         color: Theme.of(context)
                          //             .errorColor, // or any other color
                          //       ),
                          //       errorMaxLines: 3,
                          //       filled: true,
                          //       fillColor: AppColors.inputColor,
                          //       focusedBorder: OutlineInputBorder(
                          //         borderRadius:
                          //             BorderRadius.circular(AppSizes.radius),
                          //         borderSide: const BorderSide(
                          //           color: AppColors.primaryColor,
                          //           width: 1,
                          //         ),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius:
                          //             BorderRadius.circular(AppSizes.radius),
                          //         borderSide: const BorderSide(
                          //           width: 1,
                          //           color: Color(0xffE3E3E3),
                          //         ),
                          //       ),
                          //       disabledBorder: OutlineInputBorder(
                          //         borderRadius:
                          //             BorderRadius.circular(AppSizes.radius),
                          //         borderSide: const BorderSide(
                          //           color: AppColors.primaryColor,
                          //           width: 1,
                          //         ),
                          //       ),
                          //       focusedErrorBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(8.r),
                          //         borderSide: BorderSide(
                          //           color: Theme.of(context).errorColor,
                          //           width: 1,
                          //         ),
                          //       ),
                          //       errorBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(8.r),
                          //         borderSide: BorderSide(
                          //           color: Theme.of(context).errorColor,
                          //           width: 1,
                          //         ),
                          //       ),
                          //       hintText: "Phone Number",

                          //       // prefixIcon: const Icon(
                          //       //   Icons.phone_android_rounded,
                          //       //   color: AppColors.textDarkColor,
                          //       // ),
                          //     ),
                          //     controller: _phoneController,
                          //     focusNode: phoneFocusNode,
                          //     disableLengthCheck: true,

                          //     initialCountryCode:
                          //         Provider.of<LocationProvider>(context)
                          //                 .placemarks
                          //                 .isEmpty
                          //             ? null
                          //             : Provider.of<LocationProvider>(context)
                          //                 .placemarks
                          //                 .first
                          //                 .isoCountryCode,
                          //     onChanged: (phone) {
                          //       log(phone.completeNumber);
                          //       _completeNumber.text =
                          //           "${phone.countryCode}-${phone.number}";
                          //     },
                          //     validator: (value) => Validation().validateNumber(
                          //         value!.number, "Mobile Number", 10),
                          //   ),
                          // ),
                          SizedBox(
                            height: 16.h,
                          ),
                          // GeneralTextField(
                          //   obscureText: _dontShowPassword,
                          //   suffixIcon: _dontShowPassword
                          //       ? Icons.visibility
                          //       : Icons.visibility_off,
                          //   onClickPsToggle: () {
                          //     setState(() {
                          //       _dontShowPassword = !_dontShowPassword;
                          //     });
                          //   },
                          //   textInputAction: TextInputAction.go,
                          //   validate: Validation().validatePassword,
                          //   keywordType: TextInputType.text,
                          //   focusNode: passwordFocusNode,
                          //   labelText: 'Password',
                          //   controller: _passwordController,
                          // ),
                          // SizedBox(
                          //   height: 16.h,
                          // ),
                          // GeneralTextField(
                          //   obscureText: _dontShowConfirmPassword,
                          //   suffixIcon: _dontShowConfirmPassword
                          //       ? Icons.visibility
                          //       : Icons.visibility_off,
                          //   onClickPsToggle: () {
                          //     setState(() {
                          //       _dontShowConfirmPassword =
                          //           !_dontShowConfirmPassword;
                          //     });
                          //   },
                          //   textInputAction: TextInputAction.go,
                          //   validate: (value) => Validation().validatePassword(
                          //       _passwordController.text,
                          //       confirmValue: value,
                          //       isConfirmPassword: true),
                          //   keywordType: TextInputType.text,
                          //   focusNode: confirmFocusNode,
                          //   labelText: 'Confirm Password',
                          //   controller: _confirmPasswordController,
                          // ),
                          //Password Text Field
                          // normalPasswordFieldWIdget(),

                          //Confirm Pass Text Field
                        ],
                      ),
                    )
                  ],
                ),
                // SizedBox(
                //   height: 8.h,
                // ),
                // checkboxTile(),
                SizedBox(
                  height: 8.h,
                ),
                Consumer<AuthProvider>(builder: (__, authProvider, _) {
                  return GeneralElevatedButton(
                    title: "Sign Up",
                    marginH: 0,
                    loading: authProvider.signUpLoading,
                    onPressed: () {
                      _onSubmit();
                    },
                  );
                }),
                SizedBox(
                  height: 16.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.loginRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: bodyText,
                      ),
                      Text(
                        "Log In",
                        style: bodyText.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget checkboxTile() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _checkBox = !_checkBox;
        });
      },
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: AppColors.primaryColor,
                value: _checkBox,
                onChanged: (_) {
                  setState(() {
                    _checkBox = !_checkBox;
                  });
                }),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              "I want to receive exclusive offers and promotions from RhinoPass",
              style: smallText.copyWith(
                color: AppColors.textSoftGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
