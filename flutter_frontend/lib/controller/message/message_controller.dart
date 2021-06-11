import 'package:flutter_frontend/controller/socket_controller.dart';
import 'package:get/get.dart';

import 'package:flutter_frontend/model/message.dart';

import 'package:flutter_frontend/controller/helper/stream_controller_helper.dart';
import 'package:flutter_frontend/controller/helper/service_manager.dart';

enum MessageStatus { loading, loaded, empty }

class MessageController extends GetxController {
  final SocketController _socketController = Get.find();

  Rx<MessageStatus> _messageStatus = MessageStatus.empty.obs;
  RxList<Message> _messageList = <Message>[].obs;

//Getx Controller Function to get message(s) of a given receiver user from the messageList
  Future<void> fetchMessage(String receiverID) async {
    _messageStatus.value = MessageStatus.loading;

    _messageList.assignAll(await ServiceManager().fetchMessageList(receiverID));

    if (_messageList.isNotEmpty) {
      _messageStatus.value = MessageStatus.loaded;
    } else {
      _messageStatus.value = MessageStatus.empty;
    }
    update();
  }

//Getx Controller Function to send message intended to a given receiver user
  Future<void> sendMessage(
      {required String receiver, required String message}) async {
    addMessage(message: message, isMy: true);

    StreamControllerHelper().setLastIndex(getMessageList.length);

    await _socketController.sendMessageToSocket(
        receiver: receiver, message: message);
  }

//Getx Controller Function to add message of a given receiver user to the messageList
  void addMessage({required String message, required bool isMy}) {
    Message currentMessage = Message(
        message: message, isMy: isMy, createdAt: DateTime.now().toString());

    List<Message> _updatedMessageList = [..._messageList, currentMessage];

    _messageList.assignAll(_updatedMessageList);

    _messageStatus.value = MessageStatus.loaded;
    update();
  }

  Rx<MessageStatus> get getMessageStatus => _messageStatus;
  RxList<Message> get getMessageList => _messageList;
}
