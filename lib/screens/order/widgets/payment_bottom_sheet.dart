import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/data/enums/payment_methods.dart';
import 'package:clothing_ecommerce/providers/payment_gateway_provider.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/widgets/general_elevated_button.dart';
import 'package:clothing_ecommerce/widgets/upper_part_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({Key? key}) : super(key: key);

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  PaymentMethodEnum selectedPayment = PaymentMethodEnum.creditCard;

  List<Map> paymentListData = [
    {
      "name": "Credit Card",
      "image": stripeLogo,
      "type": PaymentMethodEnum.creditCard,
    },
    {
      "name": "Khalti",
      "image": khaltiLogo,
      "type": PaymentMethodEnum.khalti,
    },
    {
      "name": "Esewa",
      "image": esewaLogo,
      "type": PaymentMethodEnum.eSewa,
    },
    {
      "name": "Cash on Delivery",
      "image": cashOnDeliveryLogo,
      "type": PaymentMethodEnum.cod,
    },
  ];

  onSubmit(BuildContext context,
      {required PaymentMethodEnum paymentMethod}) async {
    await Provider.of<PaymentProvider>(context, listen: false)
        .onPayment(context, total: 1000, paymentMethod: paymentMethod);
  }

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
                      selectedPayment = e["type"] as PaymentMethodEnum;
                      setState(() {});
                    },
                    title: Text(e["name"]),
                    leading: Image.asset(
                      e["image"],
                      height: 40,
                      width: 40,
                    ),
                    trailing: Radio(
                      value: e["type"] as PaymentMethodEnum,
                      groupValue: selectedPayment,
                      activeColor: AppColors.primaryColor,
                      onChanged: (PaymentMethodEnum? value) {
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
            onPressed: () {
              onSubmit(context, paymentMethod: selectedPayment);
            },
          ),
          const SizedBox(
            height: AppSizes.paddingLg,
          ),
        ],
      ),
    );
  }
}
