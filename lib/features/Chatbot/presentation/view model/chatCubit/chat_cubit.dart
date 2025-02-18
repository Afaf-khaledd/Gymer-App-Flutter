import 'package:bloc/bloc.dart';
import 'package:gymer/features/Chatbot/data/models/chatSessionModel.dart';
import 'package:gymer/features/Chatbot/data/models/messageModel.dart';
import 'package:gymer/features/Chatbot/data/repository/chatRepo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;

  ChatCubit(this.chatRepository) : super(ChatInitial());

  List<ChatSessionModel> _chatSessions = [];
  ChatSessionModel? selectedSession;

  Future<void> loadLastSessions() async {
    emit(ChatLoading());
    try {
      _chatSessions = await chatRepository.getLastSessions();
      if (_chatSessions.isEmpty) {
        emit(NoChatSessions());
      } else {
        emit(ChatSessionsLoaded(List.from(_chatSessions)));
      }
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  Future<void> createChatSession() async {
    emit(ChatCreateLoading());
    try {
      final newSession = await chatRepository.createNewSession();
      _chatSessions.add(newSession);
      selectedSession = newSession;
      emit(ChatCreateSuccess(newSession));
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  void loadChatHistory(String sessionId) {
    selectedSession = _chatSessions.firstWhere((session) => session.sessionId == sessionId);
    emit(ChatHistoryLoaded(List.from(selectedSession!.messages)));
  }

  Future<void> sendMessage(String message) async {
    if (selectedSession == null) return;

    final userMessage = MessageModel(
      message: message,
      role: MessageRole.user,
    );
    List<MessageModel> updatedMessages = List.from(selectedSession!.messages);
    updatedMessages.add(userMessage);
    emit(SendMessageSuccess(updatedMessages));

    updatedMessages.add(MessageModel(message: 'Typing...', role: MessageRole.bot));
    emit(ChatbotLoadingRes(updatedMessages));

    try {
      final botResponse = await chatRepository.sendMessage(message,selectedSession!.sessionId);
      MessageModel res = MessageModel(message: botResponse.message, role: MessageRole.bot, video: botResponse.video);

      updatedMessages.removeWhere((msg) => msg.message == 'Typing...');
      updatedMessages.add(res);

      selectedSession!.messages.addAll([userMessage, res]);

      emit(SendMessageSuccess(updatedMessages));
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }
}

