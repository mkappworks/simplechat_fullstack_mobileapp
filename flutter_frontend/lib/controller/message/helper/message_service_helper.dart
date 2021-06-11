import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_frontend/model/message.dart';

import 'package:flutter_frontend/utilities/constants.dart';

class MessageServiceHelper {
  static final shared = MessageServiceHelper();

  final _header = {"Content-Type": "application/json"};

  Future<List<Message>> fetchMessageList(String receiverID) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String myID = pref.getString('myID')!;
      var _body = json.encode({"sender": myID, "receiver": receiverID});

      var response = await http.post(
          Uri.parse('$kBaseURL/message/fetchmessage'),
          headers: _header,
          body: _body);

      var jsonBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Message> _messageList = messagesFromJson(jsonBody).toList();

        return _messageList;
      } else {
        return <Message>[];
      }
    } catch (error) {
      print('Error at fetchMessageList : $error');
      return <Message>[];
    }
  }
}
