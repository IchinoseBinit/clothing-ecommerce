class ProfileModel {
  late final String email;
  late final String name;
  late final String mobile;

  ProfileModel({
    required this.email,
    required this.name,
    required this.mobile,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['mobile'] = mobile;
    return data;
  }
}
