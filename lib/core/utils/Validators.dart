class Validators {
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full Name is required';
    }
    if (!RegExp(r'^[a-zA-Z\s]{3,50}$').hasMatch(value.trim())) {
      return 'Enter a valid full name (letters and spaces only, 3-50 characters)';
    }
    return null;
  }
  static String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full Name is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]{3,20}$').hasMatch(value.trim())) {
      return 'Enter a valid nickname (letters, numbers and underscores only, 3-20 characters)';
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validateEmailOrUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or Username is required';
    }
    bool isEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
    bool isUsername = RegExp(r'^[a-zA-Z0-9_]{3,20}$').hasMatch(value);
    if (!isEmail && !isUsername) {
      return 'Enter a valid email or username';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    return null;
  }
}