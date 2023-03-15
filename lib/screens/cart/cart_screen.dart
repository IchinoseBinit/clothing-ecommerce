import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/providers/cart_provider.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/utils/show_toast.dart';
import 'package:clothing_ecommerce/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Cart"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
        child: ScrollConfiguration(
          behavior: MyBehaviour(),
          child: Column(
            children: [
              const SizedBox(
                height: AppSizes.paddingLg,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      const Divider(height: AppSizes.paddingLg),
                  itemBuilder: (context, index) => Dismissible(
                    key: const Key("1111"),
                    onDismissed: (direction) {
                      showToast('1 dismissed');
                    },
                    background: const SizedBox.shrink(),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.delete, color: Colors.white),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text('Remove',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r)),
                            height: 120,
                            width: 120,
                            child: Image.network(
                              staticImage,
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Denim pant", style: bodyText),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "Rs. 2000",
                                style: smallText.copyWith(
                                    color: AppColors.greyColor),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              OuantityItem(
                                onDecrement: () {},
                                onIncrement: () {},
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OuantityItem extends StatelessWidget {
  final Function onIncrement;
  final Function onDecrement;
  const OuantityItem({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (_, detailProvider, __) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              onDecrement();
              // detailProvider.onDecrement();
            },
            child: Container(
              height: AppSizes.iconButtonSmall,
              width: AppSizes.iconButtonSmall,
              margin: const EdgeInsets.only(right: AppSizes.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: AppColors.iconBtnBgColor,
              ),
              child:
                  Icon(Icons.remove, color: AppColors.blackColor, size: 10.h),
            ),
          ),
          Container(
              width: 20.w, alignment: Alignment.center, child: const Text("1")),
          SizedBox(
            width: 4.w,
          ),
          GestureDetector(
            onTap: () {
              onIncrement();
              // detailProvider.onIncrement();
            },
            child: Container(
              height: AppSizes.iconButtonSmall,
              width: AppSizes.iconButtonSmall,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: AppSizes.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: AppColors.iconBtnBgColor,
              ),
              child: Icon(Icons.add, color: AppColors.blackColor, size: 10.h),
            ),
          )
        ],
      );
    });
  }
}
