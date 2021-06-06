class UserModel {
  final String email;
  final String name;
  final String age;
  final String gender;

  UserModel({
    required this.email,
    required this.name,
    required this.age,
    required this.gender,
  });
}

List<UserModel> dummyUserList = [
  UserModel(
      email: 'info.mkappworks@gmail.com',
      name: "Malith Kuruppu",
      age: "27",
      gender: "Male"),
  UserModel(
      email: 'johnwick@gmail.com',
      name: "John Wick",
      age: "50",
      gender: "Male"),
  UserModel(
      email: 'agentsmith@gmail.com',
      name: "Agent Smith",
      age: "45",
      gender: "Male"),
];
