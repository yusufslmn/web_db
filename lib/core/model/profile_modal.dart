class UserDataModel {
  bool? isMale;
  String? name;
  String? surname;
  String? email;
  String? birthDate;

  UserDataModel(
      {this.isMale, this.name, this.surname, this.email, this.birthDate});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    isMale = json['isMale'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isMale'] = isMale;
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['birthDate'] = birthDate;
    return data;
  }
}
