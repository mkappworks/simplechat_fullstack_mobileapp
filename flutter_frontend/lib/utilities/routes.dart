import 'package:flutter/widgets.dart';

import 'package:flutter_frontend/login/login_screen.dart';
import 'package:flutter_frontend/users/users_screen.dart';
import 'package:flutter_frontend/message/message_screen.dart';

// Use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  UsersScreen.routeName: (context) => UsersScreen(),
  MessageScreen.routeName: (context) => MessageScreen(),
};
