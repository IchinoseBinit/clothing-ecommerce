import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:flutter/material.dart';

class GeneralIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final double? size;
  const GeneralIconButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        padding:size==null? const EdgeInsets.all(AppSizes.padding):null,
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
