import 'dart:developer';

import 'package:equatable/equatable.dart';

import '/data/extensions/decimal_round_off.dart';
import '/providers/hive_database_helper.dart';

class CartPriceModel {
  CartPriceModel(
      {required this.subtotal,
      required this.deliveryFee,
      required this.freeDeliveryLimit,
      required this.deliveryDiscount,
      required this.discount,
      required this.taxPer,
      required this.taxAmt,
      required this.total,
      required this.items,
      required this.deliveryType,
      required this.currency,
      required this.minimumOrder,
      required this.couponCode,
      required this.invalidItems});
  late final double subtotal;
  late final double deliveryFee;
  late final double freeDeliveryLimit;
  late final double deliveryDiscount;
  late final double discount;
  late final double taxPer;
  late final double? taxAmt;
  late final double total;
  late final List<Items> items;
  late List<Items> invalidItems = [];
  late final String deliveryType;
  late final String currency;
  late final double minimumOrder;
  late final String couponCode;

  CartPriceModel.fromJson(Map<String, dynamic> json) {
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    deliveryType = json['delivery_type'];
    subtotal = parseDoubleToFixedPrecision(json['subtotal']);
    deliveryFee = parseDoubleToFixedPrecision(json['delivery_fee']);
    freeDeliveryLimit =
        parseDoubleToFixedPrecision(json['free_delivery_limit']);
    deliveryDiscount = parseDoubleToFixedPrecision(json['delivery_discount']);
    discount = parseDoubleToFixedPrecision(json['discount']);
    taxPer = parseDoubleToFixedPrecision(json['tax_per']);
    taxAmt = parseDoubleToFixedPrecision(json['tax_amt']);
    total = parseDoubleToFixedPrecision(json['total']);
    currency = json['currency'];
    minimumOrder = parseDoubleToFixedPrecision(json['minimum_order']);
    couponCode = json['coupon_code'] ?? "";
    invalidItems =
        List.from(json['invalid_items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['invalid_items'] = items.map((e) => e.toJson()).toList();
    _data['delivery_type'] = deliveryType;
    _data['subtotal'] = subtotal;
    _data['delivery_fee'] = deliveryFee;
    _data['free_delivery_limit'] = freeDeliveryLimit;
    _data['delivery_discount'] = deliveryDiscount;
    _data['discount'] = discount;
    _data['tax_per'] = taxPer;
    _data['tax_amt'] = taxAmt;
    _data['total'] = total;
    _data['currency'] = currency;
    _data['minimum_order'] = minimumOrder;
    _data['coupon_code'] = couponCode;
    return _data;
  }
}

class Items extends Equatable {
  Items({
    required this.id,
    required this.quantity,
    required this.name,
    required this.specialPrice,
    required this.retailPrice,
    required this.specialPriceTotal,
    required this.retailPriceTotal,
    this.selectedQuantity = 0,
  });
  late final int id;
  late final int quantity;
  late final String name;
  late int selectedQuantity;
  late final double specialPrice;
  late final double retailPrice;
  late final double specialPriceTotal;
  late final double retailPriceTotal;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selectedQuantity = json['quantity'];
    quantity = json['quantity'];
    name = json['name'];
    specialPrice = parseDoubleToFixedPrecision(json['special_price']);
    retailPrice = parseDoubleToFixedPrecision(json['retail_price']);
    specialPriceTotal =
        parseDoubleToFixedPrecision(json['special_price_total']);
    retailPriceTotal = parseDoubleToFixedPrecision(json['retail_price_total']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['quantity'] = quantity;
    _data['name'] = name;
    _data['special_price'] = specialPrice;
    _data['retail_price'] = retailPrice;
    _data['special_price_total'] = specialPriceTotal;
    _data['retail_price_total'] = retailPriceTotal;
    return _data;
  }

  setQuantity(int selectedQuantity) {
    this.selectedQuantity = selectedQuantity;
  }

  increaseQuantity({required int merchantId}) async {
    log("$merchantId: merchant id increase quantity in merchant item model");
    selectedQuantity++;
    // totalPrice = selectedQuantity * double.parse(specialPrice ?? retailPrice!);
    dynamic databaseData = await DatabaseHelper().getBoxItem(key: "cart");
    log(databaseData.toString());

    if ((databaseData as Map).keys.toList().contains(merchantId) &&
        databaseData[merchantId]["items"] != null) {
      log(databaseData.toString(), name: "Merchant model screen");
      List listItems = databaseData[merchantId]["items"];
      final index = listItems.indexWhere(
        (element) => element["itemId"] == id,
      );
      if (index != -1) {
        listItems[index]["quantity"] = selectedQuantity;
      } else {}
    }
    log(databaseData.toString());
    await DatabaseHelper().addBoxItem(key: "cart", value: databaseData);
  }

  decreaseQuantity({required int merchantId}) async {
    selectedQuantity--;
    // totalPrice = selectedQuantity * double.parse(specialPrice ?? retailPrice!);
    log("$merchantId: merchant id");
    dynamic databaseData = await DatabaseHelper().getBoxItem(key: "cart");

    log(databaseData.toString(), name: "Merchant model screen");
    if (databaseData[merchantId] != null &&
        databaseData[merchantId]["items"] == null) {
      (databaseData as Map).remove(merchantId);
    } else {
      List? listItems = databaseData[merchantId]["items"];
      final index = listItems!.indexWhere(
        (element) => element["itemId"] == id,
      );
      if (listItems[index]["quantity"] == 1) {
        (databaseData[merchantId]["items"] as List).removeAt(index);
        if ((databaseData[merchantId]["items"] as List).isEmpty) {
          (databaseData as Map).remove(merchantId);
        }
      } else {
        listItems[index]["quantity"] = selectedQuantity;
      }
    }
    await DatabaseHelper().addBoxItem(key: "cart", value: databaseData);
  }

  List<Object> get props => [id];
}
