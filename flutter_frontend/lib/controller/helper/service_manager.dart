import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_frontend/model/message.dart';
import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/utilities/constants.dart';

class ServiceManager {
  final _header = {"Content-Type": "application/json"};

  // Save to user details in local storage when user login.
  Future<void> _saveUserInfoForLocale(User user) async {
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
  Future<void> _removeUserInfoFromLocale() async {
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

  // login function
  Future<Map<String, dynamic>> login(Map<String, dynamic> userData) async {
    var _body = json.encode(userData);

    try {
      //send a post http request to /user/login route in the kBaseURL
      var response = await http.post(Uri.parse('$kBaseURL/user/login'),
          headers: _header, body: _body);

      if (response.statusCode == 201) {
        User _user = userFromJson(response.body);
        //saving userData to local storage when user login and statusCode equals to 201.
        await _saveUserInfoForLocale(_user);
        return {'status': true, 'message': 'User is logged in'};
      } else if (response.statusCode == 200) {
        return {'status': false, 'message': 'User already exits'};
      } else {
        return {
          'status': false,
          'message': 'login error  ${jsonDecode(response.body)['message']}'
        };
      }
    } catch (error) {
      return {'status': false, 'message': 'Login trycatch $error'};
    }
  }

  // logout function
  Future<void> logout(User loggedInUserData) async {
    String _id = loggedInUserData.id;

    try {
      //send a delete http request to /user/logout route in the kBaseURL
      var response = await http.delete(Uri.parse('$kBaseURL/user/logout/$_id'),
          headers: _header);

      if (response.statusCode == 200) {
        //remove userData from local storage when user logout-> and response statusCode equals 200.
        await _removeUserInfoFromLocale();
      } else {
        print('logout error ${jsonDecode(response.body)['message']}');
      }
    } catch (error) {
      print('logout trycatch $error');
    }
  }

  // Fetch UserList
  Future<List<User>> fetchUserList(User loggedInUserData) async {
    String _id = loggedInUserData.id;

    try {
      var response = await http.get(Uri.parse('$kBaseURL/user/userlist'),
          headers: _header);

      var jsonBody = response.body;

      if (response.statusCode == 200) {
        List<User> _usersList =
            usersFromJson(jsonBody).where((user) => user.id != _id).toList();
        return _usersList;
      } else {
        return <User>[];
      }
    } catch (error) {
      print('Error at fetchUserList : $error');
      return <User>[];
    }
  }

  Future<List<Message>> fetchMessageList(String receiverID) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String myID = pref.getString('myID')!;
      var body = json.encode({"sender": myID, "receiver": receiverID});
      var response = await http.post(
          Uri.parse('$kBaseURL/message/fetchmessage'),
          headers: _header,
          body: body);
      var jsonBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<Message> list =
            jsonBody.map((element) => Message.fromJson(element)).toList();
        // var list = (json.decode(response.body) as List)
        //     .map((e) => Message.fromJson(e))
        //     .toList();
        return list;
      } else {
        return <Message>[];
      }
    } catch (error) {
      print('Error at fetchMessageList : $error');
      return <Message>[];
    }
  }
}
