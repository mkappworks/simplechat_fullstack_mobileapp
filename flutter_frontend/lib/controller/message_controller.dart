import 'package:get/get.dart';

import 'package:flutter_frontend/model/message.dart';

import 'package:flutter_frontend/controller/helper/service_manager.dart';

enum MessageStatus { loading, loaded, empty }

class MessageController extends GetxController {
  MessageStatus messageStatus = MessageStatus.empty;
  RxList<Message> messageList = <Message>[].obs;

//Getx Controller Function to get message(s) of a given receiver user from the messageList
  Future<void> fetchMessage(String receiverID) async {
    messageStatus = MessageStatus.loading;

    var messages = await ServiceManager().fetchMessageList(receiverID);

//TODO: NEED to update messageList MessageController
    // this.messageList =
    //     (messages.map((messageElement) => Message(message: messageElement)))
    //         as RxList<Message>;

    if (messageList.isNotEmpty) {
      messageStatus = MessageStatus.loaded;
    } else {
      messageStatus = MessageStatus.empty;
    }
    update();
  }

//TODO: NEED to update addMessage function in MessageController
//Getx Controller Function to add message of a given receiver user to the messageList
   void addMessage({required String message, required bool isMy}) {
  //   messageList.add(
  //     Message(
  //       message: Message(
  //         message: message,
  //         isMy: isMy,
  //         createdAt: DateTime.now().toString(),
  //       ),
  //     ),
  //   );
  //   messageStatus = MessageStatus.loaded;

  //   update();
   }
}
