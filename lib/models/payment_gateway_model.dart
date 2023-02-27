class PaymentGateway {
  PaymentGateway({
    required this.name,
    required this.code,
    required this.sortOrder,
    required this.details,
  });
  late final String name;
  late final int id;
  late final String code;
  late final int sortOrder;
  late final List<Details> details;

  PaymentGateway.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    code = json['code'];
    sortOrder = json['sort_order'];
    details =
        List.from(json['details']).map((e) => Details.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['code'] = code;
    _data['sort_order'] = sortOrder;
    _data['details'] = details.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Details {
  Details({
    required this.key,
    required this.value,
  });
  late final String key;
  late final String value;

  Details.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['key'] = key;
    _data['value'] = value;
    return _data;
  }
}
