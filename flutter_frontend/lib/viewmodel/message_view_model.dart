import 'package:flutter_frontend/model/message.dart';

class MessageViewModel {
  Message _message;

  MessageViewModel({required Message message}) : this._message = message;

  String get content => _message.message;
  bool get isMy => _message.isMy;
  String get createdAt => _message.createdAt;
}