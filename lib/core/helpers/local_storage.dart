import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/Authentication/data/models/userModel.dart';

class LocalStorage {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }
  static Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }
  static Future<void> removeToken() async {
    await _secureStorage.delete(key: 'token');
  }

  static Future<void> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user.encode());
  }
  static Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    return userData != null ? UserModel.decode(userData) : null;
  }
  static Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  // remember me!

}
