// import 'dart:developer';

// import '/api/network/rhino_client.dart';
// import '/data/app_urls.dart';
// import '/utils/order_list_type.dart';
// import '/utils/request_type.dart';

// class OrderListApi {
//   final _rhino = RhinoClient();

//   Future<dynamic> fetchOrderList({required OrderListType orderListType}) async {
//     try {
//       dynamic response = await _rhino.request(
//         url:
//             "${AppUrl.orderListUrl}?order_type=${orderListType == OrderListType.history ? "older" : "upcomming"}",
//         requestType: RequestType.getWithToken,
//       );
//       return OrderListModel.fromJson(response);
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }
// }
