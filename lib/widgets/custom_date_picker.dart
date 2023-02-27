// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '/data/enums/days.dart';
// import '/models/merchant_info_model.dart';
// import '/providers/time_slot_provider.dart';
// import '/styles/app_colors.dart';
// import '/styles/app_sizes.dart';
// import '/styles/styles.dart';
// import '/utils/custom_scroll_behaviour.dart';
// import '/utils/show_toast.dart';

// class CustomDatePicker extends StatefulWidget {
//   final List<int> closingDays;
//   final int limitDays;
//   final Function setReturnSelectedDate;
//   final List closingDates;
//   CustomDatePicker({
//     Key? key,
//     required this.closingDays,
//     required this.limitDays,
//     required this.setReturnSelectedDate,
//     required this.closingDates,
//   }) : super(key: key);

//   @override
//   State<CustomDatePicker> createState() => _CustomDatePickerState();
// }

// class _CustomDatePickerState extends State<CustomDatePicker> {
//   // DateTime selectMonthAndYear = DateTime.now();
//   // int limitDays = 90;
//   // bool isScrollToIndex = false;
//   bool isInit = true;
//   // late DateTime selectedDate;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (isInit) {
//       // datePickerScrollController = ItemScrollController();
//       Provider.of<TimeSlotProvider>(context, listen: false)
//           .generateDatePickerDateList(widget.limitDays);

//       isInit = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     log(widget.limitDays.toString(), name: "Date picker");
//     // selectedDate = Provider.of<TimeSlotProvider>(
//     //   context,
//     // ).selectedDatePickerDate;
//     // if (isScrollToIndex) {
//     //   datePickerScrollController.scrollTo(
//     //       index: (dateTimes.indexWhere((element) =>
//     //           element!.toIso8601String().split("T").first ==
//     //           selectedDate.toIso8601String().substring(0, 10))),
//     //       duration: const Duration(milliseconds: 800));
//     // }
//     // isScrollToIndex = true;

//     // if (Provider.of<TimeSlotProvider>(context)
//     //     .selectedDateTimeList
//     //     .isNotEmpty) {
//     //   if ((Provider.of<TimeSlotProvider>(context).selectedDeliveryType ==
//     //           "Delivery") &&
//     //       widget.isFromDelivery) {
//     //
//     //     log(Provider.of<TimeSlotProvider>(context).selectedIndex.toString());
//     //     _scrollController.scrollTo(
//     //         index: Provider.of<TimeSlotProvider>(context).selectedIndex + 1,
//     //         duration: const Duration(seconds: 1));
//     //   }
//     //   if ((Provider.of<TimeSlotProvider>(context).selectedDeliveryType ==
//     //           "Self Pickup") &&
//     //       !widget.isFromDelivery) {
//     //
//     //     _scrollController.scrollTo(
//     //         index: Provider.of<TimeSlotProvider>(context).selectedIndex + 1,
//     //         duration: const Duration(seconds: 1));
//     //   }
//     // }
//     // _scrollController.scrollTo(
//     //     index: 20, duration: Duration(milliseconds: 200));
//     return Consumer<TimeSlotProvider>(builder: (_, timeslotModel, __) {
//       return Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 DateFormat.yMMM().format(timeslotModel.selectedDatePickerDate),
//                 style: bodyText.copyWith(
//                     fontSize: 14.sp, fontWeight: FontWeight.w500),
//               ),
//               Text(
//                 DateFormat.yMMM()
//                     .format(timeslotModel.selectedScrollYearAndMonth),
//                 style: bodyText.copyWith(
//                     fontSize: 14.sp, fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: AppSizes.padding,
//           ),
//           Row(
//             children: [
//               SelectedItem(selectedDate: timeslotModel.selectedDatePickerDate),
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.only(left: AppSizes.padding),
//                   height: 50.h,
//                   child: timeslotModel.datePickerDateList.isEmpty
//                       ? const SizedBox.shrink()
//                       : ScrollConfiguration(
//                           behavior: MyBehaviour(),
//                           child: ScrollablePositionedList.builder(
//                             // shrinkWrap: true,
//                             scrollDirection: Axis.horizontal,
//                             itemScrollController:
//                                 timeslotModel.datePickerScrollController,
//                             itemCount: timeslotModel.datePickerDateList.length,
//                             initialScrollIndex: (timeslotModel.datePickerDateList
//                                         .indexWhere((element) =>
//                                             element
//                                                 .toIso8601String()
//                                                 .split("T")
//                                                 .first ==
//                                             Provider.of<TimeSlotProvider>(
//                                                     context,
//                                                     listen: false)
//                                                 .selectedDatePickerDate
//                                                 .toIso8601String()
//                                                 .substring(0, 10))) ==
//                                     -1
//                                 ? 0
//                                 : (timeslotModel.datePickerDateList.indexWhere(
//                                     (element) =>
//                                         element.toIso8601String().split("T").first ==
//                                         Provider.of<TimeSlotProvider>(context,
//                                                 listen: false)
//                                             .selectedDatePickerDate
//                                             .toIso8601String()
//                                             .substring(0, 10))),
//                             // widget.isFromDelivery
//                             //     ?
//                             // Provider.of<TimeSlotProvider>(context, listen: false)
//                             //     .selectedTimeCalenderItemIndex
//                             // : Provider.of<TimeSlotProvider>(context, listen: false)
//                             //     .selectedSelfPickUpTimeCalenderItemIndex
//                             itemBuilder: (_, i) {
//                               // log(timeslotModel.datePickerDateList[i]!.day.toString());

//                               if (timeslotModel.datePickerDateList[i].day ==
//                                   7) {
//                                 Future.delayed(Duration.zero, () async {
//                                   Provider.of<TimeSlotProvider>(context,
//                                           listen: false)
//                                       .setSelectedScrollYearAndMonth(
//                                           timeslotModel.datePickerDateList[i]);
//                                 });
//                               }
//                               if (timeslotModel.datePickerDateList[i].day ==
//                                   25) {
//                                 Future.delayed(Duration.zero, () async {
//                                   Provider.of<TimeSlotProvider>(context,
//                                           listen: false)
//                                       .setSelectedScrollYearAndMonth(
//                                           timeslotModel.datePickerDateList[i]);
//                                 });
//                               }
//                               final index = getData(DateFormat("EE")
//                                   .format(timeslotModel.datePickerDateList[i]));
//                               bool isDisabled = false;
//                               log(widget.closingDates.toString());
//                               if (widget.closingDates != []) {
//                                 isDisabled = widget.closingDates.any(
//                                   (element) =>
//                                       timeslotModel.datePickerDateList[i]
//                                           .toIso8601String()
//                                           .split("T")
//                                           .first ==
//                                       DateTime.parse(element)
//                                           .toIso8601String()
//                                           .split("T")
//                                           .first,
//                                 );
//                               }
//                               isDisabled = widget.closingDays.contains(index);

//                               return DateFormat.yMMMd().format(timeslotModel
//                                           .datePickerDateList[i]) ==
//                                       DateFormat.yMMMd().format(
//                                           timeslotModel.selectedDatePickerDate)
//                                   ? const SizedBox()
//                                   : GestureDetector(
//                                       onTap: isDisabled
//                                           ? () {
//                                               showToast(
//                                                   "Sorry, we are closed on this date. Please try another date.");
//                                             }
//                                           : () async {
//                                               if (timeslotModel
//                                                   .datePickerDateList[i]
//                                                   .isAfter(DateTime.now().add(
//                                                       const Duration(
//                                                           days: -1)))) {
//                                                 Provider.of<TimeSlotProvider>(
//                                                         context,
//                                                         listen: false)
//                                                     .setSelectedDate(
//                                                   timeslotModel
//                                                       .datePickerDateList[i],
//                                                 );
//                                                 widget.setReturnSelectedDate(
//                                                     timeslotModel
//                                                         .selectedDatePickerDate,
//                                                     selectedIndex: i);
//                                                 timeslotModel
//                                                     .datePickerScrollController
//                                                     .scrollTo(
//                                                   index: i + 1,
//                                                   duration: const Duration(
//                                                       milliseconds: 800),
//                                                 );

//                                                 setState(() {});
//                                               }
//                                             },
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                             right: AppSizes.padding),
//                                         height: 50.h,
//                                         width: 50.w,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             color: isDisabled
//                                                 ? Colors.grey.shade200
//                                                 : (timeslotModel.datePickerDateList[
//                                                             i] ==
//                                                         timeslotModel
//                                                             .selectedDatePickerDate)
//                                                     ? AppColors.primaryColor
//                                                     : const Color(0xffF4F4F4)),
//                                         child: Center(
//                                           child: RichText(
//                                             textAlign: TextAlign.center,
//                                             text: TextSpan(
//                                               text:
//                                                   "${DateFormat('d').format(timeslotModel.datePickerDateList[i])}\n",
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .subtitle1
//                                                   ?.copyWith(
//                                                     fontWeight: FontWeight.w600,
//                                                     color: isDisabled
//                                                         ? Colors.grey
//                                                         : (timeslotModel
//                                                                         .datePickerDateList[
//                                                                     i] ==
//                                                                 timeslotModel
//                                                                     .selectedDatePickerDate)
//                                                             ? const Color(
//                                                                 0xffF4F4F4)
//                                                             : Colors.black87,
//                                                     fontSize: 14.sp,
//                                                   ),
//                                               children: <TextSpan>[
//                                                 TextSpan(
//                                                     text: DateFormat("EE")
//                                                         .format(timeslotModel
//                                                                 .datePickerDateList[
//                                                             i]),
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .subtitle2
//                                                         ?.copyWith(
//                                                           fontSize: 14.sp,
//                                                           color: isDisabled
//                                                               ? Colors.grey
//                                                               : (timeslotModel.datePickerDateList[
//                                                                           i] ==
//                                                                       timeslotModel
//                                                                           .selectedDatePickerDate)
//                                                                   ? const Color(
//                                                                       0xffF4F4F4)
//                                                                   : Colors
//                                                                       .black87,
//                                                           fontWeight:
//                                                               FontWeight.w400,
//                                                         )),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                             },
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     });
//   }

//   getData(String name) {
//     for (Days d in Days.values) {
//       if (d.name.toLowerCase() == name.toLowerCase()) {
//         return d.index;
//       }
//     }
//   }
// }

// class SelectedItem extends StatelessWidget {
//   const SelectedItem({
//     Key? key,
//     required this.selectedDate,
//   }) : super(key: key);

//   final DateTime selectedDate;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 50.h,
//         width: 50.w,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: AppColors.primaryColor),
//         child: Center(
//           child: RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               text: "${DateFormat('d').format(selectedDate).split('-').last}\n",
//               style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xffF4F4F4),
//                     fontSize: 14.sp,
//                   ),
//               children: <TextSpan>[
//                 TextSpan(
//                     text: DateFormat("EE").format(selectedDate),
//                     style: Theme.of(context).textTheme.subtitle2?.copyWith(
//                           fontSize: 14.sp,
//                           color: const Color(0xffF4F4F4),
//                           fontWeight: FontWeight.w400,
//                         )),
//               ],
//             ),
//           ),
//         ));
//   }
// }
