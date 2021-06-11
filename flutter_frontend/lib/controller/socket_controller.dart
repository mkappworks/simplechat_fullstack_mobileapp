import 'package:get/get.dart';

import 'package:flutter_frontend/controller/message_controller.dart';

import 'helper/socket_helper.dart';
import 'helper/stream_controller_helper.dart';

class SocketController extends GetxController {
  final MessageController _messageController = Get.find();
  final SocketHelper _socketHelper = SocketHelper();

  //connect to socket room
  Future<void> connectToSocket() async {
    await _socketHelper.connectSocket();
  }

  //disconnect from socket room
  Future<void> disconnectFromSocket() async {
    await _socketHelper.disconnectSocket();
  }

  Future<void> sendMessage(
      {required String receiver, required String message}) async {
    _messageController.addMessage(message: message, isMy: true);

    StreamControllerHelper()
        .setLastIndex(_messageController.getMessageList.length);

    await _socketHelper.sendMessage(
      receiver: receiver,
      message: message,
    );
  }
}
