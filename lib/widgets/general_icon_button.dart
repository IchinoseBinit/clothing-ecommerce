import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:flutter/material.dart';

class GeneralIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  const GeneralIconButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.greyColor,
        ),
        child: Icon(
          iconData,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
