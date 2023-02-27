import 'package:flutter/material.dart';

import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';

class ScrollSheetTopBarIcon extends StatelessWidget {
  const ScrollSheetTopBarIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius),
          color: AppColors.greyColor.withOpacity(0.5)),
      height: 5,
      width: 40,
    );
  }
}
