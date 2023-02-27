class LoginModel {
  String? accessToken;
  String? refreshToken;
  // User? user;

  LoginModel({
    this.accessToken,
    this.refreshToken,
    // this.user,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    // user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    // if (user != null) {
    //   data['user'] = user!.toJson();
    // }
    return data;
  }
}

class User {
  String? email;
  String? name;

  User({this.email, this.name});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}
