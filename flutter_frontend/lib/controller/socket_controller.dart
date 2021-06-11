import 'package:get/get.dart';

import 'helper/socket_helper.dart';

class SocketController extends GetxController {
  final SocketHelper _socketHelper = SocketHelper();

  //connect to socket room
  Future<void> connectToSocket() async {
    await _socketHelper.connectSocket();
  }

  //disconnect from socket room
  Future<void> disconnectFromSocket() async {
    await _socketHelper.disconnectSocket();
  }

  Future<void> sendMessageToSocket(
      {required String receiver, required String message}) async {
    _socketHelper.sendMessage(receiver: receiver, message: message);
  }
}
