class UserModel {
  UserModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.birthday});

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? birthday;

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['name'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    birthday = json['birthday'];
  }

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     firstName: json['firstName'],
  //     lastName: json['lastName'],
  //     phoneNumber: json['phoneNumber'],
  //     email: json['email'],
  //     birthday: json['birthday'],
  //   );
  // }

  Map<String, String> toJson() => {
    'name' : firstName!,
    'lastName' : lastName!,
    'phoneNumber' : phoneNumber!,
    'email' : email!,
  };
}
