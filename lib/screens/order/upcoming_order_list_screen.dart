import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/data/response/status.dart';
import '/providers/intro_notifier.dart';
import '/providers/orders_list_provider.dart';
import '/screens/auth_screen/login_screen.dart';
import '/screens/order/history_order_list_screen.dart';
import '/screens/order/widgets/each_order_item.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';
import '/styles/styles.dart';
import '/utils/custom_scroll_behaviour.dart';
import '/utils/navigation_util.dart';
import '/utils/order_list_type.dart';
import '/utils/will_pop_scope.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/error_info_widget.dart';

class UpcomingOrderListScreen extends StatefulWidget {
  const UpcomingOrderListScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingOrderListScreen> createState() =>
      UpcomingOrderListScreenState();
}

class UpcomingOrderListScreenState extends State<UpcomingOrderListScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        if (!Provider.of<IntroProvider>(context, listen: false).hasAppToken) {
          await navigate(
            context,
            screen: const LoginScreen(
              isFromRefreshToken: true,
            ),
          );
        }
        Provider.of<OrderListProvider>(context, listen: false)
            .fetchOrderList(orderListType: OrderListType.upcoming);
        isInit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          await WillPopScopeClass.willPopCallback(context) ?? false,
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: false,
          title: "Upcoming Orders",
          automaticallyImplyLeading: false,
          disableLeading: true,
          actions: [
            GestureDetector(
              onTap: () async {
                await navigate(context, screen: const HistoryListScreen());
                Provider.of<OrderListProvider>(context, listen: false)
                    .fetchOrderList(orderListType: OrderListType.upcoming);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.history,
                    size: 24.r,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: AppSizes.paddingLg, left: AppSizes.padding),
                    child: Text(
                      "History",
                      style: subTitleText.copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                        "As per our records, there are no upcoming orders in your account.");
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
      ),
    );
  }
}
