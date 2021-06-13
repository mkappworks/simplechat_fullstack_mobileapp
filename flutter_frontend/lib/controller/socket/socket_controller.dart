import 'package:get/get.dart';

import 'helper/socket_service_helper.dart';

class SocketController extends GetxController {
  //connect to socket room
  Future<void> connectToSocket() async {
    await SocketServiceHelper.shared.connectSocket();
  }

  //disconnect from socket room
  Future<void> disconnectFromSocket() async {
    await SocketServiceHelper.shared.disconnectSocket();
  }

  Future<void> sendMessageToSocket(
      {required String receiver, required String message, required DateTime createdAt }) async {
    SocketServiceHelper.shared
        .sendMessage(receiver: receiver, message: message, createdAt:createdAt);
  }
}
