import 'dart:developer';

import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/data/response/status.dart';
import 'package:clothing_ecommerce/providers/cart_provider.dart';
import 'package:clothing_ecommerce/providers/checkout_provider.dart';
import 'package:clothing_ecommerce/screens/checkout/checkout_screen.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/utils/navigation_util.dart';
import 'package:clothing_ecommerce/utils/show_toast.dart';
import 'package:clothing_ecommerce/widgets/alert_bottom_sheet.dart';
import 'package:clothing_ecommerce/widgets/custom_appbar.dart';
import 'package:clothing_ecommerce/widgets/error_info_widget.dart';
import 'package:clothing_ecommerce/widgets/general_elevated_button.dart';
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
    return Consumer<CartProvider>(builder: (_, cartProvider, __) {
      return Scaffold(
        bottomNavigationBar: cartProvider.cartItemList.status ==
                Status.COMPLETED
            ? Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 12,
                      spreadRadius: 8,
                      color: Colors.grey.withOpacity(0.25),
                    ),
                  ],
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(AppSizes.paddingLg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cartProvider.selectAllCartItem(cartProvider
                            .cartItemList.data!
                            .any((element) => element.isSelected == false));
                      },
                      child: Row(
                        children: [
                          Icon(
                            cartProvider.cartItemList.data!.any(
                                    (element) => element.isSelected == false)
                                ? Icons.radio_button_off
                                : Icons.check_circle,
                            color: AppColors.greyColor,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "All",
                            style: bodyText,
                          )
                        ],
                      ),
                    ),
                    GeneralElevatedButton(
                      title: "Checkout (${cartProvider.totalSelectedCart})",
                      onPressed: () {
                        Provider.of<CheckoutProvider>(context, listen: false)
                            .fetchCheckout(context,
                                cartList: cartProvider.selectCartItemList);
                        navigate(
                            context,
                            CheckoutScreen(
                              cartModel: cartProvider.selectCartItemList,
                            ));
                      },
                      marginH: 0,
                      width: 120.h,
                      height: 35.h,
                    )
                  ],
                ),
              )
            : null,
        appBar: CustomAppBar(title: "Cart"),
        body: ScrollConfiguration(
          behavior: MyBehaviour(),
          child: Builder(builder: (_) {
            switch (cartProvider.cartItemList.status) {
              case Status.LOADING:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.ERROR:
                return const ErrorInfoWidget(
                  errorInfo: "Your cart is empty. Try adding some item",
                );
              case Status.COMPLETED:
                if (cartProvider.cartItemList.data!.isEmpty) {
                  return const ErrorInfoWidget(
                    errorInfo: "Your cart is empty. Try adding some item",
                  );
                }
                return ListView.builder(
                  itemCount: cartProvider.cartItemList.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, listViewIndex) => Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      bool isCancel = false;
                      await AlertBottomSheet.showAlertBottomSheet(context,
                          title: "Delete Item",
                          description: "Do you want to delete this item",
                          iconImage: alert,
                          isCancelButton: true, okFunc: () {
                        isCancel = true;

                        Navigator.pop(context);
                      }, cancelFunc: () {
                        isCancel = false;
                        Navigator.pop(context);
                      });

                      return isCancel;
                    },
                    onDismissed: (direction) {
                      log(direction.name);
                      log(direction.index.toString());
                      if (direction.name == "endToStart") {
                        cartProvider.deleteProduct(listViewIndex);
                        showToast(
                            '${cartProvider.cartItemList.data![listViewIndex].product.name} dismissed');
                      }
                    },
                    background: const SizedBox.shrink(),
                    secondaryBackground: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(top: AppSizes.paddingLg),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(Icons.delete, color: Colors.white),
                          SizedBox(
                            width: 8.0,
                          ),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: AppSizes.paddingLg * 1.2,
                          right: AppSizes.paddingLg,
                          left: AppSizes.paddingLg,
                          bottom: listViewIndex ==
                                  (cartProvider.cartItemList.data!.length - 1)
                              ? AppSizes.paddingLg * 2
                              : 0),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Center(
                                child: Icon(
                                  cartProvider.cartItemList.data![listViewIndex]
                                          .isSelected
                                      ? Icons.check_circle
                                      : Icons.radio_button_off,
                                  color: AppColors.greyColor,
                                  size: 24.h,
                                ),
                              ),
                              onTap: () {
                                cartProvider
                                    .selectedSingleCartItem(listViewIndex);
                              },
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r)),
                              height: 75.h,
                              width: 75.h,
                              child: Image.network(
                                cartProvider.cartItemList.data![listViewIndex]
                                    .product.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      cartProvider.cartItemList
                                          .data![listViewIndex].product.name,
                                      style: bodyText),
                                  // Text(
                                  //   provider
                                  //       .cartItemList
                                  //       .data![listViewIndex]
                                  //       .product
                                  //       .description,
                                  //   maxLines: 1,
                                  //   style: smallText.copyWith(
                                  //       color:
                                  //           AppColors.textLightGreyColor),
                                  // ),
                                  Text(
                                      "Size: ${cartProvider.cartItemList.data![listViewIndex].size.title}",
                                      style: smallText.copyWith(
                                          color: AppColors.textLightGreyColor)),
                                  // Text(",",
                                  //     style: smallText.copyWith(
                                  //         color: AppColors
                                  //             .textLightGreyColor)),

                                  Row(
                                    children: [
                                      Text("Color: ",
                                          style: smallText.copyWith(
                                              color: AppColors
                                                  .textLightGreyColor)),
                                      Container(
                                        height: 10.h,
                                        width: 10.h,
                                        decoration: BoxDecoration(
                                            color: Color(int.parse(
                                                "0xff${cartProvider.cartItemList.data![listViewIndex].color.color.substring(1, 7)}")),
                                            borderRadius:
                                                BorderRadius.circular(10.h)),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Rs. ${cartProvider.cartItemList.data![listViewIndex].product.price}",
                                    style: bodyText.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blackColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            OuantityItem(
                              onDecrement: () {},
                              onIncrement: () {},
                              cartIndex: listViewIndex,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              default:
                break;
            }
            return const SizedBox.shrink();
          }),
        ),
      );
    });
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
                padding: const EdgeInsets.all(
                  AppSizes.padding * 1.2,
                ),
                child: Icon(Icons.remove,
                    color: AppColors.darkPrimaryColor, size: 12.h),
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              cartProvider.cartItemList.data![cartIndex].quantity.toString(),
              style: bodyText.copyWith(
                color: AppColors.darkPrimaryColor,
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            GestureDetector(
              onTap: () {
                onDecrement();
                cartProvider.increaseCartItemQuantity(cartIndex);
              },
              child: Container(
                padding: const EdgeInsets.all(
                  AppSizes.padding * 1.2,
                ),
                child: Icon(Icons.add,
                    color: AppColors.darkPrimaryColor, size: 12.h),
              ),
            )
          ],
        ),
      );
    });
  }
}
