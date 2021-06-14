import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/controller/message/message_controller.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';

class MessageTextField extends HookWidget {
  final User user;
  final MessageController _messageController = Get.find();

  MessageTextField({required this.user});
  @override
  Widget build(BuildContext context) {
    final _focusNode = useFocusNode();
    final _messageTextEditingController = useTextEditingController();

    //initialise SizeConfig
    SizeConfig().init(context);

    return Column(
      children: [
        Divider(color: kColorGrey, thickness: 1),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.defaultSize! * 34,
                child: TextField(
                    textAlign: TextAlign.left,
                    focusNode: _focusNode,
                    controller: _messageTextEditingController,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: kMessagePlaceHolder)),
              ),
              GestureDetector(
                onTap: () async {
                  if (_messageTextEditingController.text.trim().isNotEmpty) {
                    await _messageController.sendMessage(
                      receiver: user.id,
                      message: _messageTextEditingController.text,
                    );
                    _messageTextEditingController.clear();
                  }
                },
                child: Container(
                  width: SizeConfig.defaultSize! * 5,
                  height: SizeConfig.defaultSize! * 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kColorLightBlue,
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.paperplane_fill,
                      size: SizeConfig.defaultSize! * 3,
                      color: kColorWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
