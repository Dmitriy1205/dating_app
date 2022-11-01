class UserModel {
  UserModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.birthday,
      this.userId,
      this.registrationDate});

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? birthday;
  String? userId;
  String? registrationDate;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(firstName : json['name'],
    lastName : json['lastName'],
    phoneNumber : json['phoneNumber'],
    email : json['email'],
    birthday : json['birthday'],
    userId : json['userId'],
    registrationDate : json['registrationDate'],);
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

  Map<String, dynamic> toJson() => {
        'name': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        'userId': userId,
        'registrationDate': registrationDate
      };
}
