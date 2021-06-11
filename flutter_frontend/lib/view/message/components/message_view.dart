import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/helper/stream_controller_helper.dart';
import 'package:flutter_frontend/controller/message/message_controller.dart';
import 'package:flutter_frontend/view/message/components/message_unit.dart';

import 'package:get/get.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessageView extends StatefulWidget {
  final String receiverID;

  MessageView({required this.receiverID});

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  ScrollController _scrollController = ScrollController();
  late StreamSubscription<int> subscription;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final MessageController _messageController = Get.find();

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  getMessages() async {
    subscription = StreamControllerHelper.shared.stream.listen((index) {
      if (index > 1) {
        itemScrollController.scrollTo(
            index: index - 1, duration: Duration(milliseconds: 500));
      }
    });
    //await _messageController.fetchMessages(widget.receiverID);
    if (_messageController.getMessageStatus.value != MessageStatus.empty)
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        itemScrollController.jumpTo(
            index: _messageController.getMessageList.length - 1);
      });
  }

  @override
  void dispose() async {
    subscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_messageController.getMessageStatus.value != MessageStatus.empty &&
        MediaQuery.of(context).viewInsets.bottom > 0) {
      itemScrollController.scrollTo(
          index: _messageController.getMessageList.length - 1,
          duration: Duration(milliseconds: 200));
    }

    return Obx(() {
      switch (_messageController.getMessageStatus.value) {
        case MessageStatus.loading:
          return Flexible(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        case MessageStatus.loaded:
          return Flexible(
            child: ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              itemCount: _messageController.getMessageList.length,
              itemBuilder: (context, index) {
                return MessageUnit(
                    message: _messageController.getMessageList[index]);
              },
            ),
          );
        case MessageStatus.empty:
          return Flexible(
            child: Center(
              child: Text(
                'No Messages Found!',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          );
        default:
          return Container();
      }
    });
  }
}
