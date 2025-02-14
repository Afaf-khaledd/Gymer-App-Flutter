import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:gymer/features/Authentication/presentation/views/resetPasswordScreen.dart';
//import 'package:uni_links/uni_links.dart';

class DeepLinking {
  static StreamSubscription<String?>? _sub;
  static late AppLinks appLinks;

  /// Initialize deep link listener
  static void initialize(BuildContext context) {
    appLinks = AppLinks();

    // Listen for incoming deep links
    appLinks.uriLinkStream.listen((Uri? link) {
      if (link != null) {
        Uri uri = link;
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
