class EditProfileModel {
  String? email;
  String? name;

  EditProfileModel({this.email, this.name});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}
