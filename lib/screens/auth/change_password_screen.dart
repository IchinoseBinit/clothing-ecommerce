import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:provider/provider.dart';
import '/widgets/general_elevated_button.dart';
import '/providers/auth_provider.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/validation_mixin.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/general_textfield.dart';
import '/widgets/reusable_widgets.dart';
import 'login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _dontShowPassword = true;
  bool _dontShowCurrentPs = true;
  bool _dontShowConfirmPassword = true;
  final otpController = OtpFieldController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _currentPsController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode currentPsFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Map data = {
        "old_password": _currentPsController.text,
        "new_password1": _passwordController.text,
        "new_password2": _confirmPasswordController.text
      };
      Provider.of<AuthProvider>(context, listen: false)
          .changePassword(data, context);
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
            title: "Change Password",
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
                    const AuthTemplate(
                      title: "Enter Password",
                      subTitle: "Change password to Login.",
                      image: changePasswordIcon,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              GeneralTextField(
                                obscureText: _dontShowCurrentPs,
                                suffixIcon: _dontShowCurrentPs
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onClickPsToggle: () {
                                  setState(() {
                                    _dontShowCurrentPs = !_dontShowCurrentPs;
                                  });
                                },
                                textInputAction: TextInputAction.go,
                                validate: Validation().validatePassword,
                                keywordType: TextInputType.text,
                                focusNode: currentPsFocusNode,
                                labelText: 'Current Password',
                                controller: _currentPsController,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              GeneralTextField(
                                obscureText: _dontShowPassword,
                                suffixIcon: _dontShowPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onClickPsToggle: () {
                                  setState(() {
                                    _dontShowPassword = !_dontShowPassword;
                                  });
                                },
                                textInputAction: TextInputAction.go,
                                validate: Validation().validatePassword,
                                keywordType: TextInputType.text,
                                focusNode: passwordFocusNode,
                                labelText: 'New Password',
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
                                onClickPsToggle: () {
                                  setState(() {
                                    _dontShowConfirmPassword =
                                        !_dontShowConfirmPassword;
                                  });
                                },
                                textInputAction: TextInputAction.done,
                                validate: (value) => Validation()
                                    .validatePassword(_passwordController.text,
                                        confirmValue: value,
                                        isConfirmPassword: true),
                                keywordType: TextInputType.text,
                                focusNode: confirmFocusNode,
                                labelText: 'Confirm New Password',
                                controller: _confirmPasswordController,
                              ),
                            ],
                          ),
                        )
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
                        loading: authProvider.changePasswordLoading,
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
      ],
    );
  }
}
