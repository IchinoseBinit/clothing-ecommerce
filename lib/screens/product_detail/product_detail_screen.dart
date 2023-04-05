import 'dart:developer';

import 'package:clothing_ecommerce/data/response/status.dart';
import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:clothing_ecommerce/providers/cart_provider.dart';
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

import '../../widgets/scroll_sheet_top_bar_icon.dart';

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
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
            body: ScrollConfiguration(
              behavior: MyBehaviour(),
              child: SingleChildScrollView(
                child: Consumer<ProductDetailProvider>(
                    builder: (_, detailProvider, __) {
                  switch (detailProvider.productData.status) {
                    case Status.LOADING:
                      return LoadingWidget(
                        height: .5.sh,
                      );
                    case Status.ERROR:
                      return const ErrorInfoWidget();
                    case Status.COMPLETED:
                      return BodyContent(
                          product: detailProvider.productData.data!);
                    default:
                      return const SizedBox.shrink();
                  }
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BodyContent extends StatelessWidget {
  final ProductModel product;
  BodyContent({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
              product.image,
            ),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          )),
          height: MediaQuery.of(context).size.height * .35,
        ),
        Column(
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
              height: MediaQuery.of(context).size.height * .20,
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
                  const Center(child: ScrollSheetTopBarIcon()),
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
                        style:
                            subTitleText.copyWith(fontWeight: FontWeight.bold),
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
                        children: product.colorList
                            .map((e) => ColorPaletteItem(
                                  index: product.colorList.indexOf(e),
                                  color: int.parse(e.replaceAll("#", "0xff")),
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
                        children: product.sizeList
                            .map(
                              (e) => SizeItem(
                                index: product.sizeList.indexOf(e),
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
                      QuantityItem(
                        onDecrement: () {},
                        onIncrement: () {},
                      ),
                      Consumer<ProductDetailProvider>(
                          builder: (_, productProvider, __) {
                        return Consumer<CartProvider>(
                            builder: (_, cartProvider, __) {
                          return GeneralElevatedButton(
                            marginH: 0,
                            title: "Add to Cart",
                            width: 180,
                            borderRadius: 30.r,
                            loading: cartProvider.loading,
                            onPressed: () {
                              cartProvider.addToCart(context,
                                  quantity: productProvider.selectedQuantity,
                                  color: product
                                      .color[productProvider.selectedColorIndex]
                                      .id,
                                  size: product
                                      .size[productProvider.selectedSizeIndex]
                                      .id,
                                  productId: product.id);
                            },
                          );
                        });
                      })
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
      ],
    );
  }
}

class ColorPaletteItem extends StatelessWidget {
  final int index;
  final int color;
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
            boxShadow: [
              BoxShadow(
                  offset: const Offset(1, 1),
                  // blurRadius: 1,
                  // spreadRadius: 0,
                  color: AppColors.blackColor.withOpacity(0.1))
            ],
            color: Color(color),
          ),
          child: detailProvider.selectedColorIndex == index
              ? Container(
                  height: 15.h,
                  width: 15.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.r),
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, 1),
                            blurRadius: 1,
                            spreadRadius: 0,
                            color: AppColors.blackColor.withOpacity(0.1))
                      ]),
                  child: Icon(Icons.check_outlined,
                      color: AppColors.darkPrimaryColor, size: 8.h),
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

class QuantityItem extends StatelessWidget {
  final Function onIncrement;
  final Function onDecrement;
  const QuantityItem({
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
            onTap: detailProvider.showQuantity
                ? () {
                    onDecrement();
                    detailProvider.onDecrement();
                    log("decrement");
                  }
                : null,
            child: Container(
              height: AppSizes.iconButtonSize,
              width: AppSizes.iconButtonSize,
              margin: const EdgeInsets.only(right: AppSizes.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: AppColors.iconBtnBgColor,
              ),
              child: Icon(Icons.remove,
                  color: detailProvider.showQuantity
                      ? AppColors.blackColor
                      : AppColors.greyColor,
                  size: 18.h),
            ),
          ),
          Container(
            width: 20.w,
            alignment: Alignment.center,
            child: Text(
              detailProvider.selectedQuantity.toString(),
              style: bodyText.copyWith(
                color: detailProvider.showQuantity
                    ? AppColors.blackColor
                    : AppColors.greyColor,
              ),
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          GestureDetector(
            onTap: detailProvider.showQuantity
                ? () {
                    onIncrement();
                    detailProvider.onIncrement();
                    log("increment");
                  }
                : null,
            child: Container(
              height: AppSizes.iconButtonSize,
              width: AppSizes.iconButtonSize,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: AppSizes.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: AppColors.iconBtnBgColor,
              ),
              child: Icon(Icons.add,
                  color: detailProvider.showQuantity
                      ? AppColors.blackColor
                      : AppColors.greyColor,
                  size: 16.h),
            ),
          )
        ],
      );
    });
  }
}
