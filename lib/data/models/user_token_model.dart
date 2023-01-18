class UserTokenModel{
  late String uId, token;

  UserTokenModel({required this.uId, required this.token});

  UserTokenModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'token': token,
    };
  }
}