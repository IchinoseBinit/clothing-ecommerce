import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/data/enums/payment_method.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/widgets/general_elevated_button.dart';
import 'package:clothing_ecommerce/widgets/upper_part_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({Key? key}) : super(key: key);

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  PaymentMethod selectedPayment = PaymentMethod.creditCard;

  List<Map> paymentListData = [
    {
      "name": "Credit Card",
      "image": stripeLogo,
      "type": PaymentMethod.creditCard,
    },
    {
      "name": "Khalti",
      "image": khaltiLogo,
      "type": PaymentMethod.khalti,
    },
    {
      "name": "Esewa",
      "image": esewaLogo,
      "type": PaymentMethod.eSewa,
    },
    {
      "name": "Cash on Delivery",
      "image": cashOnDeliveryLogo,
      "type": PaymentMethod.cod,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingLg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UpperContentBottomSheet(title: "Select Payment Method"),
          SizedBox(
            height: 8.h,
          ),
          Column(
            children: paymentListData
                .map(
                  (e) => ListTile(
                    onTap: () {
                      selectedPayment = e["type"] as PaymentMethod;
                      setState(() {});
                    },
                    title: Text(e["name"]),
                    leading: Image.asset(e["image"], height: 40),
                    trailing: Radio(
                      value: e["type"] as PaymentMethod,
                      groupValue: selectedPayment,
                      activeColor: AppColors.primaryColor,
                      onChanged: (PaymentMethod? value) {
                        selectedPayment = value!;
                        setState(() {});
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: AppSizes.paddingLg,
          ),
          GeneralElevatedButton(
            title: "Continue",
            marginH: 0,
          ),
          const SizedBox(
            height: AppSizes.paddingLg,
          ),
        ],
      ),
    );
  }
}
