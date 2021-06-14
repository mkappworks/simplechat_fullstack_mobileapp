import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_frontend/controller/search/search_controller.dart';
import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MessageSearchBar extends HookWidget {
  final SearchController _searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);
    final _focusNode = useFocusNode();

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _searchController.setSearchBarStatus(),
                child: Icon(
                  CupertinoIcons.clear,
                  size: SizeConfig.defaultSize! * 3,
                ),
              ),
              Container(
                width: SizeConfig.defaultSize! * 20,
                child: TextField(
                    textAlign: TextAlign.left,
                    focusNode: _focusNode,
                    // controller: _searchTextEditingController,
                    onChanged: (value) {
                      if (value.trim().isNotEmpty && value.length > 3) {
                        _searchController
                            .setMessagePositionList(value.toLowerCase());
                      } else {
                        _searchController.setMessagePositionList("");
                      }
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: kSearchPlaceHolder)),
              ),
              Container(
                decoration: BoxDecoration(
                  color: kColorGrey.withOpacity(0.4),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                width: SizeConfig.defaultSize! * 10,
                child: Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                    child: Obx(() {
                      int _numberOfSearchResults =
                          _searchController.getMessagePositionList.length;
                      int _currentSelectMessageIndex =
                          _searchController.getCurrentSelectMessageIndex.value;
                      print(_numberOfSearchResults);

                      return Text(
                        _numberOfSearchResults > 0
                            ? '${_currentSelectMessageIndex + 1} of $_numberOfSearchResults'
                            : 'No Result',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontSize: 14,
                            color: kColorBlack,
                            fontWeight: FontWeight.bold),
                      );
                    }),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    _searchController
                        .setCurrentSelectMessagenIndex(SearchDirection.up);
                  },
                  child: Icon(
                    CupertinoIcons.up_arrow,
                    size: SizeConfig.defaultSize! * 3,
                  )),
              GestureDetector(
                  onTap: () {
                    _searchController
                        .setCurrentSelectMessagenIndex(SearchDirection.down);
                  },
                  child: Icon(
                    CupertinoIcons.down_arrow,
                    size: SizeConfig.defaultSize! * 3,
                  )),
            ],
          ),
        ),
        Divider(color: kColorGrey, thickness: 1),
      ],
    );
  }
}
