import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/authentication/bank_details_page/bank_details_page.dart';
import 'package:learning_guru_app/presentation/authentication/forgot_password/forgot_password_screen.dart';
import 'package:learning_guru_app/presentation/authentication/mentor_details/mentor_setup_page.dart';
import 'package:learning_guru_app/presentation/authentication/reset_password/reset_password_screen.dart';
import 'package:learning_guru_app/presentation/authentication/setup_your_profile/profile_setup_page.dart';
import 'package:learning_guru_app/presentation/authentication/setup_your_profile/setup_profile_page.dart';
import 'package:learning_guru_app/presentation/authentication/verify_documents_page.dart';
import 'package:learning_guru_app/presentation/mentor/course_screen/video_detail_page.dart';
import 'package:learning_guru_app/presentation/mentor/session_screen/session_page.dart';

import '../presentation/app_navigation/bottom_navigation_page.dart';
import '../presentation/authentication/login_screen/login_screen.dart';
import '../presentation/authentication/register_screen/register_screen.dart';
import '../presentation/authentication/splash_screen/splash_screen.dart';
import '../presentation/authentication/user_selection/SelectionScree.dart';
import '../presentation/authentication/walkthrough/walkthrough.dart';
import '../presentation/mentor/course_screen/course_page.dart';
import '../presentation/mentor/home_screen/mentro_home_page.dart';
import '../presentation/profile_screen/profile_page.dart';
import '../presentation/profile_screen/setting_page/settings/settings_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: RoutesName.splash, page: () => const SplashScreen()),
    GetPage(name: RoutesName.walk, page: () => const WalkthroughScreen()),
    GetPage(
      name: RoutesName.userSelection,
      page: () => const UserSelectionScreen(),
    ),

    GetPage(name: RoutesName.login, page: () => const LoginScreen()),
    GetPage(name: RoutesName.register, page: () => const RegisterScreen()),

    GetPage(name: RoutesName.home, page: () => const HomeScreen()),
    GetPage(name: RoutesName.courses, page: () => const CoursePage()),
    GetPage(name: RoutesName.courseDetail, page: () => const VideoDetailPage()),
    GetPage(name: RoutesName.sessions, page: () => const SessionPage()),
    //GetPage(name: RoutesName.chat, page: () => const ChatPage()),
    GetPage(name: RoutesName.profile, page: () => const ProfilePage()),
    GetPage(name: RoutesName.settings, page: () => SettingsScreen()),

    GetPage(name: RoutesName.setupProfileImg, page: () => SetupProfileScreen()),
    GetPage(name: RoutesName.bankDetails, page: () => BankDetailsPage()),
    GetPage(
      name: RoutesName.verifyDocuments,
      page: () => VerifyDocumentsPage(),
    ),

    GetPage(
      name: RoutesName.profileSetupInfo,
      page: () => const ProfileSetupPage(),
    ),
    GetPage(
      name: RoutesName.mentoringSetup,
      page: () => const MentoringSetupScreen(),
    ),

    GetPage(
      name: RoutesName.resetPassword,
      page: () => const ResetPasswordPage(),
    ),

    GetPage(
      name: RoutesName.forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),

    GetPage(
      name: RoutesName.navigation,
      page: () => const BottomNavigationPage(),
    ),
  ];
}
