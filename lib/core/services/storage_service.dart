// import 'package:shared_preferences/shared_preferences.dart';
//
// class StorageService {
//   static late SharedPreferences _prefs;
//
//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//   static Future<void> saveUserRole(String role) async {
//     await _prefs.setString('selected_role', role);
//   }
//
//   static Future<String?> getUserRole() async {
//     return _prefs.getString('selected_role');
//   }
//
//   static Future<void> clearAll() async {
//     await _prefs.clear();
//   }
//
//   static Future<void> setLoginStatus(bool isLoggedIn) async {
//     await _prefs.setBool('is_logged_in', isLoggedIn);
//   }
//
//   static bool isLoggedIn() {
//     return _prefs.getBool('is_logged_in') ?? false;
//   }
//
//
// }

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUserRole(String role) async {
    await _prefs.setString('selected_role', role);
  }

  static Future<String?> getUserRole() async {
    return _prefs.getString('selected_role');
  }

  static Future<void> setLoginStatus(bool isLoggedIn) async {
    await _prefs.setBool('is_logged_in', isLoggedIn);
  }

  static bool isLoggedIn() {
    return _prefs.getBool('is_logged_in') ?? false;
  }

  static Future<void> setRegisterStatus(bool isRegistered) async {
    await _prefs.setBool('is_registered', isRegistered);
  }

  static Future<void> setLoginRegisterStatus(bool value) async {
    await _prefs.setBool('is_Loginregistered', value);
  }

  static Future<bool> getLoginRegisterStatus() async {
    return _prefs.getBool('is_Loginregistered') ?? false;
  }


  static bool isRegistered() {
    return _prefs.getBool('is_registered') ?? false;
  }

  static Future<void> setProfileCompleted(bool isDone) async {
    await _prefs.setBool('profile_completed', isDone);
  }

  static bool isProfileCompleted() {
    return _prefs.getBool('profile_completed') ?? false;
  }

  static bool isMentoringSetup() {
    return _prefs.getBool('mentoring_setupScreen') ?? false;
  }

  static Future<void> setMentoringSetup(bool value) async {
    await _prefs.setBool('mentoring_setupScreen', value);
  }



// ✅ GETTER: Check if mentoring setup is completed
//   static bool isMentoringSetup() {
//     return _prefs.getBool('mentoring_setupScreen') ?? false;
//   }

// // ✅ SETTER: Mark mentoring setup as completed
//   static Future<void> setMentoringSetup(bool isDone) async {
//     await _prefs.setBool('mentoring_setupScreen', isDone);
//   }

  static Future<void> setisMentoringSetupCompleted(bool isDone) async {
    await _prefs.setBool('profile_completed', isDone);
  }


  static Future<void> setDocumentsUploaded(bool isUploaded) async {
    await _prefs.setBool('documents_uploaded', isUploaded);
  }

  static bool isDocumentsUploaded() {
    return _prefs.getBool('documents_uploaded') ?? false;
  }

  static Future<void> setBankDetailsUpdated(bool isUpdated) async {
    await _prefs.setBool('bank_updated', isUpdated);
  }

  static bool isBankDetailsUpdated() {
    return _prefs.getBool('bank_updated') ?? false;
  }

  static Future<void> clearAll() async {
    await _prefs.clear();
  }

  static Future<void> setPhone(String phone) async {
    await _prefs.setString('user_phone', phone);
  }

  static String? getPhone() {
    return _prefs.getString('user_phone');
  }

  static Future<void> setEmail(String email) async {
    await _prefs.setString('user_email', email);
  }

  static String? getEmail() {
    return _prefs.getString('user_email');
  }

  // Set registration status
  static Future<void> setRegistered(bool isRegistered) async {
    await _prefs.setBool('is_registered', isRegistered);
  }

// Set login status
  static Future<void> setIsLoggedIn(bool isLoggedIn) async {
    await _prefs.setBool('is_logged_in', isLoggedIn);
  }

  static Future<void> setWalkthroughCompleted(bool isCompleted) async {
    await _prefs.setBool('walkthrough_completed', isCompleted);
  }

  static bool isWalkthroughCompleted() {
    return _prefs.getBool('walkthrough_completed') ?? false;
  }



}
