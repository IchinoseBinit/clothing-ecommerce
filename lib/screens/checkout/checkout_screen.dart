import 'package:clothing_ecommerce/data/constants/contants.dart';
import 'package:clothing_ecommerce/data/constants/image_constants.dart';
import 'package:clothing_ecommerce/models/cart_model.dart';
import 'package:clothing_ecommerce/providers/location_provider.dart';
import 'package:clothing_ecommerce/screens/checkout/widgets/select_location_bottom_sheet.dart';
import 'package:clothing_ecommerce/screens/map/map_screen.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/navigation_util.dart';
import 'package:clothing_ecommerce/widgets/custom_appbar.dart';
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
    return Scaffold(
      appBar: CustomAppBar(
        disableLeading: true,
        title: "Checkout Screen",
      ),
      body: Column(
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
            margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
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
                  builder: (context) =>
                      Consumer<LocationProvider>(builder: (_, provider, __) {
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
                    padding: EdgeInsets.only(right: 16.w, left: 16.w),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Location",
                              style: bodyText.copyWith(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .70,
                              child: Text(
                                  Provider.of<LocationProvider>(context).stAdd,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: smallText.copyWith(
                                    color: AppColors.textSoftGreyColor,
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
          const Card()
        ],
      ),
    );
  }
}
