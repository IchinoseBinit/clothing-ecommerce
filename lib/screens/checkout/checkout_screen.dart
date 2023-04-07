import 'package:clothing_ecommerce/data/constants/contants.dart';
import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/data/response/status.dart';
import 'package:clothing_ecommerce/models/cart_model.dart';
import 'package:clothing_ecommerce/providers/checkout_provider.dart';
import 'package:clothing_ecommerce/providers/location_provider.dart';
import 'package:clothing_ecommerce/screens/checkout/widgets/select_location_bottom_sheet.dart';
import 'package:clothing_ecommerce/screens/map/map_screen.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/utils/navigation_util.dart';
import 'package:clothing_ecommerce/widgets/custom_appbar.dart';
import 'package:clothing_ecommerce/widgets/each_price_item.dart';
import 'package:clothing_ecommerce/widgets/error_info_widget.dart';
import 'package:clothing_ecommerce/widgets/general_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartModel> cartModel;
  const CheckoutScreen({Key? key, required this.cartModel}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // _checkDeliveryIsLocationIsValid({required bool isDelivery}) {
  //   AlertBottomSheet.showAlertBottomSheet(
  //     context,
  //     title: "Select new location",
  //     description:
  //         "We regret to inform you that delivery is not available in the selected location. To proceed with checking out the items in your cart, please choose a different delivery location.",
  //     iconImage: alert,
  //     cancelTitle: "Cancel",
  //     isCancelButton: true,
  //     okFunc: () async {
  //       await _selectMap(true);
  //       Navigator.pop(context);
  //     },
  //     cancelFunc: () {
  //       Navigator.pop(context);
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).fetchLocationList();
  }

  Future<void> _selectMap(bool isUpdateLocation,
      {int? id, String? addressName}) async {
    final Map? selectedLocation = await navigate(
        context, MapScreen(addressName: addressName),
        fullscreenDialog: true);

    if (selectedLocation != null) {
      await Provider.of<LocationProvider>(context, listen: false).setLocation(
          context,
          isUpdateAddress: isUpdateLocation,
          id: id,
          address: LatLng(selectedLocation["location"].latitude,
              selectedLocation["location"].longitude),
          locationName: selectedLocation["name"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(builder: (_, provider, __) {
      return Scaffold(
        bottomNavigationBar: provider.checkoutData.status == Status.COMPLETED
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
                child: GeneralElevatedButton(
                  title: "Place Order",
                  onPressed: () {
                    // Provider.of<OrderProvider>(context, listen: false)
                    //     .order(context,
                    //         cartList: cartProvider.selectCartItemList);
                    // navigate(
                    //     context,
                    //    );
                  },
                  marginH: 0,
                ),
              )
            : null,
        appBar: CustomAppBar(
          disableLeading: true,
          title: "Checkout Screen",
        ),
        body: Builder(builder: (_) {
          switch (provider.checkoutData.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.ERROR:
              return const ErrorInfoWidget(
              );
            case Status.COMPLETED:
              return ScrollConfiguration(
                behavior: MyBehaviour(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: generalBoxShadow,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppSizes.radius),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingLg),
                        child: GestureDetector(
                          onTap: () async {
                            //  Provider.of<LocationProvider>(context, listen: false)
                            //     .setLocation(saveLocation: true);
                            //TODO: location todos

                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              )),
                              builder: (context) => Consumer<LocationProvider>(
                                  builder: (_, provider, __) {
                                return DraggableScrollableSheet(
                                    initialChildSize: .6,
                                    minChildSize: .6,
                                    maxChildSize: .9,
                                    expand: false,
                                    builder: (context, scrollController) {
                                      return SelectLocationBottomSheet(
                                        onEdit: (int id, String addressName) {
                                          //TODO: edit map
                                          _selectMap(true,
                                              id: id, addressName: addressName);
                                        },
                                        onAdd: () {
                                          _selectMap(
                                            false,
                                          );
                                        },
                                      );
                                    });
                              }),
                            );
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                color: Colors.transparent,
                                padding:
                                    EdgeInsets.only(right: 16.w, left: 16.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SvgPicture.asset(
                                      locationIcon,
                                      height: AppSizes.iconHeight,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Delivery Location",
                                          style: bodyText.copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .70,
                                          child: Text(
                                              Provider.of<LocationProvider>(
                                                      context)
                                                  .stAdd,
                                              softWrap: true,
                                              maxLines: 3,
                                              style: smallText.copyWith(
                                                color:
                                                    AppColors.textSoftGreyColor,
                                              )),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18.sp,
                                      color: AppColors.primaryColor,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.paddingLg,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: generalBoxShadow,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppSizes.radius),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingLg),
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: provider.checkoutData.data!.datam.length,
                            separatorBuilder: (context, index) => const Divider(
                                  height: AppSizes.paddingLg,
                                ),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(
                                  bottom: AppSizes.padding * 1.5,
                                  right: AppSizes.padding * 1.5,
                                  left: AppSizes.padding * 1.5,
                                  top: index == 0
                                      ? AppSizes.paddingLg
                                      : AppSizes.padding * 1.5,
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        height: 75.h,
                                        width: 75.h,
                                        child: Image.network(
                                          provider.checkoutData.data!
                                              .datam[index].product.image,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                provider.checkoutData.data!
                                                    .datam[index].product.name,
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
                                                "Size: ${provider.checkoutData.data!.datam[index].size.title}",
                                                style: smallText.copyWith(
                                                    color: AppColors
                                                        .textLightGreyColor)),
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
                                                      color: Color(
                                                        int.parse(
                                                            "0xff${provider.checkoutData.data!.datam[index].color.color.substring(1, 7)}"),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.h)),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Rs.${provider.checkoutData.data!.datam[index].product.price.toString()}",
                                                  style: bodyText.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.blackColor,
                                                  ),
                                                ),
                                                Text(
                                                  "Qty:${provider.checkoutData.data!.datam[index].quantity}",
                                                  style: bodyText.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.blackColor,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: AppSizes.paddingLg,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingLg,
                        ),
                        padding: const EdgeInsets.all(
                          AppSizes.paddingLg,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: generalBoxShadow,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppSizes.radius),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EachPriceItem(
                              isSubTotal: true,
                              title: "Subtotal",
                              value: "Rs. 2000",
                            ),
                            const SizedBox(height: AppSizes.padding),
                            EachPriceItem(
                              title: "Delivery Fee",
                              value: "Rs.100",
                            ),
                            const Divider(
                              height: AppSizes.paddingLg * 1.5,
                            ),
                            EachPriceItem(
                              title: "Total",
                              value: "Rs.2100",
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),
                       const SizedBox(
                        height: AppSizes.paddingLg,
                      ),
                    ],
                  ),
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        }),
      );
    });
  }
}
