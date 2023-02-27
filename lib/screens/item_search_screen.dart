// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// import '/data/constants/image_constants.dart';
// import '/styles/app_colors.dart';
// import '/styles/app_sizes.dart';
// import '/styles/styles.dart';
// import '/utils/custom_scroll_behaviour.dart';
// import '/widgets/error_info_widget.dart';
// import '/widgets/general_textfield.dart';
// import 'city_search_screen.dart';

// class ItemSearchScreen extends StatefulWidget {
//   const ItemSearchScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<ItemSearchScreen> createState() => _ItemSearchScreenState();
// }

// class _ItemSearchScreenState extends State<ItemSearchScreen> {
//   final searchController = TextEditingController();

//   bool isViewMore = false;
//   Map? location;
//   Timer? _debounce;
//   String query = "";
//   final int _debouncetime = 600;

//   @override
//   void initState() {
//     // Provider.of<PlaceApiProvider>(context, listen: false).clearSearchData();
//     searchController.addListener(_onSearchChanged);
//     super.initState();
//   }

//   // @override
//   // void dispose() {
//   //   searchController.removeListener(_onSearchChanged);
//   //   searchController.dispose();
//   //   super.dispose();
//   // }

//   _onSearchChanged() {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//     _debounce = Timer(Duration(milliseconds: _debouncetime), () {
//       Provider.of<PlaceApiProvider>(context, listen: false).fetchSuggestions(
//           input: searchController.text,
//           location: widget.location != null
//               ? widget.location!
//               : Provider.of<LocationProvider>(context, listen: false)
//                   .locations
//                   .first);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Navigator.pop(context,
//         //     {"location": value.predictions[index].placeId, "isPlaceId": false});
//         Navigator.pop(context, location);
//         return Future.value(true);
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: AppSizes.padding * 6),
//                     child: Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: AppSizes.padding),
//                             child:
//                                 Icon(Icons.arrow_back_ios, color: Colors.black),
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: AppSizes.padding),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8.r),
//                                   color: AppColors.inputColor,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     const SizedBox(
//                                       width: AppSizes.padding * 1.5,
//                                     ),
//                                     const SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: Icon(
//                                         Icons.search,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             height: 25,
//                                             child: GeneralTextField(
//                                               isSmallText: true,
//                                               autofocus: true,
//                                               controller: searchController,
//                                               isHintTextBig: true,
//                                               hintText: "Deliver to?",
//                                               hintColor:
//                                                   const Color(0xff595959),
//                                               fillColor: AppColors.inputColor,
//                                               obscureText: false,

//                                               borderColor: Colors.transparent,
//                                               onTap: () async {
//                                                 // generate a new token here

//                                                 // This will change the text displayed in the TextField
//                                               },
//                                               removePrefixIconDivider: true,
//                                               keywordType: TextInputType.text,
//                                               validate: (String value) {},
//                                               onFieldSubmit: () {},

//                                               textInputAction:
//                                                   TextInputAction.done,
//                                               suffixIcon:
//                                                   Provider.of<PlaceApiProvider>(
//                                                               context)
//                                                           .showClearButton
//                                                       ? Icons.cancel
//                                                       : null,
//                                               onClickPsToggle: () {
//                                                 searchController.clear();
//                                                 // setState(() {});
//                                               },
//                                               // onChanged: (value) async {
//                                               //  Provider.of<PlaceApiProvider>(context,
//                                               //         listen: false)
//                                               //     .setLoading();
//                                               //  final placeDetails =
//                                               //     await Provider.of<PlaceApiProvider>(context,
//                                               //             listen: false)
//                                               //         .fetchSuggestions(
//                                               //             input: searchController.text,
//                                               //             location:
//                                               //                 Provider.of<LocationProvider>(
//                                               //                         context,
//                                               //                         listen: false)
//                                               //                     .locations
//                                               //                     .last);

//                                               // fetchService = true;
//                                               // },
//                                               suffixIconColor: Colors.grey,
//                                               onSave: () {},
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 12),
//                                             child: Text(
//                                               widget.merchantSubLocation ??
//                                                   Provider.of<LocationProvider>(
//                                                           context)
//                                                       .subtitleAdd,
//                                               style: verySmallText.copyWith(
//                                                 color:
//                                                     AppColors.textSoftGreyColor,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: widget.isFromCheckoutScreen
//                               ? null
//                               : () async {
//                                   location = await showModalBottomSheet(
//                                     context: context,
//                                     isScrollControlled: true,
//                                     shape: const RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.vertical(
//                                       top: Radius.circular(30),
//                                     )),
//                                     builder: (context) =>
//                                         DraggableScrollableSheet(
//                                             initialChildSize: .9,
//                                             minChildSize: .9,
//                                             maxChildSize: .9,
//                                             expand: false,
//                                             builder:
//                                                 (context, scrollController) {
//                                               return const CitySearchScreen();
//                                             }),
//                                   );

//                                   if (location != null) {
//                                     log(location.toString());

//                                     await Provider.of<LocationProvider>(context,
//                                             listen: false)
//                                         .setLocation(
//                                             isPlaceId:
//                                                 location!["isPlaceId"] as bool,
//                                             locationName: location!["location"]
//                                                 .toString(),
//                                             isFromSelectCity: true);
//                                   }
//                                 },
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.only(left: AppSizes.paddingLg),
//                             child: Icon(Icons.language,
//                                 color: widget.isFromCheckoutScreen
//                                     ? Colors.transparent
//                                     : Colors.black),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: AppSizes.padding,
//               ),
//               Expanded(
//                 child: Consumer<PlaceApiProvider>(
//                   builder: (_, value, __) {
//                     if (value.predictions.isEmpty && !value.isLoading) {
//                       return Padding(
//                         padding: EdgeInsets.only(
//                             left: AppSizes.padding * 4,
//                             right: AppSizes.padding * 4,
//                             bottom: 120.h),
//                         child: const ErrorInfoWidget(
//                           isLocation: true,
//                           errorInfo:
//                               "Enter an address to discover merchants located in the surrounding area.",
//                         ),
//                       );
//                     } else {
//                       if (value.isLoading) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }

//                       return SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                             bottom: AppSizes.padding,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ScrollConfiguration(
//                                 behavior: MyBehaviour(),
//                                 child: ListView.separated(
//                                     separatorBuilder: (context, index) =>
//                                         const Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: AppSizes.padding),
//                                             child: Divider(
//                                                 height: AppSizes.padding)),
//                                     itemCount: value.predictions.length,
//                                     shrinkWrap: true,
//                                     padding: EdgeInsets.only(top: 8.h),
//                                     itemBuilder: (context, index) =>
//                                         GestureDetector(
//                                           onTap: () {
//                                             Navigator.pop(context, {
//                                               "location": value
//                                                   .predictions[index].placeId,
//                                               "isPlaceId": true
//                                             });
//                                             // Navigator.pop(
//                                             //     context,
//                                             //     "${value.predictions[index]
//                                             //             .placeId}, ${value.predictions[index]
//                                             //             .description}");
//                                           },
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: AppSizes.paddingLg),
//                                             child: Row(
//                                               children: [
//                                                 SvgPicture.asset(
//                                                   locationIcon,
//                                                   color: AppColors.greyColor,
//                                                 ),
//                                                 const SizedBox(
//                                                   width: AppSizes.paddingLg,
//                                                 ),
//                                                 Expanded(
//                                                   child: Text(
//                                                     value.predictions[index]
//                                                         .description,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   width: AppSizes.paddingLg,
//                                                 ),
//                                                 const Icon(
//                                                   Icons.arrow_forward_ios,
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         )),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
