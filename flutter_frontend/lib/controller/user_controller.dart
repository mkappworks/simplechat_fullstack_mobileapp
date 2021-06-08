import 'package:get/get.dart';

import 'package:flutter_frontend/service/service_manager.dart';

import 'package:flutter_frontend/viewmodel/user_view_model.dart';

enum ListStatus { loading, loaded, empty }
enum UserStatus { online, offline }

class UserController extends GetxController {
  ListStatus status = ListStatus.loading;
  List<UserViewModel> userList = [];
  //online user are set to observable
  RxList<String> onlineUsers = <String>[].obs;

  //Getx Controller function to get the User logged in the database
  Future<void> fetchUser() async {
    var users = await ServiceManager().fetchUserList();
    this.userList = users.map((user) => UserViewModel(user: user)).toList();

    if (this.userList.isEmpty) {
      status = ListStatus.empty;
    } else {
      status = ListStatus.loaded;
    }
    update();
  }
}
