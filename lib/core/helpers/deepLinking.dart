import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gymer/features/Authentication/presentation/views/resetPasswordScreen.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinking {
  static StreamSubscription<String?>? _sub;

  /// Initialize deep link listener
  static void initialize(BuildContext context) {
    _sub = linkStream.listen((String? link) {
      if (link != null) {
        Uri uri = Uri.parse(link);
        if (uri.path == "/reset-password") {
          String? token = uri.queryParameters["token"];
          if (token != null) {
            _navigateToResetPasswordScreen(context, token);
          }
        }
      }
    }, onError: (err) {
      debugPrint("Deep link error: $err");
    });
  }

  /// Navigate to Reset Password Screen with token
  static void _navigateToResetPasswordScreen(
      BuildContext context, String token) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(token: token)),
    );
  }

  /// Cancel the stream when not needed
  static void dispose() {
    _sub?.cancel();
  }
}
