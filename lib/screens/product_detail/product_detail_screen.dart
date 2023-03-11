import 'dart:developer';

import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:clothing_ecommerce/providers/product_detail_provider.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/widgets/general_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  List<MaterialColor> productColors = [
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
    Colors.brown,
  ];
  List<String> productSizes = [
    "S",
    "M",
    "L",
    "XL",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.height * .45,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                    color: AppColors.backgroundColor,
                  ),
                  padding: const EdgeInsets.only(
                    left: AppSizes.paddingLg * 2,
                    right: AppSizes.paddingLg * 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSizes.paddingLg),
                      Center(
                        child: Container(
                          height: 4.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingLg * 1.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            style: subTitleText.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rs.${product.price}",
                            style: subTitleText.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.paddingLg * 1.5,
                      ),
                      Text(
                        product.description,
                        style:
                            bodyText.copyWith(color: AppColors.textGreyColor),
                      ),
                      const SizedBox(
                        height: AppSizes.paddingLg * 1.5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Color",
                            style:
                                bodyText.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: AppSizes.padding,
                          ),
                          Row(
                            children: productColors
                                .map((e) => IgnorePointer(
                                      child: ColorPaletteItem(
                                        index: productColors.indexOf(e),
                                        color: e,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.paddingLg,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Size",
                            style:
                                bodyText.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: AppSizes.padding,
                          ),
                          Row(
                            children: productSizes
                                .map(
                                  (e) => IgnorePointer(
                                    child: SizeItem(
                                      index: productSizes.indexOf(e),
                                      label: e,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.paddingLg * 1.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OuantityItem(
                            onDecrement: () {},
                            onIncrement: () {},
                          ),
                          GeneralElevatedButton(
                            marginH: 0,
                            title: "Add to Cart",
                            width: 180,
                            borderRadius: 30.r,
                            onPressed: () {
                              //TODO: added to cart functionality
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.paddingLg,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ColorPaletteItem extends StatelessWidget {
  final int index;
  final MaterialColor color;
  const ColorPaletteItem({
    super.key,
    required this.index,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailProvider>(builder: (_, detailProvider, __) {
      return GestureDetector(
        onTap: () {
          detailProvider.setSelectedColorIndex(index);
          log("clicked");
        },
        child: Container(
          height: 30.h,
          width: 30.h,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: AppSizes.padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: color,
          ),
          child: detailProvider.selectedColorIndex == index
              ? Container(
                  height: 15.h,
                  width: 15.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    color: AppColors.whiteColor,
                  ),
                  child: Icon(Icons.check_outlined, color: color, size: 8.h),
                )
              : null,
        ),
      );
    });
  }
}

class SizeItem extends StatelessWidget {
  final int index;
  final String label;
  const SizeItem({
    super.key,
    required this.index,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailProvider>(builder: (_, detailProvider, __) {
      return GestureDetector(
        onTap: () {
          detailProvider.setSelectedSizeIndex(index);
          log("clicked");
        },
        child: Container(
          height: 30.h,
          width: 30.h,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: AppSizes.padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: detailProvider.selectedSizeIndex == index
                ? AppColors.blackColor
                : AppColors.iconBtnBgColor,
          ),
          child: Text(
            label,
            style: bodyText.copyWith(
                color: detailProvider.selectedSizeIndex == index
                    ? AppColors.whiteColor
                    : AppColors.blackColor),
          ),
        ),
      );
    });
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
    return Consumer<ProductDetailProvider>(builder: (_, detailProvider, __) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              onDecrement();
              detailProvider.onDecrement();
              log("decrement");
            },
            child: Container(
              height: 30.h,
              width: 30.h,
              margin: const EdgeInsets.only(right: AppSizes.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: AppColors.iconBtnBgColor,
              ),
              child:
                  Icon(Icons.remove, color: AppColors.blackColor, size: 18.h),
            ),
          ),
          SizedBox(
            width: 6.w,
          ),
          Text(detailProvider.selectedQuantity.toString()),
          SizedBox(
            width: 10.w,
          ),
          GestureDetector(
            onTap: () {
              onIncrement();
              detailProvider.onIncrement();
              log("increment");
            },
            child: Container(
              height: 30.h,
              width: 30.h,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: AppSizes.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: AppColors.iconBtnBgColor,
              ),
              child: Icon(Icons.add, color: AppColors.blackColor, size: 16.h),
            ),
          )
        ],
      );
    });
  }
}
