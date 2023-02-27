class AnnouncementModel {
  AnnouncementModel({
    required this.id,
    required this.name,
    required this.code,
    required this.sortOrder,
    required this.details,
  });
  late final int id;
  late final String name;
  late final String code;
  late final int sortOrder;
  late final List<Details> details;

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    sortOrder = json['sort_order'];
    details =
        List.from(json['details']).map((e) => Details.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
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
    required this.isEncrypted,
  });
  late final String key;
  late final String value;
  late final bool isEncrypted;

  Details.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    isEncrypted = json['is_encrypted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['key'] = key;
    _data['value'] = value;
    _data['is_encrypted'] = isEncrypted;
    return _data;
  }
}
