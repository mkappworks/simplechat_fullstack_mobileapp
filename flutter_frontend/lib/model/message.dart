import 'dart:convert';

List<Message> messagesFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messagesToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    required this.message,
    required this.isMy,
    required this.createdAt,
  });

  final String message;
  final bool isMy;
  final String createdAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json["message"] ?? "",
        isMy: json["isMy"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isMy": isMy,
        "createdAt": createdAt,
      };
}
