import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

/// Route Helper class for convenient navigation using GetX
/// Follows GetX best practices for navigation management
class RouteHelper {
  // Private constructor to prevent instantiation
  RouteHelper._();

  /// Authentication Navigation Methods
  static void goToSplash() => Get.offAllNamed(RoutesName.splash);
  static void goToWalkthrough() => Get.toNamed(RoutesName.walk);
  static void goToUserSelection() => Get.toNamed(RoutesName.userSelection);
  static void goToLogin() => Get.toNamed(RoutesName.login);
  static void goToRegister() => Get.toNamed(RoutesName.register);
  static void goToForgotPassword() => Get.toNamed(RoutesName.forgotPassword);
  static void goToResetPassword() => Get.toNamed(RoutesName.resetPassword);
  static void goToOtpVerification() => Get.toNamed(RoutesName.otpVerification);

  /// Profile Setup Navigation Methods
  static void goToSetupProfile() => Get.toNamed(RoutesName.setupProfileImg);
  static void goToProfileSetupInfo() => Get.toNamed(RoutesName.profileSetupInfo);
  static void goToMentoringSetup() => Get.toNamed(RoutesName.mentoringSetup);
  static void goToBankDetails() => Get.toNamed(RoutesName.bankDetails);
  static void goToVerifyDocuments() => Get.toNamed(RoutesName.verifyDocuments);

  /// Main Navigation
  static void goToNavigation() => Get.offAllNamed(RoutesName.navigation);

  /// Mentor Navigation Methods
  static void goToMentorHome() => Get.toNamed(RoutesName.mentorHome);
  static void goToMentorChat() => Get.toNamed(RoutesName.mentorChat);
  static void goToMentorSessions() => Get.toNamed(RoutesName.mentorSessions);
  static void goToSessionDetails({Map<String, dynamic>? arguments}) {
    Get.toNamed(RoutesName.sessionDetails, arguments: arguments);
  }
  static void goToMentorCourses() => Get.toNamed(RoutesName.mentorCourses);
  static void goToVideoDetail({Map<String, dynamic>? arguments}) {
    Get.toNamed(RoutesName.videoDetail, arguments: arguments);
  }

  /// Student Navigation Methods
  static void goToStudentHome() => Get.toNamed(RoutesName.studentHome);
  static void goToStudentCommunity() => Get.toNamed(RoutesName.studentCommunity);
  static void goToStudentLearning() => Get.toNamed(RoutesName.studentLearning);
  static void goToExploreLearning() => Get.toNamed(RoutesName.exploreLearning);
  static void goToMyLearning() => Get.toNamed(RoutesName.myLearning);
  static void goToStudentMentors() => Get.toNamed(RoutesName.studentMentors);
  static void goToExploreMentors() => Get.toNamed(RoutesName.exploreMentors);
  static void goToMentorsList({Map<String, dynamic>? arguments}) {
    Get.toNamed(RoutesName.mentorsList, arguments: arguments);
  }
  static void goToMentorsSearch() => Get.toNamed(RoutesName.mentorsSearch);
  static void goToProfileDetails({Map<String, dynamic>? arguments}) {
    Get.toNamed(RoutesName.profileDetails, arguments: arguments);
  }
  static void goToMySessions() => Get.toNamed(RoutesName.mySessions);
  static void goToChatDetails({Map<String, dynamic>? arguments}) {
    Get.toNamed(RoutesName.chatDetails, arguments: arguments);
  }

  /// Profile Navigation Methods
  static void goToProfile() => Get.toNamed(RoutesName.profile);
  static void goToStudentProfile() => Get.toNamed(RoutesName.studentProfile);
  static void goToSettings() => Get.toNamed(RoutesName.settings);
  static void goToEditProfileImage() => Get.toNamed(RoutesName.editProfileImage);
  static void goToEditProfile() => Get.toNamed(RoutesName.editProfile);
  static void goToEditBankDetails() => Get.toNamed(RoutesName.editBankDetails);
  static void goToEditMentorshipDetails() => Get.toNamed(RoutesName.editMentorshipDetails);
  static void goToEditCertifications() => Get.toNamed(RoutesName.editCertifications);

  /// Navigation with Parameters
  static void navigateWithArguments(String routeName, {Map<String, dynamic>? arguments}) {
    Get.toNamed(routeName, arguments: arguments);
  }

  /// Replace current route
  static void replaceWith(String routeName, {Map<String, dynamic>? arguments}) {
    Get.offNamed(routeName, arguments: arguments);
  }

  /// Clear stack and navigate
  static void clearStackAndNavigate(String routeName, {Map<String, dynamic>? arguments}) {
    Get.offAllNamed(routeName, arguments: arguments);
  }

  /// Go back
  static void goBack({dynamic result}) {
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back(result: result);
    }
  }

  /// Go back until specific route
  static void goBackUntil(String routeName) {
    Get.until((route) => route.settings.name == routeName);
  }

  /// Check if can go back
  static bool canGoBack() => Get.key.currentState?.canPop() ?? false;

  /// Get current route name
  static String? getCurrentRoute() => Get.currentRoute;

  /// Get route arguments
  static Map<String, dynamic>? getArguments() {
    return Get.arguments as Map<String, dynamic>?;
  }

  /// Get specific argument by key
  static T? getArgument<T>(String key) {
    final args = getArguments();
    return args?[key] as T?;
  }

  /// Navigation with transition (⚠ handled manually because toNamed no longer supports transition/duration)
  static void navigateWithTransition(
      Widget page, {
        Map<String, dynamic>? arguments,
        Transition transition = Transition.fade,
        Duration duration = const Duration(milliseconds: 300),
      }) {
    Get.to(
          () => page,
      arguments: arguments,
      transition: transition,
      duration: duration,
    );
  }

  /// Show bottom sheet with route
  static void showBottomSheetRoute(
      Widget bottomSheet, {
        bool isScrollControlled = false,
        bool isDismissible = true,
        bool enableDrag = true,
      }) {
    Get.bottomSheet(
      bottomSheet,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  /// Show dialog with route
  static Future<T?> showDialogRoute<T>(Widget dialog) {
    return Get.dialog<T>(dialog);
  }

  /// Role-based navigation helper
  static void navigateBasedOnRole(String userRole) {
    switch (userRole.toLowerCase()) {
      case 'student':
        goToStudentHome();
        break;
      case 'mentor':
        goToMentorHome();
        break;
      default:
        goToUserSelection();
        break;
    }
  }

  /// Authentication flow helper
  static void handleAuthenticationFlow(bool isLoggedIn, String? userRole) {
    if (isLoggedIn && userRole != null) {
      goToNavigation();
    } else {
      goToLogin();
    }
  }

  /// Onboarding flow helper
  static void handleOnboardingFlow(bool hasSeenWalkthrough) {
    if (hasSeenWalkthrough) {
      goToLogin();
    } else {
      goToWalkthrough();
    }
  }
}
