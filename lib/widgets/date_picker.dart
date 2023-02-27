import 'package:flutter/material.dart';

import '/styles/app_colors.dart';

showCustomDatePicker(
  BuildContext context, {
  required DateTime lastDate,
  required DateTime firstDate,
  required DateTime initialDate,
}) async {
  return await showDatePicker(
    context: context,
    lastDate: lastDate,
    initialDate: initialDate,
    firstDate: firstDate,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.grey[50],
          dividerColor: Colors.grey,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.primaryColor,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );
}
