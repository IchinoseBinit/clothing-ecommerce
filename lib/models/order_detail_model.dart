import 'dart:developer';

class OrderDetailModel {
  OrderDetailModel(
      {required this.id,
      required this.orderCode,
      required this.orderType,
      required this.deliveryTime,
      required this.deliveryAddress,
      required this.status,
      required this.statusColor,
      required this.createdAt,
      required this.merchantInfo,
      required this.locationAddress,
      required this.currency,
      required this.grandTotal,
      required this.couponCode,
      required this.taxAmount,
      required this.subTotal,
      required this.discountAmount,
      required this.taxPercentage,
      required this.paymentExtensionTxnCode,
      required this.notes,
      required this.orderItem,
      required this.deliveryType,
      required this.deliveryFee,
      required this.paymentExtensionNote});
  late final int id;
  late final String orderCode;
  late final String customerName;
  late final String customerMobile;
  late final String customerEmail;
  late final String orderType;
  late final String deliveryTime;
  late final String deliveryAddress;
  late final String status;
  late final String statusColor;
  late final String createdAt;
  late final MerchantInfo merchantInfo;
  late final String locationAddress;
  late final String currency;
  late final String grandTotal;
  late final String couponCode;
  late final String taxAmount;
  late final String subTotal;
  late final String discountAmount;
  late final String taxPercentage;
  late final String paymentExtensionTxnCode;
  late final String notes;
  late final List<OrderItem> orderItem;
  late final String deliveryFee;
  late final String deliveryType;
  late final String paymentExtensionNote;

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    customerEmail = json['customer_email'];
    customerMobile = json['customer_mobile'];
    customerName = json['customer_name'];
    orderType = json['order_type'];
    deliveryTime = json['delivery_time'];
    deliveryAddress = json['delivery_address'];
    status = json['status'];
    statusColor = json['status_color'];
    createdAt = json['created_at'];
    merchantInfo = MerchantInfo.fromJson(json['merchant_info']);
    locationAddress = json['location_address'];
    currency = json['currency'];
    grandTotal = json['grand_total'];
    couponCode = json['coupon_code'];
    taxAmount = json['tax_amount'];
    subTotal = json['sub_total'];
    discountAmount = json['discount_amount'];
    taxPercentage = json['tax_percentage'];
    paymentExtensionTxnCode = json['payment_extension_txn_code'] ?? "";
    paymentExtensionNote = json['payment_extension_note'] ?? "";
    notes = json['notes'] ?? "";
    orderItem = List.from(json['order_item'])
        .map((e) => OrderItem.fromJson(e))
        .toList();

    deliveryFee = json["delivery_fee"] ?? "";

    deliveryType = json["order_type"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_code'] = orderCode;
    _data['customer_email'] = customerEmail;
    _data['customer_mobile'] = customerMobile;
    _data['customer_name'] = customerName;
    _data['order_type'] = orderType;
    _data['delivery_time'] = deliveryTime;
    _data['delivery_address'] = deliveryAddress;
    _data['status'] = status;
    _data['status_color'] = statusColor;
    _data['created_at'] = createdAt;
    _data['merchant_info'] = merchantInfo.toJson();
    _data['location_address'] = locationAddress;
    _data['currency'] = currency;
    _data['grand_total'] = grandTotal;
    _data['tax_percentage'] = taxPercentage;
    _data['coupon_code'] = couponCode;
    _data['tax_amount'] = taxAmount;
    _data['sub_total'] = subTotal;
    _data['discount_amount'] = discountAmount;
    _data['payment_extension_txn_code'] = paymentExtensionTxnCode;
    _data['payment_extension_note'] = paymentExtensionNote;
    _data['notes'] = notes;
    _data['order_item'] = orderItem.map((e) => e.toJson()).toList();
    return _data;
  }
}

class MerchantInfo {
  MerchantInfo({
    required this.name,
    required this.domain,
    required this.contactEmail,
    required this.contactNumber,
  });
  late final String name;
  late final String domain;
  late final String contactEmail;
  late final String contactNumber;

  MerchantInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    domain = json['domain'];
    contactEmail = json['contact_email'] ?? "";
    contactNumber = json['contact_number'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['domain'] = domain;
    data['contact_email'] = contactEmail;
    data['contact_number'] = contactNumber;
    return data;
  }
}

class OrderItem {
  OrderItem({
    required this.itemName,
    required this.quantity,
    required this.retailPrice,
    this.specialPrice,
    required this.billAmount,
  });
  late final String itemName;
  late final int quantity;
  late final String retailPrice;
  late final String? specialPrice;
  late final String billAmount;

  OrderItem.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    quantity = json['quantity'];
    retailPrice = json['retail_price'];
    specialPrice = json['special_price'];
    billAmount = json['bill_amount'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['quantity'] = quantity;
    data['retail_price'] = retailPrice;
    data['special_price'] = specialPrice;
    data['bill_amount'] = billAmount;
    return data;
  }
}
