import 'dart:developer';

import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/screens/auth/widgets/auth_template.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
  }

  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      dynamic data = {
        'email': _emailController.text.trim().toString(),
      };
      Provider.of<AuthProvider>(context, listen: false)
          .forgetPassword(context, data);
      log(data.toString(), name: "reset forget password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        title: "Forget Password",
      ),
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  const AuthTemplate(
                    title: "Forgotten Password!",
                    subTitle:
                        "Please provide your email address below, and we will send you an email with instructions on how to reset your password.",
                    image: forgetPasswordIcon,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
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
                  Consumer<AuthProvider>(builder: (__, authProvider, _) {
                    return GeneralElevatedButton(
                      title: "Send Code",
                      marginH: 0,
                      loading: authProvider.forgetPasswordLoading,
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
    );
  }
}
