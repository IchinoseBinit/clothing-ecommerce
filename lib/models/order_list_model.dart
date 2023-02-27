class OrderListModel {
  OrderListModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
  late final int count;
  late final int? next;
  late final int? previous;
  late final List<Results> results;

  OrderListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results =
        List.from(json['results']).map((e) => Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['next'] = next;
    _data['previous'] = previous;
    _data['results'] = results.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Results {
  Results({
    required this.id,
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
    required this.taxAmount,
    required this.subTotal,
    required this.discountAmount,
    required this.paymentExtensionTxnCode,
    required this.notes,
  });
  late final int id;
  late final String orderCode;
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
  late final String taxAmount;
  late final String subTotal;
  late final String discountAmount;
  late final String paymentExtensionTxnCode;
  late final String notes;

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
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
    taxAmount = json['tax_amount'];
    subTotal = json['sub_total'];
    discountAmount = json['discount_amount'];
    paymentExtensionTxnCode = json['payment_extension_txn_code'] ?? "";
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_code'] = orderCode;
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
    _data['tax_amount'] = taxAmount;
    _data['sub_total'] = subTotal;
    _data['discount_amount'] = discountAmount;
    _data['payment_extension_txn_code'] = paymentExtensionTxnCode;
    _data['notes'] = notes;
    return _data;
  }
}

class MerchantInfo {
  MerchantInfo({
    required this.name,
    required this.domain,
  });
  late final String name;
  late final String domain;

  MerchantInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['domain'] = domain;
    return _data;
  }
}
