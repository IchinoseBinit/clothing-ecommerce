import 'package:fluttertoast/fluttertoast.dart';

import '/styles/app_colors.dart';

void showToast(String text, {bool isEmergency = false}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor:
        isEmergency ? AppColors.emergencyBgColor : AppColors.alertBgColor,
    textColor:
        isEmergency ? AppColors.emergencyTextColor : AppColors.alertTextColor,
  );
}
