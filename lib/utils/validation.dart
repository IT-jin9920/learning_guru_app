class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'\d'));
    final hasSpecialChar =
    value.contains(RegExp(r'[!@#\$&*~%^().,_+=\-]'));

    if (!hasUppercase || !hasLowercase || !hasDigit || !hasSpecialChar) {
      return 'Include uppercase, lowercase, number & symbol';
    }

    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid 10-digit phone number';
    }

    return null;
  }


  //  Name Validator
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    if (value.trim().length > 50) {
      return 'Name must be under 50 characters';
    }
    return null;
  }


  // About Validator (max 300 words)
  static String? validateAbout(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please write something about you';
    }
    final wordCount = value.trim().split(RegExp(r'\s+')).length;
    if (wordCount > 300) {
      return 'About section should not exceed 300 words';
    }
    return null;
  }


  static String? validateBankName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Bank name is required';
    return null;
  }

  static String? validateAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'Account number is required';
    final regex = RegExp(r'^\d{9,18}$');
    if (!regex.hasMatch(value.trim())) return 'Enter a valid 9–18 digit number';
    return null;
  }

  static String? validateRoutingNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'Routing number is required';
    final regex = RegExp(r'^\d{9}$');
    if (!regex.hasMatch(value.trim())) return 'Routing number must be 9 digits';
    return null;
  }


  /// Course Name Validator
  static String? validateCourseName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Course name is required';
    }
    if (value.trim().length < 3) {
      return 'Course name must be at least 3 characters';
    }
    return null;
  }

  /// Course Category Validator
  static String? validateCourseCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Course category is required';
    }
    return null;
  }

  /// Course Price Validator
  static String? validateCoursePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Course price is required';
    }
    final price = double.tryParse(value.trim());
    if (price == null || price < 0) {
      return 'Enter a valid price';
    }
    return null;
  }

}
