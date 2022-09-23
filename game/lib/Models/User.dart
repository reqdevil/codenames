// ignore_for_file: file_names

import 'dart:convert';

User userFromJson(Map<String, dynamic> json) => User.fromJson(json);

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int? id;
  final String username;
  final String email;
  final String name;
  final String surname;
  final String? password;
  User({
    required this.username,
    required this.email,
    required this.name,
    required this.surname,
    this.password,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
      };

  void printUser() {
    print("$id: $username, $name, $surname, $email");
  }
}
