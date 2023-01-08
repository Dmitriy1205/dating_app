class MessageModel {
  String? message;
  String? time;
  String? senderName;
  String? recipientName;
  String? chatId;
  String? attachmentUrl;
  bool? isRead;
  String? messageId;

  MessageModel(
      {this.message,
      this.time,
      this.senderName,
      this.recipientName,
      this.chatId,
      this.attachmentUrl,
      this.isRead,
      this.messageId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    time = json['time'];
    senderName = json['senderName'];
    recipientName = json['recipientName'];
    chatId = json['chatId'];
    attachmentUrl = json['attachmentUrl'];
    isRead = json['isRead'];
    messageId = json['messageId'];
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'time': time,
        'senderName': senderName,
        'recipientName': recipientName,
        'chatId': chatId,
        'attachmentUrl': attachmentUrl,
        'isRead': false,
        'messageId': messageId,
      };
}
