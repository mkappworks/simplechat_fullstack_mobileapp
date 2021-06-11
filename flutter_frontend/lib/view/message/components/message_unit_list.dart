import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:flutter_frontend/view/message/components/message_unit.dart';

import 'package:flutter_frontend/controller/message_controller.dart';

class MessageUnitList extends StatelessWidget {
  final MessageController _messageController = Get.find();
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;

  MessageUnitList(
      {required this.itemScrollController,
      required this.itemPositionsListener});

  @override
  Widget build(BuildContext context) {
    //Still testing
       if (_messageController.getMessageStatus.value !=
        MessageStatus.empty && MediaQuery.of(context).viewInsets.bottom > 0) {
      itemScrollController.scrollTo(
          index: _messageController.getMessageList.length - 1,
          duration: Duration(milliseconds: 200));
    }
    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemCount: _messageController.getMessageList.length,
      itemBuilder: (context, index) {
        return Obx(
          () => MessageUnit(message: _messageController.getMessageList[index]),
        );
      },
    );
  }
}
