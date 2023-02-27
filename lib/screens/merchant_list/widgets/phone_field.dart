import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    Key? key,
    required PhoneNumberInputController phoneController,
    String? initialValue,
  })  : _phoneController = phoneController,
        _initialValue = initialValue,
        super(key: key);

  final PhoneNumberInputController _phoneController;
  final String? _initialValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PhoneNumberInput(
        initialCountry: "US",
        initialValue: _initialValue,
        locale: 'en',
        allowSearch: true,
        searchHint: "Search Country",
        controller: _phoneController,
        countryListMode: CountryListMode.bottomSheet,
        contactsPickerPosition: ContactsPickerPosition.suffix,
        hint: "Phone Number",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xffE3E3E3),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius),
          borderSide: const BorderSide(
            width: 0,
            color: Color(0xffE3E3E3),
          ),
        ),
        errorText: 'Please enter a validate number',
      ),
    );
  }
}
