import 'package:flutter/cupertino.dart';
import '/api/cart_price_api.dart';
import '/data/response/api_response.dart';
import '/models/cart_price_model.dart';
import '/models/profile_model.dart';
import '/utils/show_toast.dart';

class CartPriceProvider with ChangeNotifier {
  final _cartPriceApi = CartPriceApi();
  bool contentRefreshLoading = false;
  ProfileModel? guestUser;
  ApiResponse<CartPriceModel> cartPriceData = ApiResponse.loading();

  setGuestUser(ProfileModel? guest) {
    guestUser = guest;
  }

  decreaseQuantity({required int merchantId, required Items item}) async {
    await item.decreaseQuantity(merchantId: merchantId);
    notifyListeners();
  }

  increaseQuantity({required int merchantId, required Items item}) async {
    await item.increaseQuantity(merchantId: merchantId);
    notifyListeners();
  }

  setCartPrice(ApiResponse<CartPriceModel> response,
      {required bool isRefreshContent}) {
    cartPriceData = response;
    if (isRefreshContent) {
      contentRefreshLoading = false;
    }
    notifyListeners();
  }

  Future<void> fetchCartPrice(Map body,
      {required bool isRefreshContent}) async {
    if (!isRefreshContent) {
      setCartPrice(ApiResponse.loading(), isRefreshContent: false);
    } else {
      contentRefreshLoading = true;
      notifyListeners();
    }

    await _cartPriceApi.fetchCartPrice(body).then((value) {
      if (value.discount == -1) {
        // Provider.of<CouponProvider>(navKey.currentState!.context, listen: false)
        //     .setCoupon("");
        showToast("Invalid coupon. Check terms & expiry date.");
      }
      setCartPrice(ApiResponse.completed(value),
          isRefreshContent: isRefreshContent);
    }).onError((error, stackTrace) async {
      showToast(error.toString());

      if (isRefreshContent) {
        contentRefreshLoading = false;
        notifyListeners();
      }
    });
  }
}
