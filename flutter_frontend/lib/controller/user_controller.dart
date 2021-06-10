import 'package:get/get.dart';

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/controller/helper/service_manager.dart';

enum ListStatus { loading, loaded, empty }

class UserController extends GetxController {
  Rx<ListStatus> _status = ListStatus.loading.obs;
  RxList<User> _usersList = <User>[].obs;
  late Map<String, dynamic> _completeMessage;
  late User _loggedInUser;

  //GetX Controller function to get the User logged in the database
  Future<void> setLoggedUser(Map<String, dynamic> userData) async {
    var _completeMessageValue = await ServiceManager().login(userData);
    var _userValue = await ServiceManager().getUserInfoFromLocale();
    if (_userValue != null) {
      _loggedInUser = _userValue;
      _completeMessage = _completeMessageValue;
    }
    update();
  }

//GetX Controller function to get the User logged in the database
  Future<void> setLogoutUser() async {
    _status.value = ListStatus.loading;
    await ServiceManager().logout(_loggedInUser);
    _usersList.clear();
    _completeMessage.clear();
    update();
  }

  //GetX Controller function to get the all Users logged in the database
  Future<void> setUsersList() async {
    _status.value = ListStatus.loading;
    _usersList.assignAll(await ServiceManager().fetchUserList());

    print('_userList : $_usersList');

    if (_usersList.isEmpty) {
      _status.value = ListStatus.empty;
    } else {
      _status.value = ListStatus.loaded;
    }

    print('status at MessageController.setUserList : $_status');
    update();
  }

  Rx<ListStatus> get getStatus => _status;
  RxList<User> get getUsersList => _usersList;
  Map<String, dynamic> get getCompletionMessage => _completeMessage;
  User get getLoggedInUser => _loggedInUser;
}
