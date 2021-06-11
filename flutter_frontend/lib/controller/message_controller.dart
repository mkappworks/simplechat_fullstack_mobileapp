import 'package:get/get.dart';

import 'package:flutter_frontend/model/message.dart';

import 'package:flutter_frontend/controller/helper/service_manager.dart';

enum MessageStatus { loading, loaded, empty }

class MessageController extends GetxController {
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

//TODO:post message http
//Getx Controller Function to add message of a given receiver user to the messageList
  void addMessage({required String message, required bool isMy}) {
    _messageList.assign(
      Message(
        message: message,
        isMy: isMy,
        createdAt: DateTime.now().toString(),
      ),
    );

    _messageStatus.value = MessageStatus.loaded;
    update();
  }

  Rx<MessageStatus> get getMessageStatus => _messageStatus;
  RxList<Message> get getMessageList => _messageList;
}
