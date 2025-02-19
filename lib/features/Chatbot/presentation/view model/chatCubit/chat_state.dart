part of 'chat_cubit.dart';

abstract class ChatState {}
class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatFailure extends ChatState {
  final String error;
  ChatFailure(this.error);
}

class ChatSessionsLoaded extends ChatState {
  final List<ChatSessionModel> sessions;
  ChatSessionsLoaded(this.sessions);
}

class NoChatSessions extends ChatState {}

class ChatCreateLoading extends ChatState {}

class ChatCreateSuccess extends ChatState {
  final ChatSessionModel newSession;
  ChatCreateSuccess(this.newSession);
}
class ChatCreateFailure extends ChatState {
  final String error;
  ChatCreateFailure(this.error);
}

class ChatHistoryLoaded extends ChatState {
  final List<MessageModel> messages;
  ChatHistoryLoaded(this.messages);
}

class ChatbotLoadingRes extends ChatState {
  final List<MessageModel> messages;
  ChatbotLoadingRes(this.messages);
}

class SendMessageSuccess extends ChatState {
  final List<MessageModel> messages;
  SendMessageSuccess(this.messages);
}