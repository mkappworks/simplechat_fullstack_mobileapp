import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/search/search_controller.dart';

import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/view/message/components/message_search_bar.dart';

import 'package:flutter_frontend/view/message/components/message_text_field.dart';
import 'package:flutter_frontend/view/message/components/message_app_bar.dart';

import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/view/message/components/message_view.dart';
import 'package:get/get.dart';

class MessageBody extends StatelessWidget {
  final User user;
  final SearchController _searchController = Get.put(SearchController());

  MessageBody({required this.user});

  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);

    return SafeArea(
      child: Container(
        child: Column(
          children: [
            // MessageAppBar(user: user),
            Obx(() {
              return (_searchController.getSearchBarStatus.value ==
                      SearchBarStatus.notLoaded)
                  ? MessageAppBar(user: user)
                  : MessageSearchBar();
            }),
            MessageView(receiverID: user.id),
            MessageTextField(user: user)
          ],
        ),
      ),
    );
  }
}
