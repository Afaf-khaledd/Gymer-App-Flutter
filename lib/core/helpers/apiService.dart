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
        //baseUrl: "http://10.0.2.2:3000/api/",
        baseUrl: "http://192.168.1.9:3000/api/",
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
    } on DioException catch (dioError) {
      //print("Dio Error: ${dioError.response?.statusCode} - ${dioError.response?.data}");
      throw dioError;
    } catch (e) {
      //print("Unknown API Error: $e");
      throw Exception("Unknown API error occurred.");
    }
  }

  Future<Response> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      return await dio.get(
        endpoint,
        options: Options(headers: headers),
      );
    } on DioException catch (dioError) {
      //print("Dio GET Error: ${dioError.response?.statusCode} - ${dioError.response?.data}");
      throw dioError;
    } catch (e) {
      //print("Unknown API Error: $e");
      throw Exception("Unknown API error occurred.");
    }
  }

  Future<Response> patch(String endpoint,
      {dynamic data, Map<String, String>? headers}) async {
    try {
      return await dio.patch(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (dioError) {
      //print("Dio PATCH Error: ${dioError.response?.statusCode} - ${dioError.response?.data}");
      throw dioError;
    } catch (e) {
      //print("Unknown API Error: $e");
      throw Exception("Unknown API error occurred.");
    }
  }

  Future<Response> put(String endpoint,
      {dynamic data, Map<String, String>? headers}) async {
    try {
      return await dio.put(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (dioError) {
      throw dioError;
    } catch (e) {
      throw Exception("Unknown API error occurred.");
    }
  }
}
