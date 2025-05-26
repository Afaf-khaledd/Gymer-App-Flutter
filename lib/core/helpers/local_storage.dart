import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // remember me!
  static Future<void> setRememberMe(bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', rememberMe);
  }

  static Future<bool?> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    final value = await prefs.getBool('remember_me');
    return value;
  }
  // questionnaire done
  static Future<void> setSubmitQuest(bool submit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('quest_submitted', submit);
  }
  static Future<bool?> getSubmitQuest() async {
    final prefs = await SharedPreferences.getInstance();
    final value = await prefs.getBool('quest_submitted');
    return value;
  }

  // checklist cleanup
  static Future<void> cleanupOldChecklists() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final today = DateTime.now();

    for (final key in keys) {
      if (key.startsWith('checklist_')) {
        final parts = key.split('_');
        if (parts.length == 4) {
          final y = int.tryParse(parts[1]);
          final m = int.tryParse(parts[2]);
          final d = int.tryParse(parts[3]);

          if (y != null && m != null && d != null) {
            final date = DateTime(y, m, d);
            if (date.isBefore(today.subtract(const Duration(days: 1)))) {
              await prefs.remove(key);
            }
          }
        }
      }
    }
  }
  static Future<void> printAllSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    if (keys.isEmpty) {
      log('SharedPreferences is empty.');
    } else {
      for (String key in keys) {
        final value = prefs.get(key);
        log("SharedPrefs Values:");
        log('Key: $key, Value: $value');
      }
      log("-------------------------------");
    }
  }


  static Future<void> clearStorage() async {
    await _secureStorage.deleteAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
