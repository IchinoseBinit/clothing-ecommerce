import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/data/response/status.dart';
import '/providers/auth_provider.dart';
import '/providers/profile_provider.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/phone_field.dart';
import '/styles/app_colors.dart';
import '/styles/styles.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/validation_mixin.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/error_info_widget.dart';
import '/widgets/general_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late final PhoneNumberInputController _phoneController;

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _phoneController = PhoneNumberInputController(context);
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    emailFocusNode.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  _onSubmit(code) {
    if (_formKey.currentState!.validate()) {
      Map data = {
        'name': _nameController.text.toString().trim(),
        'email': _emailController.text.toString().trim(),
        'mobile':
            "${_phoneController.selectedCountry.dialCode.trim()}-${_phoneController.phoneNumber.trim()}",
      };

      Provider.of<AuthProvider>(context, listen: false)
          .editProfile(data, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        title: "Edit Profile",
      ),
      body: Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
        // switch (profileProvider.profileList.status) {
        switch (Status.COMPLETED) {
          case Status.ERROR:
            return const Center(
              child: ErrorInfoWidget(),
            );

          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case Status.COMPLETED:
            // _emailController.text = profileProvider.profileList.data!.email;
            // _nameController.text = profileProvider.profileList.data!.name;
            // _phoneController.phoneNumber =
            //     profileProvider.profileList.data!.mobile;

            return ScrollConfiguration(
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
                          Text(
                            "Update your profile",
                            style: bigTitleText.copyWith(
                                fontWeight: FontWeight.w500, height: 0),
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
                                  validate: (name) => Validation()
                                      .validate(name, title: "Full Name"),
                                  keywordType: TextInputType.name,
                                  focusNode: nameFocusNode,
                                  labelText: 'Full Name',
                                  controller: _nameController,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                GeneralTextField(
                                  isDisabled: true,
                                  fillColor: AppColors.disabledButtonColor,
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
                                PhoneField(
                                  phoneController: _phoneController,
                                  initialValue:
                                      "+977-9800000000",
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      //Button SignUp
                      // _buildButton(context),
                      Consumer<AuthProvider>(builder: (__, authProvider, _) {
                        return GeneralElevatedButton(
                          title: "Save",
                          marginH: 0,
                          loading: authProvider.editLoading,
                          onPressed: () {
                            _onSubmit("+977-9800000000"
                                .split("-")[0]);
                          },
                        );
                      }),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
              ),
            );

          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
