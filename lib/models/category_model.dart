class CategoryModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  CategoryModel({this.count, this.next, this.previous, this.results});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? name;
  String? merchantDomain;
  int? priority;
  bool? isActive;
  List<String>? serviceAvailableFor;

  Results(
      {this.id,
      this.name,
      this.merchantDomain,
      this.priority,
      this.isActive,
      this.serviceAvailableFor});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    merchantDomain = json['merchant_domain'];
    priority = json['priority'];
    isActive = json['is_active'];
    serviceAvailableFor = json['service_available_for'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['merchant_domain'] = merchantDomain;
    data['priority'] = priority;
    data['is_active'] = isActive;
    data['service_available_for'] = serviceAvailableFor;
    return data;
  }
}
