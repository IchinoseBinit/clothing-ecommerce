import 'package:clothing_ecommerce/data/constants/contants.dart';
import 'package:clothing_ecommerce/data/response/status.dart';
import 'package:clothing_ecommerce/providers/location_provider.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/widgets/error_info_widget.dart';
import 'package:clothing_ecommerce/widgets/upper_part_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectLocationBottomSheet extends StatefulWidget {
  final Function(int, String) onEdit;
  final VoidCallback onAdd;
  const SelectLocationBottomSheet({
    super.key,
    required this.onEdit,
    required this.onAdd,
  });

  @override
  State<SelectLocationBottomSheet> createState() =>
      _SelectLocationBottomSheetState();
}

class _SelectLocationBottomSheetState extends State<SelectLocationBottomSheet> {


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
                const UpperContentBottomSheet(title: "Select Shipping Address"),
                SizedBox(
                  height: 8.h,
                ),
                Consumer<LocationProvider>(builder: (__, locationProvider, _) {
                  switch (locationProvider.locationList.status) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return const ErrorInfoWidget();
                    case Status.COMPLETED:
                      return Expanded(
                        child: BodyContent(
                          locationProvider: locationProvider,
                          onAdd: widget.onAdd,
                          onEdit: widget.onEdit,
                        ),
                      );
                    default:
                  }
                  return const SizedBox.shrink();
                }),
              ],
            );
          default:
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class BodyContent extends StatelessWidget {
  final LocationProvider locationProvider;
  final Function(int, String) onEdit;
  final VoidCallback onAdd;
  const BodyContent({
    super.key,
    required this.locationProvider,
    required this.onEdit,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehaviour(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSizes.paddingLg),
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
                              locationProvider.locationList.data![index].name,
                              style: bodyText.copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            if (locationProvider
                                .locationList.data![index].defaultVal)
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
                            Text(locationProvider
                                .locationList.data![index].address),
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
                              onEdit(
                                  locationProvider.locationList.data![index].id,
                                  locationProvider
                                      .locationList.data![index].name);
                            },
                            child: Text(
                              "Edit",
                              style: smallText,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              locationProvider.setSelected(index);
                            },
                            child: Icon(
                              locationProvider
                                      .locationList.data![index].isSelected
                                  ? Icons.check_circle
                                  : Icons.radio_button_off,
                              color: AppColors.greyColor,
                              size: 18.h,
                            ),
                          ),
                          const SizedBox.shrink()
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  onAdd();
                },
                child: Container(
                  height: AppSizes.iconButtonSize * 1.2,
                  width: AppSizes.iconButtonSize * 1.2,
                  margin: const EdgeInsets.only(right: AppSizes.padding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: AppColors.iconBtnBgColor,
                  ),
                  child: Icon(Icons.add,
                      color: AppColors.primaryColor, size: 22.h),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
