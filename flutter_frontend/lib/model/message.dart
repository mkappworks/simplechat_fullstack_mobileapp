class Message {
  // late String senderId;
  // late String receiverId;
  late String message;
  late bool isMy;
  late String createdAt;

  Message(
      {
      // required this.senderId,
      // required this.receiverId,
      required this.message,
      required this.isMy,
      required this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "";
    isMy = json['isMy'];
    createdAt = json['createdAt'];
  }
}
