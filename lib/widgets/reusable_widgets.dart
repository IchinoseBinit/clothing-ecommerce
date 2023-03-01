import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '/styles/app_colors.dart';
import '/styles/styles.dart';

eachHelpText() {
  return Wrap(
    children: [
      Text(
        "If you have any trouble, please contact ",
        style: smallText.copyWith(
          color: AppColors.textSoftGreyColor,
        ),
        softWrap: true,
      ),
      GestureDetector(
        onTap: () {
          launchUrl(Uri.parse("mailto:hello@clothing-ecommerence.com"));
        },
        child: Text(
          "hello@clothing-ecommerence.com.",
          style: smallText.copyWith(
            color: AppColors.primaryColor,
          ),
          softWrap: true,
        ),
      ),
    ],
  );
}
