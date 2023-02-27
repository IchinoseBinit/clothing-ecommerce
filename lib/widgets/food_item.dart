import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/data/constants/image_constants.dart';
import '/providers/merchant_info_provider.dart';
import '/screens/merchant_list/widgets/add_to_cart_button.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '../models/merchant_item_model.dart';

class ClothItem extends StatefulWidget {
  final Items itemModel;
  final int itemIndex;
  final int categoryIndex;
  final int merchantId;
  final int merchantLocationId;
  final double minimumOrder;
  final String currency;
  const ClothItem({
    Key? key,
    required this.itemModel,
    required this.itemIndex,
    required this.minimumOrder,
    required this.currency,
    required this.merchantId,
    required this.categoryIndex,
    required this.merchantLocationId,
  }) : super(key: key);

  @override
  State<ClothItem> createState() => _ClothItemState();
}

class _ClothItemState extends State<ClothItem> {
  bool isFoodItemDescExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100.h,
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSizes.radius),
            ),
            child: Container(
              height: 90.h,
              width: 90.h,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSizes.radius),
                ),
              ),
              child: Consumer<MerchantInfoProvider>(
                builder: (context, value, child) {
                  return widget.itemModel.image != ""
                      ? Image.network(
                          widget.itemModel.image!,
                          fit: BoxFit.cover,
                        )
                      : value.merchantInfo.data!.locations.last.logo != ""
                          ? Image.network(
                              value.merchantInfo.data!.locations.last.logo,
                              fit: BoxFit.cover,
                              opacity: AlwaysStoppedAnimation(0.4),
                            )
                          : Image.asset(
                              defaultBanner,
                              fit: BoxFit.cover,
                              height: 90.h,
                              width: 90.h,
                              opacity: AlwaysStoppedAnimation(0.6),
                            );
                },
                // child: Positioned(
                //   bottom: 0,
                //   top: 0,
                //   left: 0,
                //   right: 0,
                //   child: Image.network(
                //     widget.itemModel.image!,
                //     fit: BoxFit.cover,
                //     // errorBuilder: (context, error, stackTrace) {
                //     //   debugger();
                //     //   return Consumer<MerchantInfoProvider>(
                //     //       builder: (__, provider, _) {
                //     //     return provider
                //     //                 .merchantInfo.data!.locations.last.logo !=
                //     //             ""
                //     //         ? Container(
                //     //             height: 90.h,
                //     //             width: 90.h,
                //     //             decoration: const BoxDecoration(
                //     //               color: Colors.white,
                //     //               borderRadius: BorderRadius.all(
                //     //                 Radius.circular(AppSizes.radius),
                //     //               ),
                //     //             ),
                //     //             child: Image.network(
                //     //                 provider.merchantInfo.data!.locations.last
                //     //                     .logo,
                //     //                 fit: BoxFit.cover,
                //     //                 height: 90.h,
                //     //                 width: 90.h,
                //     //                 opacity: AlwaysStoppedAnimation(0.5)),
                //     //           )
                //     //         : Container(
                //     //             height: 90.h,
                //     //             width: 90.h,
                //     //             decoration: const BoxDecoration(
                //     //               borderRadius: BorderRadius.all(
                //     //                 Radius.circular(AppSizes.radius),
                //     //               ),
                //     //             ),
                //     //             child: Image.asset(
                //     //               defaultBanner,
                //     //               fit: BoxFit.cover,
                //     //               height: 90.h,
                //     //               width: 90.h,
                //     //               opacity: AlwaysStoppedAnimation(0.6),
                //     //             ),
                //     //           );
                //     //   });
                //     // },
                //     // loadingBuilder: (context, child, loadingProgress) {
                //     //   if (loadingProgress == null) {
                //     //     return child;
                //     //   }
                //     //   return Center(
                //     //     child: CircularProgressIndicator(
                //     //       value: loadingProgress.expectedTotalBytes != null
                //     //           ? loadingProgress.cumulativeBytesLoaded /
                //     //               loadingProgress.expectedTotalBytes!
                //     //           : null,
                //     //     ),
                //     //   );
                //     // },
                //   ),
                // ),
              ),
            ),
          ),
          // CachedNetworkImage(
          //   width: 90.h,
          //   height: 90.h,
          //   placeholderFadeInDuration: const Duration(microseconds: 0),
          //   imageUrl: widget.itemModel.image!,
          //   imageBuilder: (context, imageProvider) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         borderRadius: const BorderRadius.all(
          //           Radius.circular(AppSizes.radius),
          //         ),
          //         image:
          //             DecorationImage(image: imageProvider, fit: BoxFit.cover),
          //       ),
          //     );
          //   },
          //   placeholder: (context, url) {
          //     return Container(
          //     decoration: const BoxDecoration(
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(AppSizes.radius),
          //       ),
          //       image: DecorationImage(
          //           image: AssetImage(defaultBanner), fit: BoxFit.cover),
          //     ),
          //   );
          //   },
          //   errorWidget: (context, url, error) {
          //     // debugger();
          //     log(error.toString());
          //     return Consumer<MerchantInfoProvider>(builder: (__, provider, _) {
          //       return Container(
          //         decoration: BoxDecoration(
          //           borderRadius: const BorderRadius.all(
          //             Radius.circular(AppSizes.radius),
          //           ),
          //           image: provider.merchantInfo.data!.locations.last.logo != ""
          //               ? DecorationImage(
          //                   image: NetworkImage(provider
          //                       .merchantInfo.data!.locations.last.logo),
          //                   colorFilter: ColorFilter.mode(
          //                       Colors.black.withOpacity(0.4),
          //                       BlendMode.dstATop),
          //                   fit: BoxFit.cover,
          //                 )
          //               : const DecorationImage(
          //                   opacity: 0.5,
          //                   image: AssetImage(defaultBanner),
          //                   fit: BoxFit.cover),
          //         ),
          //       );
          //     });
          //   },
          // ),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: AppSizes.paddingLg),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemModel.name.toString(),
                        maxLines: 2,
                        style: bodyText.copyWith(fontWeight: FontWeight.w500),
                      ),

                      GestureDetector(
                        onTap:
                            (widget.itemModel.description!.characters.length) >
                                    50
                                ? () {
                                    isFoodItemDescExpanded =
                                        !isFoodItemDescExpanded;
                                    setState(() {});
                                  }
                                : null,
                        child: SizedBox(
                          height: (isFoodItemDescExpanded ||
                                  (widget.itemModel.description!.characters
                                          .length) <
                                      50)
                              ? null
                              : 65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Html(
                              //   data: (isFoodItemDescExpanded ||
                              //           widget.itemModel.description!.characters
                              //                   .length <
                              //               40)
                              //       ? widget.itemModel.description
                              //       : "${widget.itemModel.description!.substring(0, 40)}...",
                              //   shrinkWrap: true,
                              // ),
                              if (widget.itemModel.description!.characters
                                      .length >
                                  50)
                                Align(
                                  heightFactor: 0.2,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: AppSizes.padding),
                                      child: Text(
                                        isFoodItemDescExpanded
                                            ? "...View Less"
                                            : "...View More",
                                        style: smallText.copyWith(
                                            fontSize: 11.sp,
                                            // decoration: TextDecoration.underline,
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     isFoodItemDescExpanded = !isFoodItemDescExpanded;
                      //     setState(() {});
                      //   },
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Html(data: widget.itemModel.description)
                      // if (document.head!.innerHtml.isNotEmpty)
                      //   Text(
                      //     document.head!.innerHtml,
                      //     maxLines: isFoodItemDescExpanded ? 20 : 1,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: smallText,
                      //   ),
                      // Text(
                      //   document.body!.innerHtml,
                      //   maxLines: isFoodItemDescExpanded ? 20 : 2,
                      //   softWrap: true,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: smallText,
                      // ),
                      // if (document.body!.innerHtml.isNotEmpty &&
                      //     document.body!.innerHtml.characters.length >
                      //         60)
                      // Container(
                      //   color: Colors.white,
                      //   child: Text(
                      //     isFoodItemDescExpanded
                      //         ? "...View Less"
                      //         : "...View More",
                      //     style: smallText.copyWith(
                      //         fontSize: 11.sp,
                      //         // decoration: TextDecoration.underline,
                      //         color: AppColors.primaryColor),
                      //   ),
                      // ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          if (widget.itemModel.specialPrice != null)
                            Text(
                              "${widget.currency} ${widget.itemModel.specialPrice}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (widget.itemModel.specialPrice != null)
                            SizedBox(
                              width: 4.w,
                            ),
                          Text(
                            "${widget.currency} ${widget.itemModel.retailPrice}",
                            style: TextStyle(
                                fontSize: widget.itemModel.specialPrice != null
                                    ? 10.sp
                                    : 14.sp,
                                color: widget.itemModel.specialPrice != null
                                    ? Colors.grey.shade400
                                    : Colors.black,
                                fontWeight:
                                    widget.itemModel.specialPrice != null
                                        ? FontWeight.normal
                                        : FontWeight.w600,
                                decoration:
                                    widget.itemModel.specialPrice != null
                                        ? TextDecoration.lineThrough
                                        : null),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      AddCartButton(
                        categoryIndex: widget.categoryIndex,
                        itemIndex: widget.itemIndex,
                        setIncrement: () {
                          // Provider.of<CartProvider>(context, listen: false)
                          //     .setCartItem(
                          //   merchantLocationId: widget.merchantLocationId,
                          //   minimumOrder: widget.minimumOrder,
                          //   context: context,
                          //   item: widget.itemModel,
                          //   merchantId: widget.merchantId,
                          //   currency: widget.currency,
                          // );
                        },
                        setDecrement: () {
                          // Provider.of<CartProvider>(context, listen: false)
                          //     .removeCartItem(
                          //   itemId: widget.itemModel.id,
                          //   context: context,
                          //   merchantId: widget.merchantId,
                          //   item: widget.itemModel,
                          //   merchantLocationId: widget.merchantLocationId,
                          // );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
