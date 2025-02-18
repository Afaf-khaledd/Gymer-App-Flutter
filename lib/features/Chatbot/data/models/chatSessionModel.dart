import 'messageModel.dart';

class ChatSessionModel {
  final String sessionId;
  List<MessageModel> messages;

  ChatSessionModel({required this.sessionId, required this.messages});

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    return ChatSessionModel(
      sessionId: json['_id'] ?? json['sessionID'],
      messages: (json['chatHistory'] as List)
          .map((msg) => MessageModel.fromJson(msg))
          .toList(),
    );
  }
  @override
  String toString() {
    return 'ChatSessionModel{sessionId: $sessionId, chatHistory: ${messages.map((msg) => msg.toString()).join(', ')}}';
  }
}