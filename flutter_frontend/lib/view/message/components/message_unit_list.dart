import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:flutter_frontend/view/message/components/message_unit.dart';

import 'package:flutter_frontend/controller/message_controller.dart';

class MessageUnitList extends StatelessWidget {
  final MessageController _messageController = Get.put(MessageController());
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;

  MessageUnitList(
      {required this.itemScrollController,
      required this.itemPositionsListener});

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: _messageController.messageList.length,
        itemBuilder: (context, index) {
          return Obx(() => MessageUnit(
              isMy: _messageController.messageList[index].isMy,
              message: _messageController.messageList[index]));
        });
  }
}
