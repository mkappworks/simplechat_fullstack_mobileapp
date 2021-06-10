import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_frontend/controller/message_controller.dart';
import 'package:flutter_frontend/controller/user_controller.dart';
import 'package:flutter_frontend/controller/helper/stream_controller_helper.dart';

import 'package:flutter_frontend/utilities/constants.dart';

class SocketHelper {
  MessageController _messageController = Get.find();
  UserController _userController = Get.find();
  late IO.Socket socket;
  var id;

  void connectSocket() async {
    //get the the id from local storage
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString('myID')!;

    //connect to the socket at KBaseURL
    socket = IO.io(kBaseURL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connection', (data) {
      print('connected');

      //forward the id of the logined user
      socket.emit('chatID', {'id': id});

      //listen to the receive_message socket to get the message content of other user (i.e. receiver)
      socket.on('receive_message', (data) {
        var content = data['content'].toString();

        //add the Message to the messageList in Getx MessageController class
        _messageController.addMessage(message: content, isMy: false);

        //set the Last index in the StreamControllerHelper
        StreamControllerHelper()
            .setLastIndex(_messageController.messageList.length);
      });
    });
  }

  //trigger when sending a message
  void sendMessage({required String receiver, required String message}) {
    _messageController.addMessage(message: message, isMy: true);

    StreamControllerHelper()
        .setLastIndex(_messageController.messageList.length);

    socket.emit('send_message', {
      "senderChatID": id,
      "receiverChatID": receiver,
      "content": message,
    });
  }
}
