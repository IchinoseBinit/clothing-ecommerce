import 'package:clothing_ecommerce/data/constants/contants.dart';
import 'package:clothing_ecommerce/data/response/status.dart';
import 'package:clothing_ecommerce/providers/location_provider.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/widgets/error_info_widget.dart';
import 'package:clothing_ecommerce/widgets/upper_part_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectLocationBottomSheet extends StatefulWidget {
  final VoidCallback onEdit;
  const SelectLocationBottomSheet({
    super.key,
    required this.onEdit,
  });

  @override
  State<SelectLocationBottomSheet> createState() =>
      _SelectLocationBottomSheetState();
}

class _SelectLocationBottomSheetState extends State<SelectLocationBottomSheet> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).fetchLocationList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (__, locationProvider, _) {
        switch (locationProvider.locationList.status) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return const Center(child: ErrorInfoWidget());
          case Status.COMPLETED:
            return Column(
              children: [
                const UpperContentBottomSheet(title: "Select Category"),
                SizedBox(
                  height: 8.h,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingLg),
                    itemCount: locationProvider.locationList.data!.length,
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(AppSizes.paddingLg),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          boxShadow: generalBoxShadow,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radius,
                          )),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Niraj Karanjeet",
                                    style: bodyText.copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 2.h,
                                      horizontal: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.radius / 3,
                                      ),
                                    ),
                                    child: Text(
                                      "Default Shipping Address",
                                      style: verySmallText.copyWith(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  const Text(
                                      "Jayabageshowri, Bagmati Province, Kathmandu Metro 8 - Gausala Area, Gaushala"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    widget.onEdit();
                                  },
                                  child: Text(
                                    "Edit",
                                    style: smallText,
                                  ),
                                ),
                                Icon(
                                  true
                                      ? Icons.check_circle
                                      : Icons.radio_button_off,
                                  color: AppColors.greyColor,
                                  size: 18.h,
                                ),
                                const SizedBox.shrink()
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          default:
        }
        return Container();
      },
    );
  }
}
