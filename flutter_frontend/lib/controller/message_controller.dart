import 'package:get/get.dart';

import 'package:flutter_frontend/service/service_manager.dart';

import 'package:flutter_frontend/viewmodel/message_view_model.dart';
import 'package:flutter_frontend/model/message.dart';

enum MessageStatus { loading, loaded, empty }

class MessageController extends GetxController {
  MessageStatus messageStatus = MessageStatus.empty;
  RxList<MessageViewModel> messageList = <MessageViewModel>[].obs;

//Getx Controller Function to get message(s) of a given receiver user from the messageList
  Future<void> fetchMessage(String receiverID) async {
    messageStatus = MessageStatus.loading;

    var messages = await ServiceManager().fetchMessageList(receiverID);

    this.messageList = (messages
            .map((messageElement) => MessageViewModel(message: messageElement)))
        as RxList<MessageViewModel>;

    if (messageList.isNotEmpty) {
      messageStatus = MessageStatus.loaded;
    } else {
      messageStatus = MessageStatus.empty;
    }
    update();
  }

//Getx Controller Function to add message of a given receiver user to the messageList
  void addMessage({required String message, required bool isMy}) {
    messageList.add(
      MessageViewModel(
        message: Message(
          message: message,
          isMy: isMy,
          createdAt: DateTime.now().toString(),
        ),
      ),
    );
    messageStatus = MessageStatus.loaded;

    update();
  }
}
