import 'package:flutter/widgets.dart';

// Use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  UserScreen.routeName: (context) => UsersScreen(),
  MessageScreen.routeName: (context) => MessageScreen(),
};
