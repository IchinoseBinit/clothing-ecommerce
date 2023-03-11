import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '/data/constants/routes_name.dart';
import '/providers/auth_provider.dart';
import '/widgets/general_elevated_button.dart';
import '/screens/navigation_screen.dart';
import '/styles/app_colors.dart';
import '/styles/styles.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/navigation_util.dart';
import '/utils/validation_mixin.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/general_textfield.dart';

class LoginScreen extends StatefulWidget {
  final bool isFromRefreshToken;
  const LoginScreen({
    Key? key,
    this.isFromRefreshToken = false,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _dontShowPassword = true;
  bool _checkBox = false;
  bool isInit = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Provider.of<AuthProvider>(context, listen: false).login(
        context,
        email: _emailController.text,
        password: _passwordController.text,
        rememberMe: _checkBox,
        isFromRefreshToken: widget.isFromRefreshToken,
      );
    }
  }

  final bool loading = false;

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (isInit) {
      await authProvider.getEmailRememberMe();
      if (authProvider.email != null) {
        _emailController.text = authProvider.email!;
      }
      isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Login",
        // actions: [
        // GestureDetector(
        //   child: IconButton(
        //     onPressed:  () {
        //             Navigator.pop(context);
        //           }
        //         ,
        //     icon: Icon(
        //       size: 24.r,
        //       Icons.close,
        //     ),
        //   ),
        // )
        // ],
        disableLeading: true,
      ),
      body: Consumer<AuthProvider>(builder: (__, authProvider, _) {
        if (authProvider.loginIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ScrollConfiguration(
          behavior: MyBehaviour(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  const AuthTemplate(
                    title: "Welcome Back!",
                    subTitle: "Please log in to continue.",
                    image: loginIcon,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //Email Text Field
                        GeneralTextField(
                          textInputAction: TextInputAction.done,
                          validate: Validation().validateEmail,
                          keywordType: TextInputType.emailAddress,
                          focusNode: emailFocusNode,
                          labelText: 'E-mail',
                          controller: _emailController,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
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
                          textInputAction: TextInputAction.done,
                          validate: (value) =>
                              Validation().validate(value, title: "Password"),
                          keywordType: TextInputType.emailAddress,
                          focusNode: passwordFocusNode,
                          labelText: 'Password',
                          controller: _passwordController,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      checkboxTile(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.forgotPasswordRoute);
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  //Button Login
                  GeneralElevatedButton(
                    title: "Login",
                    marginH: 0,
                    loading: authProvider.loading,
                    onPressed: () {
                      _onSubmit();
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.registerRoute);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        Text(
                          "Sign Up",
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
        );
      }),
    );
  }

  Widget checkboxTile() {
    return Row(children: [
      SizedBox(
        height: 24,
        width: 24,
        child: Checkbox(
            activeColor: AppColors.primaryColor,
            value: _checkBox,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (_) {
              setState(() {
                _checkBox = !_checkBox;
              });
            }),
      ),
      SizedBox(
        width: 8.w,
      ),
      Text(
        "Remember Me",
        style: smallText.copyWith(
          color: AppColors.textSoftGreyColor,
        ),
      ),
    ]);
  }
}

class AuthTemplate extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  const AuthTemplate({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SvgPicture.asset(
            image,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          title,
          style: bigTitleText.copyWith(fontWeight: FontWeight.w500, height: 0),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          subTitle,
          style: bodyText.copyWith(
            color: AppColors.textSoftGreyColor,
          ),
        )
      ],
    );
  }
}
