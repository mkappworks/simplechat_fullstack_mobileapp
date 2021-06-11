import 'dart:convert';
import 'package:flutter_frontend/controller/helper/local_storage_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/utilities/constants.dart';

class UserServiceHelper {
  static final shared = UserServiceHelper();

  final _header = {"Content-Type": "application/json"};

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
        await LocalStorageHelper.shared.saveUserInfoForLocale(_user);
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
        await LocalStorageHelper.shared.removeUserInfoFromLocale();
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
}
