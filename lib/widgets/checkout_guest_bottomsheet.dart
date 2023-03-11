import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/models/profile_model.dart';
import '/providers/cart_price_provider.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/phone_field.dart';
import '/styles/app_sizes.dart';
import '/utils/validation_mixin.dart';
import 'general_textfield.dart';
import 'upper_part_bottom_sheet.dart';

class CheckoutGuestBottomSheet extends StatefulWidget {
  final bool isFromPaymentScreen;
  final ProfileModel? data;
  const CheckoutGuestBottomSheet(
      {Key? key, this.isFromPaymentScreen = false, this.data})
      : super(key: key);

  @override
  State<CheckoutGuestBottomSheet> createState() =>
      _CheckoutGuestBottomSheetState();
}

class _CheckoutGuestBottomSheetState extends State<CheckoutGuestBottomSheet> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  late final PhoneNumberInputController _phoneController;
  bool hasError = false;
  FocusNode nameFocusNode = FocusNode();

  FocusNode emailFocusNode = FocusNode();

  FocusNode phoneFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      _emailController.text = widget.data!.email;
      _nameController.text = widget.data!.name;
    }
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UpperContentBottomSheet(
              title: widget.isFromPaymentScreen
                  ? "Update Customer Info"
                  : "Add Customer Info"),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      PhoneField(
                        phoneController: _phoneController,
                        initialValue:
                            widget.data != null ? widget.data!.mobile : null,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                //Button SignUp
                // _buildButton(context),
                Consumer<CartPriceProvider>(
                    builder: (__, cartPriceProvider, _) {
                  return GeneralElevatedButton(
                    title: "Save",
                    marginH: 0,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (widget.isFromPaymentScreen) {
                          Navigator.pop(
                              context,
                              ProfileModel(
                                  email: _emailController.text,
                                  name: _nameController.text,
                                  mobile:
                                      "${_phoneController.selectedCountry.dialCode.trim()}-${_phoneController.phoneNumber.trim()}"));
                          return;
                        }
                        await cartPriceProvider.setGuestUser(
                          ProfileModel(
                              email: _emailController.text,
                              name: _nameController.text,
                              mobile:
                                  "${_phoneController.selectedCountry.dialCode.trim()}-${_phoneController.phoneNumber.trim()}"),
                        );
                        Navigator.pop(context);
                        //Set guest customer profile
                      }
                    },
                  );
                }),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
