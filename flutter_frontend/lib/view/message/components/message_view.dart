import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/search/search_controller.dart';
import 'package:flutter_frontend/controller/user/user_controller.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:flutter_frontend/controller/message/message_controller.dart';
import 'package:flutter_frontend/view/message/components/message_unit.dart';

class MessageView extends StatefulWidget {
  final String receiverID;

  MessageView({required this.receiverID});

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final MessageController _messageController = Get.find();
  final UserController _userController = Get.find();
  final SearchController _searchController = Get.find();

  bool _isWidgetTreeBuilt = false;
  bool _isReceiverIDLoggedIn = false;
  bool _isCurrentSearch = false;

  @override
  void initState() {
    super.initState();
    _startUpSequence();
  }

  _startUpSequence() async {
    _isWidgetTreeBuilt = false;
    //if the messages are loading - is the messages fetched from the db is not empty
    //then using a WidgetsBinding.instance?.addPostFrameCallback a  itemScrollController.jumpTo is excuted
    //the WidgetsBinding.instance?.addPostFrameCallback ensures that the jumpTo happens after the Widget tree is mounted
    if (_messageController.getMessageStatus.value == MessageStatus.loaded) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        itemScrollController.jumpTo(
            index: _messageController.getMessageList.length - 1);
      });
    }
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _isWidgetTreeBuilt = true;
      //if the receiverID is disconnected from the socket, the MessageScreen is popped
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _isReceiverIDLoggedIn = _userController.getUsersList
          .any((user) => user.id == widget.receiverID);

      if (!_isReceiverIDLoggedIn) Get.back();

      /*if the MessageStatus in the MessageController is not empty 
       and if the widget tree is built and if the MessageList length is more than 9
      the itemScrollController is activated to scroll the latest  MessageUnit 
      from outside the viewinset to bottom of viewinset
       */
      if (_messageController.getMessageStatus.value != MessageStatus.empty &&
          _isWidgetTreeBuilt &&
          _messageController.getMessageList.length > 9) {
        itemScrollController.scrollTo(
            index: _messageController.getMessageList.length - 1,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            alignment: 0.725);
      }
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
                return Obx(() => MessageUnit(
                      message: _messageController.getMessageList[index],
                      isCurrentSearch: (_searchController
                                  .getMessagePositionList.isNotEmpty &&
                              _searchController.getMessagePositionList[
                                      _searchController
                                          .getCurrentSelectMessageIndex
                                          .value] ==
                                  index)
                          ? true
                          : false,
                    ));
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
