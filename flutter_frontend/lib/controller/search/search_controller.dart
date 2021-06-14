import 'package:flutter_frontend/controller/message/message_controller.dart';
import 'package:flutter_frontend/model/message.dart';
import 'package:get/get.dart';

enum SearchBarStatus { notLoaded, Loaded }
enum SearchDirection { up, down }

class SearchController extends GetxController {
  MessageController _messageController = Get.find();
  Rx<SearchBarStatus> _searchBarStatus = SearchBarStatus.notLoaded.obs;
  RxList _messagePositionList = [].obs;
  RxInt _currentSelectMessageIndex = 0.obs;

//Getx Controller Function to change the SearchBarStatus:
//this will decide whether to render MessageSearchBar or MessageAppBar Widget
  void setSearchBarStatus() {
    (_searchBarStatus.value == SearchBarStatus.notLoaded)
        ? _searchBarStatus.value = SearchBarStatus.Loaded
        : _searchBarStatus.value = SearchBarStatus.notLoaded;

    update();
  }

  void setMessagePositionList(String searchValue) {
    if (searchValue != "") {
      List<Message> _messageList = [..._messageController.getMessageList];
      List _position = [];
      _messageList.forEach((element) {
        if (element.message.toLowerCase().contains(searchValue)) {
          _position.add(_messageList.indexOf(element));
        }
      });
      _messagePositionList.assignAll(_position);
      print(_messagePositionList);
    } else {
      _messagePositionList.clear();
    }
    _currentSelectMessageIndex.value = 0;
    update();
  }

  void setCurrentSelectMessagenIndex(SearchDirection value) {
    if (SearchDirection.up == value) {
      (_currentSelectMessageIndex <= 0)
          ? _currentSelectMessageIndex.value = _messagePositionList.length - 1
          : _currentSelectMessageIndex.value--;
    } else {
      (_currentSelectMessageIndex < _messagePositionList.length - 1)
          ? _currentSelectMessageIndex.value++
          : _currentSelectMessageIndex.value = 0;
    }
  }

  Rx<SearchBarStatus> get getSearchBarStatus => _searchBarStatus;
  RxList get getMessagePositionList => _messagePositionList;
  RxInt get getCurrentSelectMessageIndex => _currentSelectMessageIndex;
}
