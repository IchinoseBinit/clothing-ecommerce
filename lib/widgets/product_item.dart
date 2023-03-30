import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:clothing_ecommerce/providers/cart_provider.dart';
import 'package:clothing_ecommerce/providers/product_detail_provider.dart';
import 'package:clothing_ecommerce/screens/product_detail/product_detail_screen.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/navigation_util.dart';
import 'package:clothing_ecommerce/widgets/general_elevated_button.dart';
import 'package:clothing_ecommerce/widgets/scroll_sheet_top_bar_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigate(context, ProductDetailScreen(productId: product.id));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: AppSizes.padding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: bodyText.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: AppSizes.padding / 1.7,
                  ),
                  Text(
                    "Rs.${product.price}",
                    style: subTitleText.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // GestureDetector(
              //   onTap: () {
              //     showModalBottomSheet(
              //       context: context,
              //       isScrollControlled: true,
              //       shape: const RoundedRectangleBorder(
              //           borderRadius: BorderRadius.vertical(
              //         top: Radius.circular(30),
              //       )),
              //       builder: (context) => Container(
              //         decoration: const BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(AppSizes.radius),
              //           topRight: Radius.circular(AppSizes.radius),
              //         )),
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: AppSizes.paddingLg),
              //         child: Column(mainAxisSize: MainAxisSize.min, children: [
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               const SizedBox(height: AppSizes.paddingLg),
              //               const Center(child: ScrollSheetTopBarIcon()),
              //               const SizedBox(height: AppSizes.paddingLg * 1.5),
              //               Text(
              //                 "Color",
              //                 style: bodyText.copyWith(
              //                     fontWeight: FontWeight.w500),
              //               ),
              //               const SizedBox(
              //                 height: AppSizes.padding,
              //               ),
              //               Row(
              //                 children: product.colorList
              //                     .map((e) => ColorPaletteItem(
              //                           index: product.colorList.indexOf(e),
              //                           color: int.parse(
              //                               e.replaceAll("#", "0xff")),
              //                         ))
              //                     .toList(),
              //               ),
              //             ],
              //           ),
              //           const SizedBox(
              //             height: AppSizes.paddingLg,
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "Size",
              //                 style: bodyText.copyWith(
              //                     fontWeight: FontWeight.w500),
              //               ),
              //               const SizedBox(
              //                 height: AppSizes.padding,
              //               ),
              //               Row(
              //                 children: product.sizeList
              //                     .map(
              //                       (e) => SizeItem(
              //                         index: product.sizeList.indexOf(e),
              //                         label: e,
              //                       ),
              //                     )
              //                     .toList(),
              //               ),
              //             ],
              //           ),
              //           const SizedBox(
              //             height: AppSizes.paddingLg * 1.5,
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               OuantityItem(
              //                 onDecrement: () {},
              //                 onIncrement: () {},
              //               ),
              //               Consumer<ProductDetailProvider>(
              //                   builder: (_, productProvider, __) {
              //                 return Consumer<CartProvider>(
              //                     builder: (_, cartProvider, __) {
              //                   return GeneralElevatedButton(
              //                     marginH: 0,
              //                     title: "Add to Cart",
              //                     width: 180,
              //                     borderRadius: 30.r,
              //                     loading: cartProvider.loading,
              //                     onPressed: () async {
              //                       await cartProvider.addToCart(context,
              //                           quantity:
              //                               productProvider.selectedQuantity,
              //                           color: product
              //                               .color[productProvider
              //                                   .selectedColorIndex]
              //                               .id,
              //                           size: product
              //                               .size[productProvider
              //                                   .selectedSizeIndex]
              //                               .id,
              //                           productId: product.id);
              //                       if (context.mounted) {
              //                         Navigator.pop(context);
              //                       }
              //                     },
              //                   );
              //                 });
              //               })
              //             ],
              //           ),
              //           const SizedBox(
              //             height: AppSizes.paddingLg * 2,
              //           ),
              //         ]),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.all(AppSizes.padding),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(50.r),
              //       color: AppColors.iconBtnBgColor,
              //     ),
              //     child: const Icon(
              //       Icons.shopping_bag_outlined,
              //     ),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
