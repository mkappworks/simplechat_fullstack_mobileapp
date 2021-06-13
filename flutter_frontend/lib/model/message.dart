import 'dart:convert';

List<Message> messagesFromJson(String str) => List<Message>.from(
    json.decode(str).map((message) => Message.fromJson(message)));

class Message {
  Message({
    this.id,
    required this.isMy,
    required this.message,
    required this.createdAt,
  });

  final String? id;
  final bool isMy;
  final String message;
  final DateTime createdAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      id: json["_id"] == null ? null : json["_id"],
      isMy: json["isMy"],
      message: json["message"],
      createdAt: DateTime.parse(json["createdAt"]));
}
