// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// import '/data/response/status.dart';
// import '/providers/merchant_list_provider.dart';
// import '/styles/app_colors.dart';
// import '/styles/app_sizes.dart';
// import '/styles/styles.dart';
// import '/widgets/upper_part_bottom_sheet.dart';

// class SelectCategoryModelSheet extends StatefulWidget {
//   final String deliveryType;
//   final int locationId;
//   final MerchantListProvider merchantItemListProvider;
//   final dynamic setIndex;
//   const SelectCategoryModelSheet({
//     super.key,
//     required this.setIndex,
//     required this.deliveryType,
//     required this.merchantItemListProvider,
//     required this.locationId,
//   });

//   @override
//   State<SelectCategoryModelSheet> createState() =>
//       _SelectCategoryModelSheetState();
// }

// class _SelectCategoryModelSheetState extends State<SelectCategoryModelSheet> {
//   MerchantListProvider merchantItemList = MerchantListProvider();
//   // int initalIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     // merchantItemList.fetchMerchantItemListApi(
//     //     locationCode: widget.locationId, deliveryType: widget.deliveryType);
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (widget.merchantItemListProvider.merchantItemList.status) {
//       case Status.LOADING:
//         return const Center(
//             child: CircularProgressIndicator(
//           color: Colors.transparent,
//         ));
//       case Status.ERROR:
//       case Status.COMPLETED:
//         List<String> itemName = [];

//         for (var i in widget.merchantItemListProvider.merchantItemList.data!) {
//           itemName.add(i.name.toString());
//         }

//         return GestureDetector(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(30),
//               )),
//               builder: (context) => DraggableScrollableSheet(
//                   initialChildSize: .5,
//                   minChildSize: .5,
//                   maxChildSize: .9,
//                   expand: false,
//                   builder: (context, scrollController) {
//                     return Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const UpperContentBottomSheet(title: "Select Category"),
//                         SizedBox(
//                           height: 8.h,
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: AppSizes.paddingLg),
//                             child: ListView.separated(
//                               separatorBuilder: (context, index) => Divider(
//                                   height: AppSizes.padding * 4,
//                                   color: Colors.grey.shade300),
//                               shrinkWrap: true,
//                               itemCount: widget.merchantItemListProvider
//                                   .merchantItemList.data!.length,
//                               itemBuilder: (context, index) {
//                                 return Consumer<MerchantListProvider>(
//                                     builder: (__, v, _) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       v.setSelectedIndex(index);
//                                       widget.setIndex(index);
//                                       Navigator.pop(context);
//                                     },
//                                     child: Container(
//                                       color: Colors.transparent,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             widget
//                                                 .merchantItemListProvider
//                                                 .merchantItemList
//                                                 .data![index]
//                                                 .name!,
//                                             style: bodyText,
//                                           ),
//                                           const Icon(
//                                             Icons.arrow_forward_ios,
//                                             color: AppColors.greyColor,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 16.h,
//                         ),
//                       ],
//                     );
//                   }),
//             );
//           },
//           child: Consumer<MerchantListProvider>(builder: (_, provider, __) {
//             return Row(
//               children: [
//                 SizedBox(
//                   child: Text(
//                     itemName[provider.selectedIndex],
//                     style: smallText.copyWith(
//                       fontSize: 14.sp,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 4.w,
//                 ),
//                 const Icon(
//                   Icons.keyboard_arrow_down,
//                   color: Colors.white,
//                   size: 20,
//                 )
//               ],
//             );
//           }),
//         );
//       // return DropdownButton(

//       //   focusColor: AppColors.primaryColor,
//       //   dropdownColor: AppColors.primaryColor,
//       //   isDense: true,
//       //   iconEnabledColor: Colors.white,
//       //   borderRadius: BorderRadius.circular(20),
//       //   value: dropDownValue,
//       //   icon: const Icon(Icons.keyboard_arrow_down),
//       //   items: itemName.map((String? items) {
//       //     return DropdownMenuItem(
//       //       onTap: widget.onTapped,
//       //       value: items,
//       //       child: Text(
//       //         items ?? '',
//       //         style: TextStyle(
//       //           color: Colors.white,
//       //         ),
//       //       ),
//       //     );
//       //   }).toList(),
//       //   onChanged: (String? newValue) {
//       //     setState(() {
//       //       initalIndex = itemName.indexOf(newValue!);
//       //     });
//       //   },
//       // );
//       default:
//     }
//     return Container();
//   }
// }
