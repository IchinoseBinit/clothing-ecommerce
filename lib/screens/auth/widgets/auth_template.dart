import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
