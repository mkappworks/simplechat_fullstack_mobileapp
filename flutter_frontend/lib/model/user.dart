class User {
  late String id;
  late String email;
  late String name;
  late String age;
  late String gender;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.age,
    required this.gender,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['age'] = this.age;
    data['gender'] = this.gender;

    return data;
  }
}

List<User> dummyUserList = [
  User(
      id: '1',
      email: 'info.mkappworks@gmail.com',
      name: "Malith Kuruppu",
      age: "27",
      gender: "Male"),
  User(
      id: '2',
      email: 'johnwick@gmail.com',
      name: "John Wick",
      age: "50",
      gender: "Male"),
  User(
      id: '3',
      email: 'agentsmith@gmail.com',
      name: "Agent Smith",
      age: "45",
      gender: "Male"),
];
