import 'package:flutter/material.dart';

class MerchantListLoadingWidget extends StatelessWidget {
  const MerchantListLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      heightFactor: 15,
      child: CircularProgressIndicator(),
    );
    // return ScrollConfiguration(
    //   behavior: MyBehavior(),
    //   child: ListView.builder(

    //     // physics: const NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: 10,
    //     itemBuilder: (context, index) {
    //       return Padding(
    //         padding: const EdgeInsets.all(18.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Shimmer.fromColors(
    //               child: Container(
    //                 height: 60.h,
    //                 width:double.infinity,
    //                 color: Colors.white,
    //               ),
    //               baseColor: AppColors.primaryColor,
    //               highlightColor: Colors.grey.shade400,
    //             ),
    //             SizedBox(height: 8.h,),
    //            Shimmer.fromColors(
    //               baseColor: AppColors.primaryColor,
    //               highlightColor: Colors.grey.shade400,
    //               enabled: true,
    //               child: Container(

    //                 width: MediaQuery.of(context).size.width/2.1,
    //                 height: 8.h,
    //                 color: Colors.white,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 8.h,
    //             ),
    //             Shimmer.fromColors(
    //               baseColor: AppColors.primaryColor,
    //               highlightColor: Colors.grey.shade400,
    //               enabled: true,
    //               child: Container(
    //                 width: double.infinity,
    //                 height: 8.h,
    //                 color: Colors.white,
    //               ),
    //             ),
    //               SizedBox(
    //               height: 8.h,
    //             ),
    //             Shimmer.fromColors(
    //               baseColor: AppColors.primaryColor,
    //               highlightColor: Colors.grey.shade400,
    //               enabled: true,
    //               child: Container(
    //                 width: double.infinity,
    //                 height: 8.h,
    //                 color: Colors.white,
    //               ),
    //             ),
    //               SizedBox(
    //               height: 8.h,
    //             ),
    //             Shimmer.fromColors(
    //               baseColor: AppColors.primaryColor,
    //               highlightColor: Colors.grey.shade400,
    //               enabled: true,
    //               child: Container(
    //                 width: double.infinity,
    //                 height: 8.h,
    //                 color: Colors.white,
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}

// ignore: non_constant_identifier_names
