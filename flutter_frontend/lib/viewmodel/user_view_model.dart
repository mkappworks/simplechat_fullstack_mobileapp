import 'package:flutter_frontend/model/user.dart';

class UserViewModel {
  User _user;

  UserViewModel({required User user}) : this._user = user;

  String get id => _user.id;
  String get email => _user.email;
  String get name => _user.name;
  String get age => _user.age;
  String get gender => _user.gender;
}