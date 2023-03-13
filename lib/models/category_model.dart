class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });
  late final int id;
  late final String name;
  late final String image;
  late final String description;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] ?? "";
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['description'] = description;
    return _data;
  }
}
