import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '/providers/auth_provider.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/validation_mixin.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_textfield.dart';
import '/widgets/reusable_widgets.dart';
import 'package:clothing_ecommerce/screens/auth/widgets/auth_template.dart';

class RegisterSetPasswordScreen extends StatefulWidget {
  final String email;
  final String userId;
  const RegisterSetPasswordScreen({Key? key, required this.email, required this.userId})
      : super(key: key);

  @override
  State<RegisterSetPasswordScreen> createState() =>
      RegisterSetPasswordScreenState();
}

class RegisterSetPasswordScreenState extends State<RegisterSetPasswordScreen> {
  bool _dontShowPassword = true;
  bool _dontShowConfirmPassword = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Map data = {
        // "email": widget.email,
        "new_password": _passwordController.text,
        "confirm_password": _confirmPasswordController.text
      };
      Provider.of<AuthProvider>(context, listen: false)
          .registerSetPassword(data, context, widget.userId);
    }
  }

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
            title: "Set Password",
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
                    const AuthTemplate(
                      title: "Set Password",
                      subTitle: "Enter password to set password for login",
                      image: changePasswordIcon,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
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
