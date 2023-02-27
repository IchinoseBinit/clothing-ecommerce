import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/data/response/status.dart';
import '/providers/orders_list_provider.dart';
import '/screens/order/widgets/each_order_item.dart';
import '/styles/app_sizes.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/order_list_type.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/error_info_widget.dart';

class HistoryListScreen extends StatefulWidget {
  const HistoryListScreen({Key? key}) : super(key: key);

  @override
  State<HistoryListScreen> createState() => HistoryListScreenState();
}

class HistoryListScreenState extends State<HistoryListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderListProvider>(context, listen: false)
        .fetchOrderList(orderListType: OrderListType.history);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        title: "Order History",
        automaticallyImplyLeading: false,
      ),
      body: Consumer<OrderListProvider>(builder: (__, orderListProvider, _) {
        switch (orderListProvider.orderList.status) {
          case Status.ERROR:
            return const ErrorInfoWidget();

          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case Status.COMPLETED:
            if (orderListProvider.orderList.data!.results.isEmpty) {
              return const ErrorInfoWidget(
                  errorInfo:
                      "Our records indicate that there are no orders in your order history.");
            }
            return ScrollConfiguration(
              behavior: MyBehaviour(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.paddingLg,
                  horizontal: AppSizes.paddingLg,
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(height: 24.h),
                  itemCount: orderListProvider.orderList.data!.results.length,
                  itemBuilder: (context, index) => EachOrderItem(
                    olModel: orderListProvider.orderList.data!.results[index],
                    index: orderListProvider.orderList.data!.results.indexOf(
                      orderListProvider.orderList.data!.results[index],
                    ),
                  ),
                ),
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
