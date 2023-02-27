import 'package:flutter/material.dart';

import '/styles/app_sizes.dart';

class ShowAlertDialog {
  ShowAlertDialog(
      {this.title,
      this.body,
      this.needCancel = false,
      this.noAction = false,
      this.okFunc,
      this.noPadding = false,
      this.cancelFunc,
      this.okTitle,
      this.cancelTitle,
      this.isDoublePop = false,
      this.disableBackground = false,
      this.cancelBtnColor,
      this.okBtnColor});

  String? title;
  String? okTitle;
  String? cancelTitle;
  Widget? body;
  Color? okBtnColor;
  Color? cancelBtnColor;
  bool needCancel;
  bool noAction;
  bool noPadding;
  bool isDoublePop;
  bool disableBackground;
  VoidCallback? cancelFunc;
  VoidCallback? okFunc;

  Future showAlertDialog(BuildContext context) async {
    Widget okButton = TextButton(
      child: Text(
        okTitle ?? "Okay",
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: okBtnColor ?? Colors.green),
      ),
      onPressed: okFunc,
    );

    Widget cancelButton = TextButton(
      child: Text(
        cancelTitle ?? "Cancel",
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: cancelBtnColor ?? Colors.red),
      ),
      onPressed: cancelFunc,
    );

    AlertDialog alert = AlertDialog(
      title: title == null
          ? Icon(
              Icons.report_problem_outlined,
              color: Theme.of(context).errorColor,
            )
          : Text(title!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w600)),
      content: body,
      titlePadding: noPadding
          ? const EdgeInsets.only(
              left: AppSizes.padding,
              right: AppSizes.padding,
              top: AppSizes.padding / 1.4,
            )
          : const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
      contentPadding:
          noPadding ? EdgeInsets.zero : const EdgeInsets.fromLTRB(24, 5, 24, 0),
      actions: noAction
          ? []
          : [
              if (needCancel) cancelButton,
              okButton,
            ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            if (!disableBackground) {
              if (isDoublePop) {
                Navigator.pop(context);
              }
              Navigator.pop(context);
            }
            return false;
          },
          child: alert,
        );
      },
    );
  }
}
