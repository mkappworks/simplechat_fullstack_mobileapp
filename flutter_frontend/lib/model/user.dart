import 'dart:convert';

List<User> usersFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

User userFromJson(String str) => User.fromJson(json.decode(str)['userdata']);

String usersToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String id;
  final String email;
  final String name;
  final String age;
  final String gender;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.age,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "age": age,
        "gender": gender,
      };
}
