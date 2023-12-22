class LoginModel {
  String? email;
  String? password;
  String? birthDate;
  bool? isMale;
  String? name;
  String? surname;

  LoginModel(
      {this.email,
      this.password,
      this.birthDate,
      this.isMale,
      this.name,
      this.surname});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    birthDate = json['birthDate'];
    isMale = json['isMale'];
    name = json['name'];
    surname = json['surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['birthDate'] = birthDate;
    data['isMale'] = isMale;
    data['name'] = name;
    data['surname'] = surname;
    return data;
  }
}
