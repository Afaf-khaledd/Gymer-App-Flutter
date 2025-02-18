enum MessageRole { user, bot }

class MessageModel {
  final String message;
  final MessageRole role;
  final List<String>? video;

  MessageModel({required this.message, required this.role, this.video});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      role: json['role'] == 'User' ? MessageRole.user : MessageRole.bot,
      video: json['machineVideo'] != null && json['machineVideo'].isNotEmpty
          ? List<String>.from(json['machineVideo'])
          : null,
    );
  }
  @override
  String toString() {
    return 'Message{role: ${role == MessageRole.user ? "User" : "Chatbot"}, message: $message}';
  }
}