import 'dart:io';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/controller/message/message_controller.dart';
import 'package:flutter_frontend/controller/user/user_controller.dart';
import 'package:flutter_frontend/controller/helper/local_storage_helper.dart';

class SocketServiceHelper {
  MessageController _messageController = Get.find();
  UserController _userController = Get.find();

  static final shared = SocketServiceHelper();

  static String _serverIP =
      Platform.isIOS ? 'http://localhost' : 'http://10.0.2.2';

  IO.Socket socket = IO.io('$_serverIP:8080', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  var _logInUserData;

  Future<void> connectSocket() async {
    //get the the userdata from local storage
    _logInUserData = await LocalStorageHelper.shared.getUserInfoFromLocale();

    //connect to the socket the socket if the socket is disconnected
    if (socket.disconnected) socket.connect();

    //listen to 'connect' namespace in the server
    socket.on('connect', (data) {
      //forward the id of the new logged in user to 'userData' namespace in the server
      if (_logInUserData != null) {
        socket.emit('userData', {'id': _logInUserData.id});
      }
    });

    //listen to the 'loggedInUser' namespace to get the users logged in from the server
    socket.on('loggedInUser', (data) {
      List<User> _decodedList = usersFromJson(data);
      List<User> _newList = [];

      //_decodedList contains all the Users in the db
      //_newList contains all Users in the db except the _logInUserData
      if (_logInUserData != null) {
        _newList =
            _decodedList.where((user) => user.id != _logInUserData.id).toList();
      } //assign the RxList<User> _usersList = <User>[].obs in the UserController to the _newList
      _userController.setNewUserListFromSocket(_newList);
    });
    //listen to the 'receive_message' namespace to get the message content of other user (i.e. receiver)
    socket.on('receive_message', (data) {
      String _content = data['content'].toString();
      DateTime _createdAt = DateTime.parse(data['createdAt'].toString());

      //add the Message to the messageList in GetX MessageController class
      _messageController.addMessage(
          message: _content, isMy: false, createdAt: _createdAt);
    });
  }

  //trigger when logging out from the UsersScreen()
  Future<void> disconnectSocket() async {
    if (_logInUserData != null) {
      socket.disconnect();
    }
  }

  //trigger when sending a message
  Future<void> sendMessage(
      {required String receiver,
      required String message,
      required DateTime createdAt}) async {
    //send the query data to the 'send_message' namespace in the server
    socket.emit('send_message', {
      "senderChatID": _logInUserData.id,
      "receiverChatID": receiver,
      "content": message,
      "createdAt": createdAt.toIso8601String(),
    });
  }
}
