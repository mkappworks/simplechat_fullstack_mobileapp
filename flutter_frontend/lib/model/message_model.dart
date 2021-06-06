class MessageModel {
  final String senderId;
  final String receiverId;
  final bool isMyMessage;
  final String message;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.isMyMessage,
    required this.message,
  });
}
