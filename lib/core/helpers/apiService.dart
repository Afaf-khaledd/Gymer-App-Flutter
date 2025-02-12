import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._privateConstructor();
  late Dio dio;

  factory ApiService() {
    return _instance;
  }

  ApiService._privateConstructor() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.1.9:3000/api/",
        //baseUrl: "http://10.0.2.2:3000/api/",
        //connectTimeout: Duration(seconds: 30),
        //receiveTimeout: Duration(seconds: 30),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }

  Future<Response> post(String endpoint,
      {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      return await dio.post(endpoint,
          data: data, options: Options(headers: headers));
    } catch (e) {
      throw Exception("POST API Error: $e");
    }
  }
}
