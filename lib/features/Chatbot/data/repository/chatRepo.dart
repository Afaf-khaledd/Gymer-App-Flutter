import 'package:dio/dio.dart';
import 'package:gymer/features/Chatbot/data/models/messageModel.dart';
import 'package:gymer/features/Chatbot/data/models/responseModel.dart';

import '../../../../core/helpers/apiService.dart';
import '../../../../core/helpers/local_storage.dart';
import '../models/chatSessionModel.dart';

class ChatRepository {
  final ApiService apiService;

  ChatRepository({required this.apiService});

  String _handleError(dynamic error) {
    try {
      if (error is DioException) {
        if (error.response != null &&
            error.response?.data is Map<String, dynamic>) {
          final errorData = error.response?.data;
          if (errorData != null && errorData.containsKey("message")) {
            return errorData["message"];
          }
        }
        return "Server error: ${error.response?.statusMessage ??
            'Unknown error'}";
      } else if (error is Map<String, dynamic> &&
          error.containsKey("message")) {
        return error["message"];
      } else if (error is String) {
        return error;
      }
    } catch (e) {
      return "Error parsing response. Please try again.";
    }
    return "An unexpected error occurred. Please try again.";
  }

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
        throw Exception(_handleError(response.data));
      }
    } on DioException catch (dioError) {
      throw Exception(_handleError(dioError));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<ResponseModel> sendMessage(String message,String sessionId) async {
    try {
      String? token = await LocalStorage.getToken();
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
        print('--------------------------------');
        print("res: ${data}");
        print('--------------------------------');
        return ResponseModel.fromJson(data);
      } else {
        throw Exception(_handleError(response.data));
      }
    } on DioException catch (dioError) {
      throw Exception(_handleError(dioError));
    } catch (e) {
      throw Exception("Unexpected error: $e");
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
        throw Exception(
            response.data['message'] ?? "Failed to retrieve user sessions");
      }
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }
}