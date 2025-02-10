import 'dart:convert';

class UserModel {
  final String userId;
  final String fullName;
  final String userName;
  final String email;
  final String token;

  UserModel({
    required this.userId,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': userId,
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'token': token,
    };
  }

  String encode() => json.encode(toJson());

  static UserModel? decode(String? jsonString) {
    if (jsonString == null) return null;
    return UserModel.fromJson(json.decode(jsonString));
  }
}