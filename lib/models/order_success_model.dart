class OrderSuccessModel {
  OrderSuccessModel(
      {required this.id,
      required this.orderCode,
      required this.orderType,
      required this.deliveryTime,
      required this.deliveryAddress,
      required this.status,
      required this.createdAt,
      required this.merchantInfo,
      required this.locationAddress,
      required this.currency,
      required this.grandTotal,
      required this.paymentExtensionTxnCode,
      required this.notes,
      required this.customerEmail,
      required this.customerMobile,
      required this.customerName,
      required this.paymentExtensionNote});
  late final int id;
  late final String orderCode;
  late final String customerName;
  late final String customerEmail;
  late final String customerMobile;
  late final String orderType;
  late final String deliveryTime;
  late final String deliveryAddress;
  late final String status;
  late final String createdAt;
  late final MerchantInfo merchantInfo;
  late final String locationAddress;
  late final String currency;
  late final String grandTotal;
  late final String paymentExtensionTxnCode;
  late final String paymentExtensionNote;
  late final String notes;

  OrderSuccessModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    orderType = json['order_type'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerMobile = json['customer_mobile'];
    deliveryTime = json['delivery_time'];
    deliveryAddress = json['delivery_address'];
    status = json['status'];
    createdAt = json['created_at'];
    merchantInfo = MerchantInfo.fromJson(json['merchant_info']);
    locationAddress = json['location_address'];
    currency = json['currency'];
    grandTotal = json['grand_total'];
    paymentExtensionTxnCode = json['payment_extension_txn_code'] ?? "";
    paymentExtensionNote = json['payment_extension_note'] ?? "";
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_code'] = orderCode;
    _data['order_type'] = orderType;
    _data['delivery_time'] = deliveryTime;
    _data['delivery_address'] = deliveryAddress;
    _data['customer_name'] = customerName;
    _data['customer_email'] = customerEmail;
    _data['customer_mobile'] = customerMobile;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['merchant_info'] = merchantInfo.toJson();
    _data['location_address'] = locationAddress;
    _data['currency'] = currency;
    _data['grand_total'] = grandTotal;
    _data['payment_extension_txn_code'] = paymentExtensionTxnCode;
    _data['payment_extension_note'] = paymentExtensionNote;
    _data['notes'] = notes;
    return _data;
  }
}

class MerchantInfo {
  MerchantInfo({
    required this.name,
    required this.domain,
    required this.contactNumber,
    required this.contactEmail,
  });
  late final String name;
  late final String domain;
  late final String contactNumber;
  late final String contactEmail;

  MerchantInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    domain = json['domain'];
    contactNumber = json['contact_number'];
    contactEmail = json['contact_email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['domain'] = domain;
    _data['contact_number'] = contactNumber;
    _data['contact_email'] = contactEmail;
    return _data;
  }
}
