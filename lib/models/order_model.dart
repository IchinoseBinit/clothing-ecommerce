class OrderModel {
  OrderModel({
    required this.product,
    required this.address,
    required this.quantity,
    required this.size,
    required this.color,
  });
  late final int product;
  late final String address;
  late final int quantity;
  late final int size;
  late final int color;
  late bool isExpanded = false;

  OrderModel.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    address = json['address'];
    quantity = json['quantity'];
    size = json['size'];
    color = json['color'];
  }

  setExpanded() {
    isExpanded = !isExpanded;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product'] = product;
    data['address'] = address;
    data['quantity'] = quantity;
    data['size'] = size;
    data['color'] = color;
    return data;
  }
}
