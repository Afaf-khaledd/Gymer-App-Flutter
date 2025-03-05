import 'package:gymer/features/Chatbot/data/models/messageModel.dart';
import 'package:gymer/features/Chatbot/data/models/responseModel.dart';
import '../../../../core/helpers/apiService.dart';
import '../../../../core/helpers/error_handler.dart';
import '../../../../core/helpers/local_storage.dart';
import '../models/chatSessionModel.dart';

class ChatRepository {
  final ApiService apiService;

  ChatRepository({required this.apiService});

  Future<ChatSessionModel> createNewSession() async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) {
        throw Exception("Authentication error: Token is missing.");
      }

      final response = await apiService.post(
        "/aiorchestrator/createsession",
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {

        final data = response.data['data'];
        return ChatSessionModel(
          sessionId: data['sessionID'],
          messages: [
            MessageModel(
              message: data['response'],
              role: MessageRole.bot,
            ),
          ],
        );
      } else {
        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }

  Future<ResponseModel> sendMessage(String message,String sessionId) async {
    try {
      String? token = await LocalStorage.getToken();
      print('token: $token');
      if (token == null) {
        throw Exception("Authentication error: Token is missing.");
      }
      final response = await apiService.post(
        "/aiorchestrator/chat/$sessionId",
        data: {
          'message':message,
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
/*        print('--------------------------------');
        print("res: ${data}");
        print('--------------------------------');*/
        return ResponseModel.fromJson(data);
      } else {
        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }

  Future<List<ChatSessionModel>> getLastSessions() async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) throw Exception("No token found");

      final response = await apiService.get(
        "/aiorchestrator/sessions",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {

        final List<dynamic> sessionsData = response.data['data'];

        final sessions = sessionsData.map((session) {
          final chatSession = ChatSessionModel.fromJson(session);
          return chatSession;
        }).toList();

        return sessions;

      } else {
        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }
}