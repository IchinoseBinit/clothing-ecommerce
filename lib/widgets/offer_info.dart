import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '/data/constants/image_constants.dart';
import '/data/response/status.dart';
import '/providers/coupon_provider.dart';
import '/screens/merchant_list/widgets/general_elevated_button.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/validation_mixin.dart';
import '/widgets/error_info_widget.dart';
import '/widgets/general_textfield.dart';
import '/widgets/upper_part_bottom_sheet.dart';

class OfferInfo extends StatefulWidget {
  final int merchantId;
  final Function? onBtnTap;
  final bool isFromDetail;

  OfferInfo({
    Key? key,
    required this.merchantId,
    this.onBtnTap,
    this.isFromDetail = false,
  }) : super(key: key);

  @override
  State<OfferInfo> createState() => _OfferInfoState();
}

class _OfferInfoState extends State<OfferInfo> {
  final _formStateKey = GlobalKey<FormState>();
  final couponController = TextEditingController();
  FocusNode focus = FocusNode();
  // bool onFocusChange() {
  //   if (focus.hasFocus) {
  //     log("has focus");
  //     return true;
  //   } else {
  //     log("has not focus");
  //     return false;
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // focus.addListener(onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<CouponProvider>(context, listen: false)
                  .fetchCoupon(widget.merchantId);
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  )),
                  builder: (context) => Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.top),
                        child: SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom != 0
                              ? MediaQuery.of(context).size.height / 1.5
                              : MediaQuery.of(context).size.height / 1.8,
                          // padding: EdgeInsets.only(
                          //   bottom: MediaQuery.of(context).viewInsets.bottom +
                          //       AppSizes.padding,
                          // ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const UpperContentBottomSheet(title: "Offer"),
                              SizedBox(
                                height: 5.h,
                              ),
                              if (widget.isFromDetail == false)
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.paddingLg),
                                  child: Form(
                                    key: _formStateKey,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: GeneralTextField(
                                            focusNode: focus,
                                            isSmallText: true,
                                            centerText: false,
                                            removeRightBorder: true,
                                            controller: couponController,
                                            removePrefixIconDivider: true,
                                            borderColor: AppColors.buttonColor,
                                            obscureText: false,
                                            keywordType: TextInputType.text,
                                            validate: (value) => Validation()
                                                .validate(value,
                                                    title: "coupon code"),
                                            onFieldSubmit: () {},
                                            textInputAction:
                                                TextInputAction.done,
                                            onSave: (_) {},
                                            hintText: "Coupon Code: Eg. WQSQ1",
                                          ),
                                        ),
                                        GeneralElevatedButton(
                                          title: "Apply",
                                          width: 78.w,
                                          height: 48,
                                          isSmallText: true,
                                          marginH: 0,
                                          customBorderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8.r),
                                            bottomRight: Radius.circular(8.r),
                                          ),
                                          onPressed: widget.isFromDetail
                                              ? null
                                              : () {
                                                  if (_formStateKey
                                                      .currentState!
                                                      .validate()) {
                                                    widget.onBtnTap!(
                                                        couponController.text);
                                                  }
                                                },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              if (!widget.isFromDetail)
                                SizedBox(
                                  height: 10.h,
                                ),
                              Expanded(
                                child: Consumer<CouponProvider>(
                                    builder: (_, model, __) {
                                  switch (model.couponData.status) {
                                    case Status.LOADING:
                                      return Container(
                                        height: .40.sh,
                                        alignment: Alignment.center,
                                        child:
                                            const CircularProgressIndicator(),
                                      );
                                    case Status.ERROR:
                                      return const ErrorInfoWidget(
                                        heightFactor: 1,
                                      );
                                    case Status.COMPLETED:
                                      if (model.couponData.data!.isEmpty ||
                                          model.couponData.data == null) {
                                        return Column(
                                          children: const [
                                            SizedBox(
                                              height: AppSizes.paddingLg,
                                            ),
                                            ErrorInfoWidget(
                                                heightFactor: 1,
                                                errorInfo:
                                                    "Opps!! no offers available at the moment. However, we encourage you to keep an eye on it."),
                                          ],
                                        );
                                      }
                                      return ScrollConfiguration(
                                        behavior: MyBehaviour(),
                                        child: SingleChildScrollView(
                                          primary: false,
                                          child: Column(
                                            children: [
                                              if (Provider.of<CouponProvider>(
                                                              context)
                                                          .selectedCoupon !=
                                                      "" &&
                                                  !widget.isFromDetail)
                                                const SizedBox(
                                                  height: AppSizes.padding,
                                                ),
                                              if (Provider.of<CouponProvider>(
                                                              context)
                                                          .selectedCoupon !=
                                                      "" &&
                                                  !widget.isFromDetail)
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.w),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(AppSizes
                                                                      .padding *
                                                                  1.5),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .lightPrimaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Applied Coupon Code",
                                                                    style: smallText
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .textSoftGreyColor,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      Provider.of<CouponProvider>(
                                                                              context)
                                                                          .selectedCoupon,
                                                                      style: bodyText.copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              AppColors.primaryColor)),
                                                                ],
                                                              ),
                                                              GestureDetector(
                                                                onTap: !widget
                                                                        .isFromDetail
                                                                    ? () => widget
                                                                        .onBtnTap!("")
                                                                    : null,
                                                                child: Icon(
                                                                  Icons.delete,
                                                                  size: 20.r,
                                                                  color: AppColors
                                                                      .emergencyTextColor,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (Provider.of<CouponProvider>(
                                                          context)
                                                      .selectedCoupon !=
                                                  "")
                                                const SizedBox(
                                                  height: AppSizes.padding,
                                                ),
                                              if (widget.isFromDetail == false)
                                                const SizedBox(
                                                  height: AppSizes.padding,
                                                ),
                                              ScrollConfiguration(
                                                behavior: MyBehaviour(),
                                                child: ListView.separated(
                                                  primary: true,
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal:
                                                          AppSizes.padding * 2,
                                                      vertical:
                                                          AppSizes.padding,
                                                    ),
                                                    child: Divider(
                                                        color: Colors
                                                            .grey.shade400),
                                                  ),
                                                  itemCount: model
                                                      .couponData.data!.length,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    return GestureDetector(
                                                      onTap: widget.isFromDetail
                                                          ? null
                                                          : () => widget
                                                                  .onBtnTap!(
                                                              model
                                                                  .couponData
                                                                  .data![index]
                                                                  .code),
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    16.w),
                                                        color:
                                                            Colors.transparent,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "${model.couponData.data![index].name} (${model.couponData.data![index].code})",
                                                                    style: bodyText.copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        .70.sw,
                                                                    child: Text(
                                                                        "${model.couponData.data![index].minimumSpend}. ${model.couponData.data![index].applicableTo}",
                                                                        style: smallText
                                                                            .copyWith(
                                                                          color:
                                                                              AppColors.textSoftGreyColor,
                                                                        )),
                                                                  ),
                                                                  if (model
                                                                          .couponData
                                                                          .data![
                                                                              index]
                                                                          .toDate !=
                                                                      "")
                                                                    Text(
                                                                      "Valid Upto: ${DateFormat.yMMMd().format(DateTime.parse(model.couponData.data![index].toDate))}",
                                                                      style: verySmallText
                                                                          .copyWith(
                                                                        color: AppColors
                                                                            .alertTextColor,
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                            if (!widget
                                                                .isFromDetail)
                                                              Container(
                                                                height: 40.r,
                                                                width: 40.r,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    AppSizes.radius *
                                                                        3,
                                                                  ),
                                                                  color: AppColors
                                                                      .lightPrimaryColor,
                                                                ),
                                                                child: Icon(
                                                                  model.couponData.data![index].code ==
                                                                          model
                                                                              .selectedCoupon
                                                                      ? Icons
                                                                          .check
                                                                      : Icons
                                                                          .add,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 40.h,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    default:
                                      return const SizedBox();
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                      ));
            },
            child: widget.isFromDetail
                ? Container(
                    padding: EdgeInsets.only(right: 32.w),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        SizedBox(
                          width: AppSizes.iconHeight,
                          child: SvgPicture.asset(
                            voucherIcon,
                            height: AppSizes.iconHeight,
                            width: AppSizes.iconHeight,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Check for available offers",
                          style: bodyText.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12.sp,
                          color: AppColors.primaryColor,
                        )
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              voucherIcon,
                              height: AppSizes.iconHeight / 1.3,
                              width: AppSizes.iconHeight,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            if (Provider.of<CouponProvider>(context)
                                    .selectedCoupon !=
                                "")
                              Row(
                                children: [
                                  Text(
                                    "Applied",
                                    style: bodyText.copyWith(
                                        fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                  Text(
                                    " (",
                                    style: bodyText.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  Text(
                                    Provider.of<CouponProvider>(context)
                                        .selectedCoupon,
                                    style: bodyText.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  Text(
                                    ")",
                                    style: bodyText.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            if (Provider.of<CouponProvider>(context)
                                    .selectedCoupon ==
                                "")
                              Text(
                                "Apply a voucher",
                                style: bodyText.copyWith(
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (!widget.isFromDetail &&
                          Provider.of<CouponProvider>(context).selectedCoupon !=
                              "")
                        GestureDetector(
                          onTap: !widget.isFromDetail
                              ? () => widget.onBtnTap!("")
                              : null,
                          child: Icon(Icons.delete_outline,
                              size: 24.r, color: AppColors.emergencyTextColor),
                        ),
                      const SizedBox(
                        width: AppSizes.paddingLg,
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
