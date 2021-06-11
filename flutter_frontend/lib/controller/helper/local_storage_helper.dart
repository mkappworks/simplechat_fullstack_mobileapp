import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_frontend/model/user.dart';

class LocalStorageHelper {
  static final shared = LocalStorageHelper();

  // Save to user details in local storage when user login.
  Future<void> saveUserInfoForLocale(User user) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      await pref.setString('myID', user.id);
      await pref.setString('myEmail', user.email);
      await pref.setString('myName', user.name);
      await pref.setString('myAge', user.age);
      await pref.setString('myGender', user.gender);
    } catch (error) {
      print('Error at _saveUserInfoForLocale : $error');
    }
  }

  //get logged in user details
  Future<User?> getUserInfoFromLocale() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      String? _id = pref.getString('myID');
      String? _email = pref.getString('myEmail');
      String? _name = pref.getString('myName');
      String? _age = pref.getString('myAge');
      String? _gender = pref.getString('myGender');

      if (_id != null &&
          _email != null &&
          _name != null &&
          _age != null &&
          _gender != null) {
        return User(
            id: _id, email: _email, name: _name, age: _age, gender: _gender);
      } else {
        return null;
      }
    } catch (error) {
      print('Error at getUserInfoFromLocale : $error');
    }
  }

  //removing userdata from local storage
  Future<void> removeUserInfoFromLocale() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove('myID');
      pref.remove('myEmail');
      pref.remove('myName');
      pref.remove('myAge');
      pref.remove('myGender');
    } catch (error) {
      print('Error at _removeUserInfoFromLocale : $error');
    }
  }
}
