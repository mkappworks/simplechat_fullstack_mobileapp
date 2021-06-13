import 'package:get/get.dart';

import 'package:flutter_frontend/model/message.dart';

import 'package:flutter_frontend/controller/message/helper/message_service_helper.dart';
import 'package:flutter_frontend/controller/socket/socket_controller.dart';

enum MessageStatus { loading, loaded, empty }

class MessageController extends GetxController {
  final SocketController _socketController = Get.find();

  Rx<MessageStatus> _messageStatus = MessageStatus.empty.obs;
  RxList<Message> _messageList = <Message>[].obs;

//Getx Controller Function to get message(s) of a given receiver user from the messageList
  Future<void> fetchMessages(String receiverID) async {
    _messageStatus.value = MessageStatus.loading;

    _messageList.assignAll(
        await MessageServiceHelper.shared.fetchMessageList(receiverID));

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
    DateTime _createdAt = DateTime.now();

    addMessage(message: message, isMy: true, createdAt: _createdAt);

    await _socketController.sendMessageToSocket(
        receiver: receiver, message: message, createdAt: _createdAt);
  }

//Getx Controller Function to add message of a given receiver user to the messageList
  void addMessage(
      {required String message,
      required bool isMy,
      required DateTime createdAt}) {
    Message currentMessage =
        Message(message: message, isMy: isMy, createdAt: createdAt);

    List<Message> _updatedMessageList = [..._messageList, currentMessage];

    _messageList.assignAll(_updatedMessageList);

    _messageStatus.value = MessageStatus.loaded;
    update();
  }

  //GetX controller to reset the properties of the controller when the user logs out
  void resetProperties() {
    _messageList.clear();
    _messageStatus.value = MessageStatus.empty;
    update();
  }

  Rx<MessageStatus> get getMessageStatus => _messageStatus;
  RxList<Message> get getMessageList => _messageList;
}
