import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_frontend/model/message.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/service/helper/preferences_helper.dart';
import 'package:flutter_frontend/utilities/constants.dart';

class ServiceManager {
  final header = {"Content-Type": "application/json"};

  // login function
  void login(Map<String, dynamic> userData,
      {required void Function(bool status, String message)
          completionHandler}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var body = json.encode(userData);

    try {
      //send a post http request to /user/login route in the kBaseURL
      var response = await http.post(Uri.parse('$kBaseURL/user/login'),
          headers: header, body: body);

      var jsonBody = jsonDecode(response.body);

      if (jsonBody['message'] is bool) {
        var status = jsonBody['message'];
        if (status) {
          //save myID to local storage when user login.
          await pref.setString('myID', jsonBody['_id']);

          completionHandler(true, 'User is logged in');
        } else {
          completionHandler(false, 'User already exits');
        }
      } else {
        completionHandler(false, jsonBody['message']);
      }
    } catch (error) {
      print(error);
    }
  }

  // Fetch UserList
  Future<List<User>> fetchUserList() async {
    var myID = await SharedPreferencesHelper().getMyID();
    var body = json.encode({"id": myID});
    var response = await http.post(Uri.parse('$kBaseURL/user/userList'),
        headers: header, body: body);

    if (response.statusCode == 200) {
      var list = (json.decode(response.body) as List)
          .map((element) => User.fromJson(element))
          .toList();
      return list;
    } else {
      return [];
    }
  }

  Future<List<Message>> fetchMessageList(String receiverID) async {
    var myID = await SharedPreferencesHelper().getMyID();
    var body = json.encode({"sender": myID, "receiver": receiverID});
    var response = await http.post(Uri.parse('$kBaseURL/message/fetchmessage'),
        headers: header, body: body);

    if (response.statusCode == 200) {
      var list = (json.decode(response.body) as List)
          .map((e) => Message.fromJson(e))
          .toList();
      return list;
    } else {
      return [];
    }
  }
}
