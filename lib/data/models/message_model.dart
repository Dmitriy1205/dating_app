class MessageModel {
  String? message;
  String? time;
  String? senderName;
  String? recipientName;
  String? chatId;

  MessageModel(
      {this.message,
      this.time,
      this.senderName,
      this.recipientName,
      this.chatId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    time = json['time'];
    senderName = json['senderName'];
    recipientName = json['recipientName'];
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'time': time,
        'senderName': senderName,
        'recipientName': recipientName,
        'chatId': chatId,
      };
}
