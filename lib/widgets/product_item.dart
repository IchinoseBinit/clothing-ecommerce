import 'package:clothing_ecommerce/models/product_model.dart';
import 'package:clothing_ecommerce/providers/cart_provider.dart';
import 'package:clothing_ecommerce/screens/product_detail/product_detail_screen.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/navigation_util.dart';
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
              GestureDetector(
                onTap: () {
                  Provider.of<CartProvider>(context, listen: false).addToCart(
                      context,
                      quantity: product.quantity,
                      productId: product.id);
                },
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.padding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: AppColors.iconBtnBgColor,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
