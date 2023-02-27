import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/widgets/scroll_sheet_top_bar_icon.dart';

class UpperContentBottomSheet extends StatelessWidget {
  final String title;
  const UpperContentBottomSheet({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSizes.padding,
        ),
        const ScrollSheetTopBarIcon(),
        const SizedBox(
          height: AppSizes.padding,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: bodyText.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 24.r,
                ),
              )
            ],
          ),
        ),
        Divider(
          color: Colors.grey.shade200,
          thickness: 1,
        ),
      ],
    );
  }
}
