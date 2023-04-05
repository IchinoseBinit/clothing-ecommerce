class LocationModel {
  LocationModel({
    required this.id,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.user,
  });
  late final int id;
  late final String name;
  late final String longitude;
  late final String latitude;
  late final int user;

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['user'] = user;
    return data;
  }
}
