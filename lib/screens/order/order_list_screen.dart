import 'package:clothing_ecommerce/models/order_model.dart';
import 'package:clothing_ecommerce/styles/app_colors.dart';
import 'package:clothing_ecommerce/styles/app_sizes.dart';
import 'package:clothing_ecommerce/styles/styles.dart';
import 'package:clothing_ecommerce/utils/custom_scroll_behaviour.dart';
import 'package:clothing_ecommerce/widgets/custom_appbar.dart';
import 'package:clothing_ecommerce/widgets/each_price_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  OrderListScreenState createState() => OrderListScreenState();
}

class OrderListScreenState extends State<OrderListScreen> {
  List<OrderModel> items = <OrderModel>[
    for (int i = 0; i < 10; i++)
      OrderModel(
        address: "222",
        color: 1,
        product: 1,
        size: 1,
        quantity: 1,
      ),
  ];
  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = Scaffold(
      appBar: CustomAppBar(
        title: "Order",
        disableLeading: true,
      ),
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingLg),
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  items[index].isExpanded = !items[index].isExpanded;
                });
              },
              children: items.map((OrderModel item) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                        leading: const Icon(Icons.list_alt_outlined),
                        title: Text(
                          "#QWEGI1EHU22US",
                          textAlign: TextAlign.left,
                          style: subTitleText.copyWith(
                              fontWeight: FontWeight.w500),
                        ));
                  },
                  isExpanded: item.isExpanded,
                  body: Padding(
                    padding: const EdgeInsets.only(
                      left: AppSizes.paddingLg,
                      right: AppSizes.paddingLg,
                      bottom: AppSizes.paddingLg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: subTitleText.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Column(
                          children: [
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: AppSizes.padding),
                              itemCount: 3,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: "Demin Tshirt",
                                      style: bodyText.copyWith(
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " x ",
                                      style: bodyText.copyWith(
                                          color: AppColors.textLightGreyColor),
                                    ),
                                    TextSpan(
                                        text: "${index + 1}",
                                        style: bodyText.copyWith()),
                                  ])),
                                  Text(
                                    "Rs 200",
                                    style: bodyText.copyWith(
                                      color: AppColors.textDarkColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              //     EachPriceItem(
                              //   title:
                              //       "${widget.cartPriceModel.items[index].quantity} X ${widget.cartPriceModel.items[index].name}",
                              //   value:
                              //       "Rs ${widget.cartPriceModel.items[index].specialPriceTotal != 0.0 ? widget.cartPriceModel.items[index].specialPriceTotal.toStringAsFixed(2) : widget.cartPriceModel.items[index].retailPriceTotal.toStringAsFixed(2)}",
                              // ),
                            ),
                            Divider(
                              height: 24.h,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EachPriceItem(
                                      isSubTotal: true,
                                      title: "Subtotal",
                                      value: "Rs. 2000"),
                                  const SizedBox(height: AppSizes.padding),
                                  EachPriceItem(
                                      title: "Delivery Fee",
                                      value: "Rs 65",
                                      isDeliveryFree: false),
                                  // const SizedBox(
                                  //   height: AppSizes.padding,
                                  // ),
                                  // EachPriceItem(
                                  //     title: "Discount:",
                                  //     value: "Rs 10",
                                  //     hasPromo: true,
                                  //     promoCode: "DSSAD"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
    return scaffold;
  }
}
