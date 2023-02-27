import 'dart:developer';

import 'package:equatable/equatable.dart';
import "package:intl/intl.dart";

import '/data/extensions/decimal_round_off.dart';
import '/providers/hive_database_helper.dart';

class CategoryGroup {
  int? id;
  String? name;
  List<String>? serviceAvailableFor;
  String? description;
  bool? isActive;
  int? priority;
  List<Items>? items;

  CategoryGroup(
      {this.id,
      this.name,
      this.serviceAvailableFor,
      this.description,
      this.isActive,
      this.priority,
      this.items});

  CategoryGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceAvailableFor = json['service_available_for'].cast<String>();
    description = json['description'] ?? "";
    isActive = json['is_active'];
    priority = json['priority'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v, catId: json['id'] ?? -1));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['service_available_for'] = serviceAvailableFor;
    data['description'] = description;
    data['is_active'] = isActive;
    data['priority'] = priority;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items extends Equatable {
  late final int id;
  late final int categoryId;
  String? name;
  String? image;
  int? quantity;
  late int selectedQuantity;
  late double totalPrice;
  String? retailPrice;
  String? specialPrice;
  int? priority;
  String? description;
  List<String>? serviceAvailableFor;
  String? merchantDomain;
  String? locationCode;
  bool? isActive;

  Items(
      {required this.id,
      required this.categoryId,
      this.name,
      this.image,
      this.quantity,
      this.selectedQuantity = 0,
      this.retailPrice,
      this.specialPrice,
      this.totalPrice = 0,
      this.priority,
      this.description,
      this.serviceAvailableFor,
      this.merchantDomain,
      this.locationCode,
      this.isActive});

  Items.fromJson(Map<String, dynamic> json, {required int catId}) {
    id = json['id'];
    categoryId = catId;
    name = json['name'];
    image = json['image'] ?? "";
    quantity = json['quantity'];
    selectedQuantity = 0;
    totalPrice = 0;
    retailPrice = json['retail_price'];
    specialPrice = json['special_price'];
    priority = json['priority'];
    description = json['description'] != null
        ? Bidi.stripHtmlIfNeeded(json['description'].toString())
        : '';
    serviceAvailableFor = json['service_available_for'].cast<String>();
    merchantDomain = json['merchant_domain'];
    locationCode = json['location_code'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['quantity'] = quantity;
    data['retail_price'] = retailPrice;
    data['special_price'] = specialPrice;
    data['priority'] = priority;
    data['description'] = description;
    data['service_available_for'] = serviceAvailableFor;
    data['merchant_domain'] = merchantDomain;
    data['location_code'] = locationCode;
    data['is_active'] = isActive;
    return data;
  }

  setQuantity(int selectedQuantity) {
    this.selectedQuantity = selectedQuantity;
    totalPrice = double.parse(selectedQuantity.toString()) *
        parseDoubleToFixedPrecision(specialPrice ?? retailPrice!);
  }

  increaseQuantity(
      {required int merchantId, required int merchantLocationId}) async {
    log("$merchantId: merchant id increase quantity in merchant item model");
    selectedQuantity++;
    totalPrice = selectedQuantity * double.parse(specialPrice ?? retailPrice!);
    dynamic databaseData = await DatabaseHelper().getBoxItem(key: "cart");
    log(databaseData.toString());
    if (databaseData == null) {
      databaseData = {};
      databaseData[merchantId] = {
        "items": [
          {
            "itemId": id,
            "categoryId": categoryId,
            "quantity": selectedQuantity,
            "name": name
          }
        ]
      };
    } else {
      if ((databaseData as Map).keys.toList().contains(merchantId) &&
          databaseData[merchantId]["items"] != null) {
        log(databaseData.toString(), name: "Merchant model screen");
        List listItems = databaseData[merchantId]["items"];
        final index = listItems.indexWhere(
          (element) => element["itemId"] == id,
        );
        if (index != -1) {
          listItems[index]["quantity"] = selectedQuantity;
        } else {
          (databaseData[merchantId]["items"] as List).add({
            "itemId": id,
            "categoryId": categoryId,
            "quantity": selectedQuantity,
            "name": name
          });
        }
      } else {
        databaseData[merchantId] = {
          ...databaseData[merchantId],
          "items": [
            {
              "itemId": id,
              "categoryId": categoryId,
              "quantity": selectedQuantity,
              "name": name
            }
          ]
        };
      }
    }

    log(databaseData.toString());
    await DatabaseHelper().addBoxItem(key: "cart", value: databaseData);
  }

  decreaseQuatity(
      {required int merchantId, required int merchantLocationId}) async {
    selectedQuantity--;
    totalPrice = selectedQuantity * double.parse(specialPrice ?? retailPrice!);
    log("$merchantId: merchant id");
    dynamic databaseData = await DatabaseHelper().getBoxItem(key: "cart");
    if (databaseData == null) {
      databaseData = {};
      databaseData[merchantId] = {
        "items": [
          {
            "itemId": id,
            "categoryId": categoryId,
            "quantity": selectedQuantity,
            "name": name
          }
        ]
      };
    } else {
      if ((databaseData as Map).keys.toList().contains(merchantId) &&
          databaseData[merchantId]["items"] != null) {
        log(databaseData.toString(), name: "Merchant model screen");
        List listItems = databaseData[merchantId]["items"];
        final index = listItems.indexWhere(
          (element) => element["itemId"] == id,
        );
        if (index != -1) {
          if (listItems[index]["quantity"] == 1) {
            (databaseData[merchantId]["items"] as List).removeAt(index);
            if (listItems.isEmpty) {
              (databaseData[merchantId] as Map).remove("items");
              (databaseData[merchantId] as Map).remove("locationCode");
              (databaseData[merchantId] as Map).remove("deliveryType");
            }
          } else {
            listItems[index]["quantity"] = selectedQuantity;
          }
        } else {
          (databaseData[merchantId]["items"] as List).add({
            "itemId": id,
            "categoryId": categoryId,
            "quantity": selectedQuantity,
            "name": name
          });
        }
      } else {
        databaseData[merchantId] = {
          ...databaseData[merchantId],
          "items": [
            {
              "itemId": id,
              "categoryId": categoryId,
              "quantity": selectedQuantity,
              "name": name
            }
          ]
        };
      }
    }

    log(databaseData.toString());
    await DatabaseHelper().addBoxItem(key: "cart", value: databaseData);
  }

  List<Object> get props => [id];
}
