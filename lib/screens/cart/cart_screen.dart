import 'package:clothing_ecommerce/data/response/status.dart';
import 'package:clothing_ecommerce/providers/cart_provider.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/utils/show_toast.dart';
import 'package:clothing_ecommerce/widgets/custom_appbar.dart';
import 'package:clothing_ecommerce/widgets/error_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Cart"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
        child: ScrollConfiguration(
          behavior: MyBehaviour(),
          child: Consumer<CartProvider>(builder: (_, provider, __) {
            switch (provider.cartItemList.status) {
              case Status.LOADING:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.ERROR:
                return const ErrorInfoWidget(
                  errorInfo: "Your cart is empty. Try adding some item",
                );
              case Status.COMPLETED:
                if (provider.cartItemList.data!.isEmpty) {
                  return const ErrorInfoWidget(
                    errorInfo: "Your cart is empty. Try adding some item",
                  );
                }
                return Column(
                  children: [
                    const SizedBox(
                      height: AppSizes.paddingLg,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: provider.cartItemList.data!.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const Divider(height: AppSizes.paddingLg * 2),
                        itemBuilder: (context, listViewIndex) => Dismissible(
                          key: Key(provider
                              .cartItemList.data![listViewIndex].product.id
                              .toString()),
                          onDismissed: (direction) {
                            showToast(
                                '${provider.cartItemList.data![listViewIndex].product.name} dismissed');
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r)),
                                  height: 75.h,
                                  width: 75.h,
                                  child: Image.network(
                                    provider.cartItemList.data![listViewIndex]
                                        .product.image,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          provider
                                              .cartItemList
                                              .data![listViewIndex]
                                              .product
                                              .name,
                                          style: bodyText),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        provider
                                            .cartItemList
                                            .data![listViewIndex]
                                            .product
                                            .description,
                                        maxLines: 1,
                                        style: smallText.copyWith(
                                            color:
                                                AppColors.textLightGreyColor),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rs. ${provider.cartItemList.data![listViewIndex].product.price}",
                                            style: bodyText.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                          OuantityItem(
                                            onDecrement: () {},
                                            onIncrement: () {},
                                            cartIndex: listViewIndex,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              default:
                break;
            }
            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}

class OuantityItem extends StatelessWidget {
  final Function onIncrement;
  final Function onDecrement;
  final int cartIndex;
  const OuantityItem({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
    required this.cartIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (_, cartProvider, __) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.lightPrimaryColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                onIncrement();
                cartProvider.decreaseCartItemQuantity(cartIndex);
              },
              child: Container(
                height: AppSizes.iconButtonSmall,
                width: AppSizes.iconButtonSmall,
                margin: const EdgeInsets.only(right: AppSizes.padding),
                child: Icon(Icons.remove,
                    color: AppColors.darkPrimaryColor, size: 10.h),
              ),
            ),
            Container(
                // width: 20.w,
                alignment: Alignment.center,
                child: Text(
                  cartProvider.cartItemList.data![cartIndex].product. quantity
                      .toString(),
                  style: bodyText.copyWith(
                    color: AppColors.darkPrimaryColor,
                  ),
                )),
            SizedBox(
              width: 4.w,
            ),
            GestureDetector(
              onTap: () {
                onDecrement();
                cartProvider.increaseCartItemQuantity(cartIndex);
              },
              child: Container(
                height: AppSizes.iconButtonSmall,
                width: AppSizes.iconButtonSmall,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: AppSizes.padding),
                child: Icon(Icons.add,
                    color: AppColors.darkPrimaryColor, size: 10.h),
              ),
            )
          ],
        ),
      );
    });
  }
}
