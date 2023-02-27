import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/styles/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.title = "",
    this.titleWidget,
    this.leading,
    this.actions,
    this.bottom,
    this.backgroundColor,
    this.toolbarHeight,
    this.leadingFunc,
    this.centerTitle = false,
    this.disableLeading = false,
    this.automaticallyImplyLeading = true,
  })  : preferredSize = Size.fromHeight(toolbarHeight ?? kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  final String title;
  final Widget? titleWidget;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final bool disableLeading;
  final double? toolbarHeight;
  final Widget? leading;
  final VoidCallback? leadingFunc;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leadingWidth: disableLeading ? 16 : 50,
      leading: disableLeading
          ? const SizedBox.shrink()
          : leading ??
              InkWell(
                onTap: leadingFunc ?? () => Navigator.pop(context),
                child: Icon(
                  size: 24.r,
                  CupertinoIcons.chevron_back,
                  color: Colors.white,
                ),
              ),
      title: titleWidget ??
          AutoSizeText(
            title,
            maxFontSize: 22,
            minFontSize: 16,
            maxLines: 1,
          ),
      elevation: 0.0,
      titleSpacing: 0,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      centerTitle: centerTitle,
      actions: actions,
      bottom: bottom,
    );
  }
}
