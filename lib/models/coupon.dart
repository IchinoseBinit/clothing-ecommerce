class Coupon {
  Coupon({
    required this.name,
    required this.code,
    required this.minimumSpend,
    required this.toDate,
    required this.applicableTo,
  });
  late final String name;
  late final String code;
  late final String minimumSpend;
  late final String toDate;
  late final String applicableTo;

  Coupon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    minimumSpend = json['minimum_spend'];
    toDate = json['to_date']??"";
    applicableTo = json['applicable_to'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['code'] = code;
    _data['minimum_spend'] = minimumSpend;
    _data['to_date'] = toDate;
    _data['applicable_to'] = applicableTo;
    return _data;
  }
}
