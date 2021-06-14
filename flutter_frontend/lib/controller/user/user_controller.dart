import 'package:get/get.dart';

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/controller/helper/local_storage_helper.dart';
import 'package:flutter_frontend/controller/user/helper/user_service_helper.dart';

enum ListStatus { loading, loaded, empty }

class UserController extends GetxController {
  Rx<ListStatus> _status = ListStatus.loading.obs;
  RxList<User> _usersList = <User>[].obs;
  late Map<String, dynamic> _completeMessage;
  late User _loggedInUser;

  //GetX Controller function to get the User logged in the database
  Future<void> setLoggedUser(Map<String, dynamic> userData) async {
    _completeMessage = await UserServiceHelper.shared.login(userData);
    var _userValue = await LocalStorageHelper.shared.getUserInfoFromLocale();

    if (_userValue != null) {
      _loggedInUser = _userValue;
    }
    update();
  }

  //GetX Controller function to delete the User that is logging out, from database
  Future<void> setLogoutUser() async {
    _status.value = ListStatus.loading;
    await UserServiceHelper.shared.logout(_loggedInUser);
    _usersList.clear();
    _completeMessage.clear();
    update();
  }

  //GetX Controller function to get the all Users logged in the database (except the current user) and assign it to _userList
  Future<void> setUsersList() async {
    _status.value = ListStatus.loading;
    _usersList
        .assignAll(await UserServiceHelper.shared.fetchUserList(_loggedInUser));

    (_usersList.isEmpty)
        ? _status.value = ListStatus.empty
        : _status.value = ListStatus.loaded;

    update();
  }

  //GetX Controller function to set new Users logged in to the socket room
  Future<void> setNewUserListFromSocket(List<User> userList) async {
    _status.value = ListStatus.loading;
    _usersList.assignAll(userList);

    (_usersList.isEmpty)
        ? _status.value = ListStatus.empty
        : _status.value = ListStatus.loaded;

    update();
  }

  //gets the ListStatus
  Rx<ListStatus> get getStatus => _status;
  //get the all logged in user list in db (except the current _loggedInUser)
  RxList<User> get getUsersList => _usersList;
  //gets a message containing {'status': bool, 'message': String};
  Map<String, dynamic> get getCompletionMessage => _completeMessage;
  //gets user details of _loggedInUser in as a User() model
  User get getLoggedInUser => _loggedInUser;
}
