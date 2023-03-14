import 'dart:typed_data';

class Student {
  int id;
  String? photo;
  String name;
  String email;
  int phoneNumber;
  String password;

  Student(
      {required this.id,
      this.photo,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.password});

  factory Student.formMap({required Map map}) {
    return Student(
        id: map["id"],
        photo: map["photo"],
        name: map["name"],
        email: map["email"],
        phoneNumber: map["phoneNumber"],
        password: map["password"]);
  }
}
