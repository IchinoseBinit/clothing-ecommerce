class RefreshTokenModel {
  RefreshTokenModel({
    required this.access,
    required this.refresh,
    // required this.accessTokenExpiration,
  });
  late final String access;
  late final String refresh;
  // late final String accessTokenExpiration;

  RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
    // accessTokenExpiration = json['access_token_expiration'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['access'] = access;
    _data['refresh'] = refresh;
    // _data['access_token_expiration'] = accessTokenExpiration;
    return _data;
  }
}
