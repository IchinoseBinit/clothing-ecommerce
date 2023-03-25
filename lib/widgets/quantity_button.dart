import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';

class QuantityButton extends StatefulWidget {
  final Function setIncrement;
  final Function setDecrement;
  final int itemIndex;
  final int categoryIndex;
  const QuantityButton({
    super.key,
    required this.setIncrement,
    required this.setDecrement,
    required this.itemIndex,
    required this.categoryIndex,
  });

  @override
  QuantityButtonState createState() => QuantityButtonState();
}

class QuantityButtonState extends State<QuantityButton> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: true,
        // visible: itemProvider.merchantItemList.data![widget.categoryIndex]
        //         .items![widget.itemIndex].selectedQuantity !=
        //     0,
        replacement: GestureDetector(
          onTap: () async {
            widget.setIncrement();
            setState(() {});
          },
          child: Container(
            width: width * 0.25,
            height: width * 0.09,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSizes.radius),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "Add To Cart",
              style: TextStyle(color: Colors.white, fontSize: 11.sp),
            ),
          ),
        ),
        child: Container(
            height: width * 0.09,
            alignment: Alignment.center,
            width: width * 0.25,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSizes.radius),
                ),
                border: Border.all(color: AppColors.primaryColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: width * 0.09,
                  height: width * 0.09,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radius),
                    ),
                  ),
                  child: IconButton(
                    icon:
                        const Icon(Icons.remove, color: Colors.white, size: 18),
                    onPressed: () {
                      // itemProvider.merchantItemList.data!
                      //     .results![widget.categoryIndex].items![widget.itemIndex]
                      //     .decreaseQuatity();
                      //      setState(() {});
                      widget.setDecrement();
                      setState(() {});
                      // if (itemProvider.merchantItemList.data!.results![widget.itemIndex] > 0) {
                      //   // count = 1;
                      //   widget.count--;
                      //   widget.setDecrement(widget.count);
                      //   setState(() {});
                      // }
                    },
                  ),
                ),
                Text(
                  "23",
                  style: const TextStyle(color: Colors.white),
                ),
                Container(
                  width: width * 0.1,
                  height: width * 0.1,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topRight: Radius.circular(4))),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //  itemProvider.merchantItemList.data!
                      //     .results![widget.categoryIndex].items![widget.itemIndex]
                      //     .increaseQuatity();
                      //      setState(() {});
                      widget.setIncrement();
                      setState(() {});
                    },
                  ),
                ),
              ],
            )),
      );
    
  }
}
