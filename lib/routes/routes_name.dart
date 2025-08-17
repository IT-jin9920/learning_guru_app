import 'package:get/get.dart';
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
    GetPage(name: RoutesName.userSelection, page: () => const UserSelectionScreen()),

    GetPage(name: RoutesName.login, page: () => const LoginScreen()),
    GetPage(name: RoutesName.register, page: () => const RegisterScreen()),

    GetPage(name: RoutesName.home, page: () => const HomeScreen()),
    GetPage(name: RoutesName.courses, page: () => const CoursePage()),
    GetPage(name: RoutesName.courseDetail, page: () => const VideoDetailPage()),
    GetPage(name: RoutesName.sessions, page: () => const SessionPage()),
   // GetPage(name: RoutesName.chat, page: () => const ChatPage()),
    GetPage(name: RoutesName.profile, page: () => const ProfilePage()),
    GetPage(name: RoutesName.settings, page: () => SettingsScreen()),

    GetPage(name: RoutesName.navigation, page: () => const BottomNavigationPage()),
  ];
}
