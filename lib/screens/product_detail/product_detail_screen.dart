import 'dart:developer';

import 'package:clothing_ecommerce/data/response/status.dart';
import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:clothing_ecommerce/providers/product_detail_provider.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/widgets/error_info_widget.dart';
import 'package:clothing_ecommerce/widgets/general_elevated_button.dart';
import 'package:clothing_ecommerce/widgets/general_icon_button.dart';
import 'package:clothing_ecommerce/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  ProductDetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductDetailProvider>(context, listen: false)
        .fetchProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: SingleChildScrollView(
          child:
              Consumer<ProductDetailProvider>(builder: (_, detailProvider, __) {
            switch (detailProvider.productData.status) {
              case Status.LOADING:
                return LoadingWidget(
                  height: .5.sh,
                );
              case Status.ERROR:
                return const ErrorInfoWidget();
              case Status.COMPLETED:
                return BodyContent(product: detailProvider.productData.data!);
              default:
                return const SizedBox.shrink();
            }
          }),
        ),
      ),
    );
  }
}

class BodyContent extends StatelessWidget {
  final ProductModel product;
  BodyContent({
    super.key,
    required this.product,
  });

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
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(
          product.image,
        ),
        fit: BoxFit.fitWidth,
        alignment: Alignment.topCenter,
      )),
      child: Column(
        children: [
          const SizedBox(
            height: AppSizes.paddingLg * 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppSizes.paddingLg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GeneralIconButton(
                    iconData: Icons.arrow_back_ios_new_outlined,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                const SizedBox.shrink()
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .30,
          ),
          Container(
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
                      style: subTitleText.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSizes.paddingLg * 1.5,
                ),
                Text(
                  product.description,
                  style: bodyText.copyWith(color: AppColors.textGreyColor),
                ),
                const SizedBox(
                  height: AppSizes.paddingLg * 1.5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Color",
                      style: bodyText.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: AppSizes.padding,
                    ),
                    Row(
                      children: productColors
                          .map((e) => ColorPaletteItem(
                                index: productColors.indexOf(e),
                                color: e,
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
                      style: bodyText.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: AppSizes.padding,
                    ),
                    Row(
                      children: productSizes
                          .map(
                            (e) => SizeItem(
                              index: productSizes.indexOf(e),
                              label: e,
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
                  height: AppSizes.paddingLg * 2,
                ),
              ],
            ),
          )
        ],
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
          height: AppSizes.iconButtonSize,
          width: AppSizes.iconButtonSize,
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
          height: AppSizes.iconButtonSize,
          width: AppSizes.iconButtonSize,
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
              height: AppSizes.iconButtonSize,
              width: AppSizes.iconButtonSize,
              margin: const EdgeInsets.only(right: AppSizes.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: AppColors.iconBtnBgColor,
              ),
              child:
                  Icon(Icons.remove, color: AppColors.blackColor, size: 18.h),
            ),
          ),
          Container(
              width: 20.w,
              alignment: Alignment.center,
              child: Text(detailProvider.selectedQuantity.toString())),
          SizedBox(
            width: 4.w,
          ),
          GestureDetector(
            onTap: () {
              onIncrement();
              detailProvider.onIncrement();
              log("increment");
            },
            child: Container(
              height: AppSizes.iconButtonSize,
              width: AppSizes.iconButtonSize,
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
